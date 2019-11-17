# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Genderize::Io::Parser::Header do
  let(:header) { 'HTTP/1.1 200 OK\r\n' }
  let(:klass) { described_class.new(header) }

  describe '.initialize' do
    it 'returns []' do
      expect(klass.headers).to eq([])
    end

    it 'returns "HTTP/1.1 200 OK\r\n"' do
      expect(klass.response).to eq(header)
    end

    it 'returns true' do
      expect(klass.strict).to eq(true)
    end
  end

  describe '.parse' do
    it 'returns data via instance method' do
      klass.parse

      expect(klass.headers.empty?).to eq(false)
    end

    it 'returns data via class method' do
      expect(described_class.parse(header).headers.empty?).to eq(false)
    end
  end

  describe '.method_missing' do
    it 'returns "private"' do
      new_header = 'Cache-Control: private'

      expect(described_class.parse(new_header).cache_control).to eq('private')
    end
  end

  describe '.response_code' do
    it 'returns "200 OK"' do
      expect(described_class.parse(header).response_code).to eq('200 OK')
    end
  end

  describe '.version' do
    it 'returns "HTTP/1.1"' do
      expect(described_class.parse(header).version).to eq('HTTP/1.1')
    end
  end

end
