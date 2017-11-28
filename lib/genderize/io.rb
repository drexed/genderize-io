# frozen_string_literal: true

%w[version].each do |file_name|
  require "genderize/io/#{file_name}"
end
