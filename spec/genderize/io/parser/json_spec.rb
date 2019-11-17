# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Genderize::Io::Parser::Json do
  let(:klass) { described_class.new(json_data) }

  describe '.initialize' do
    it 'returns {}' do
      expect(klass.hash).to eq({})
    end
  end

  describe '.parse' do
    it 'returns :response_hash via instance method' do
      klass.parse

      expect(klass.hash).to eq(response_data)
    end

    it 'returns :response_hash via class method' do
      expect(described_class.parse(json_data)).to eq(response_data)
    end
  end

end
