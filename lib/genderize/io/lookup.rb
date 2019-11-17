# frozen_string_literal: true

module Genderize
  module Io
    class Lookup < Genderize::Io::Base

      RESPONSE_KEYS ||= %w[
        count country_id error language_id gender probability
      ].freeze

      def initialize(name, host: DEFAULT_HOST, country_id: nil, language_id: nil)
        super

        @data = {}
      end

      def determine
        return @data unless @request.nil?

        @request = generate_request
        @data = generate_data.merge(generate_rate_limits)
      end

      HEADER_KEYS.each do |key|
        define_method(key) { @data[key] }
      end

      RESPONSE_KEYS.each do |key|
        define_method(key) { @data[key] }
      end

      private

      def param_name
        "name=#{@name}"
      end

    end
  end
end
