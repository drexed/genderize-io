# frozen_string_literal: true

require 'typhoeus'

module Genderize
  module Io
    class Lookup

      DEFAULT_HOST ||= 'https://api.genderize.io'

      attr_reader :hash, :host, :name, :response

      def initialize(name, host: DEFAULT_HOST)
        @name = name
        @host = host
        @response = nil
        @hash = {}
      end

      def self.verify(name, host: DEFAULT_HOST)
        klass = new(name, host: host)
        klass.verify
        klass
      end

      def verify
        return @hash unless @response.nil?
        @response = Typhoeus.get(url).response_body
        @hash = Genderize::Io::Parser::Json.parse(@response) unless @response.nil?
      end

      def url
        return "#{@host}?name=#{@name}" if @name.is_a?(String)
        params = @name.map.with_index { |name, i| "name[#{i}]=#{name}" }.join('&')
        "#{@host}?#{params}"
      end

      def to_h
        @hash
      end

      def address
        @hash['address']
      end

    end
  end
end
