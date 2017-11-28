# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Genderize::Io::Parser::Json do
  subject { Genderize::Io::Parser::Json.new(json_data) }

  describe '.initialize' do
    it 'returns {}' do
      expect(subject.hash).to eq({})
    end
  end

  describe '.parse' do
    it 'returns :response_hash' do
      expect(Genderize::Io::Parser::Json.parse(json_data)).to eq(response_hash)
    end
  end

  describe '.parse' do
    it 'returns :response_hash' do
      subject.parse

      expect(subject.hash).to eq(response_hash)
    end
  end

end
