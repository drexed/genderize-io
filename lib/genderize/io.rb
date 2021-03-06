# frozen_string_literal: true

%w[json header].each do |file_name|
  require "genderize/io/parser/#{file_name}"
end

%w[version base lookup].each do |file_name|
  require "genderize/io/#{file_name}"
  require "genderize/io/batch/#{file_name}" if file_name == 'lookup'
end
