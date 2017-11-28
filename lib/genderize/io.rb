# frozen_string_literal: true

require 'genderize/io/parser/json'

%w[version lookup].each do |file_name|
  require "genderize/io/#{file_name}"
end
