# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Genderize::Io::Lookup do
  subject { Genderize::Io::Lookup.new('peter') }
  let(:genderizeio) { Genderize::Io::Lookup.verify('peter') }

  describe '.initialize' do
    it 'returns "peter"' do
      expect(subject.name).to eq('peter')
    end

    it 'returns "https://api.genderizeio.io"' do
      expect(subject.host).to eq('https://api.genderizeio.io')
    end

    it 'returns nil' do
      expect(subject.response).to eq(nil)
    end

    it 'returns {}' do
      expect(subject.hash).to eq({})
    end
  end

  describe '.verify' do
    it 'returns :response_hash' do
      subject.verify

      expect(subject.to_h).to eq(response_hash)
      expect(genderizeio.to_h).to eq(response_hash)
      expect(genderizeio_xml.to_h).to eq(response_hash)
    end

    it 'returns :response_hash' do
      expect(genderizeio.verify).to eq(response_hash)
      expect(genderizeio_xml.verify).to eq(response_hash)
    end
  end

  describe '.url' do
    json_url = 'https://api.genderizeio.io?name=peter'

    it "returns #{json_url}" do
      expect(subject.url).to eq(json_url)
      expect(genderizeio.url).to eq(json_url)
    end
  end

  describe '.to_h' do
    it 'returns {}' do
      expect(subject.to_h).to eq({})
    end

    it 'returns :response_hash' do
      expect(genderizeio.to_h).to eq(response_hash)
    end
  end

end
