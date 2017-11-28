# frozen_string_literal: true

require 'typhoeus'

module Genderize
  module Io
    class Lookup

      DEFAULT_HOST ||= 'https://api.genderize.io'

      attr_reader :country_id, :hash, :host, :name, :response, :language_id

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
        @response = Typhoeus.get(url).response_body
        @hash = Genderize::Io::Parser::Json.parse(@response) unless @response.nil?
      end

      def url
        "#{@host}#{param_name}#{param_country_id}#{param_language_id}"
      end

      def to_h
        @hash
      end

      def address
        @hash['address']
      end

      private

      def param_name
        return "?name=#{@name}" unless @name.is_a?(Array)
        names = @name.map.with_index { |name, i| "name[#{i}]=#{name}" }.join('&')
        "?#{names}"
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
