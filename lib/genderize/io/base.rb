# frozen_string_literal: true

require 'agents'
require 'typhoeus'

module Genderize
  module Io
    class Base

      DEFAULT_HOST = 'https://api.genderize.io'
      HEADER_KEYS = %w[
        x_rate_limit_limit x_rate_limit_remaining x_rate_reset
      ].freeze

      attr_reader :country_id, :data, :host, :language_id, :name, :request

      def initialize(name, host: DEFAULT_HOST, country_id: nil, language_id: nil)
        @name = name
        @host = host
        @country_id = country_id
        @language_id = language_id
        @request = nil
      end

      def self.determine(name, host: DEFAULT_HOST, country_id: nil, language_id: nil)
        klass = new(name, host: host, country_id: country_id, language_id: language_id)
        klass.determine
        klass
      end

      def url
        connector = @host.include?('?') ? '&' : '?'
        "#{@host}#{connector}#{param_name}#{param_country_id}#{param_language_id}"
      end

      private

      def generate_data
        return if @request.nil?

        Genderize::Io::Parser::Json.parse(@request.response_body)
      end

      def generate_headers
        return if @request.nil?

        Genderize::Io::Parser::Header.parse(@request.response_headers)
      end

      def generate_rate_limits
        headers = generate_headers
        return if headers.nil?

        HEADER_KEYS.each_with_object({}) { |key, hash| hash[key] = headers.send(key).to_i }
      end

      def generate_request
        return @request unless @request.nil?

        Typhoeus::Config.user_agent = Agents.random_user_agent(:desktop)
        Typhoeus.get(url, accept_encoding: 'gzip,deflate')
      end

      def param_country_id
        "&country_id=#{@country_id}" unless @country_id.nil?
      end

      def param_language_id
        "&language_id=#{@language_id}" unless @language_id.nil?
      end

    end
  end
end
