# frozen_string_literal: true

require 'typhoeus'
require 'user_agent_db'

module Genderize
  module Io
    class Lookup

      DEFAULT_HOST ||= 'https://api.genderize.io'
      RESPONSE_KEYS ||= %w[
        count country_id error language_id gender probability x_rate_limit_limit
        x_rate_limit_remaining x_rate_reset
      ].freeze

      attr_reader :country_id, :hash, :host, :language_id, :name, :response

      def initialize(name, host: DEFAULT_HOST, country_id: nil, language_id: nil)
        @name = name
        @host = host
        @country_id = country_id
        @language_id = language_id
        @response = nil
        @hash = {}
      end

      def self.verify(name, host: DEFAULT_HOST, country_id: nil, language_id: nil)
        klass = new(name, host: host, country_id: country_id, language_id: language_id)
        klass.verify
        klass
      end

      def verify
        return @hash unless @response.nil?

        Typhoeus::Config.user_agent = UserAgentDB.random
        @response = Typhoeus.get(url, accept_encoding: 'gzip,deflate')

        generate_hash
        generate_rate_limits
      end

      def url
        connector = @host.include?('?') ? '&' : '?'
        "#{@host}#{connector}#{param_name}#{param_country_id}#{param_language_id}"
      end

      def to_h
        @hash
      end

      RESPONSE_KEYS.each do |key|
        define_method(key) { @hash[key] }
      end

      private

      def generate_hash
        return if @response.response_body.nil?
        @hash = Genderize::Io::Parser::Json.parse(@response.response_body)
      end

      def generate_rate_limits
        return if @response.response_headers.nil?
        headers = Genderize::Io::Parser::Header.parse(@response.response_headers)
        RESPONSE_KEYS.last(3).each { |key| @hash[key] = headers.send(key).to_i }
      end

      def param_name
        return "name=#{@name}" unless @name.is_a?(Array)
        @name.map.with_index { |name, i| "name[#{i}]=#{name}" }.join('&')
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
