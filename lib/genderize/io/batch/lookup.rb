# frozen_string_literal: true

module Genderize
  module Io
    module Batch
      class Lookup < Genderize::Io::Base

        def initialize(name, host: DEFAULT_HOST, country_id: nil, language_id: nil)
          super

          @data = { 'rate_limits' => {}, 'responses' => [] }
        end

        def determine
          return @data unless @request.nil?

          @request = generate_request
          @data['responses'] = generate_data
          @data['rate_limits'] = generate_rate_limits
        end

        private

        def param_name
          @name.map.with_index { |name, i| "name[#{i}]=#{name}" }.join('&')
        end

      end
    end
  end
end
