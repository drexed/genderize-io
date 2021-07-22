# frozen_string_literal: true

module Genderize
  module Io
    module Parser
      class Header

        attr_reader :headers, :response, :strict

        def initialize(response, strict: true)
          @response = response
          @strict = strict
          @headers = []
        end

        def self.parse(response, strict: true)
          instance = new(response, strict: strict)
          instance.parse
          instance
        end

        def parse
          @headers = @response.split(/\\r\\n|\n|\r/)
        end

        def method_missing(sym, *)
          detect_multi_value_keys(sym) || super
        end

        def respond_to_missing?(sym, *)
          detect_multi_value_keys(sym) || super
        end

        def response_code
          @headers[0].match(%r{HTTP/\d\.\d (\d{3}.*)})[1]
        end

        def version
          @headers[0].match(%r{HTTP/\d\.\d})[0]
        end

        private

        def detect_multi_value_keys(tag)
          tag = method_sym_to_http_pattern(tag)
          results = @headers.select { |val| val =~ /^#{tag}:/i }.map { |val| value_from(val) }
          results.size <= 1 ? results.first : results
        end

        def method_sym_to_http_pattern(sym)
          replacement = @strict ? '-' : '[-_]'
          sym.to_s.gsub('_', replacement)
        end

        def value_from(tag)
          val = tag.split(/:\s+/)[1]
          val =~ /^"(.*)"$/ ? Regexp.last_match(1) : val
        end

      end
    end
  end
end
