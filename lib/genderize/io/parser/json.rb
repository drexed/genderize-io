# frozen_string_literal: true

require 'json'

module Genderize
  module Io
    module Parser
      class Json

        attr_reader :hash

        def initialize(data)
          @data = data
          @hash = {}
        end

        def self.parse(data)
          instance = new(data)
          instance.parse
          instance.hash
        end

        def parse
          @hash = JSON.parse(@data)
        end

      end
    end
  end
end
