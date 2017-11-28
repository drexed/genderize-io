# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Genderize::Io::Lookup do
  subject { Genderize::Io::Lookup.new('kim') }
  let(:genderizeio) { Genderize::Io::Lookup.verify('kim') }
  let(:genderizeio_batch) do
    Genderize::Io::Lookup.new(%w[kim jim], country_id: 'dk', language_id: 'en')
  end

  describe '.initialize' do
    it 'returns "kim"' do
      expect(subject.name).to eq('kim')
    end

    it 'returns "https://api.genderize.io"' do
      expect(subject.host).to eq('https://api.genderize.io')
    end

    it 'returns nil' do
      expect(subject.country_id).to eq(nil)
    end

    it 'returns nil' do
      expect(subject.language_id).to eq(nil)
    end

    it 'returns nil' do
      expect(subject.response).to eq(nil)
    end

    it 'returns {}' do
      expect(subject.hash).to eq({})
    end
  end

  # describe '.verify' do
  #   it 'returns :response_hash' do
  #     subject.verify
  #
  #     expect(subject.to_h).to eq(response_hash)
  #     expect(genderizeio.to_h).to eq(response_hash)
  #     expect(genderizeio_xml.to_h).to eq(response_hash)
  #   end
  #
  #   it 'returns :response_hash' do
  #     expect(genderizeio.verify).to eq(response_hash)
  #     expect(genderizeio_xml.verify).to eq(response_hash)
  #   end
  # end

  describe '.url' do
    json_url = 'https://api.genderize.io?name=kim'
    json_url_batch = 'https://api.genderize.io?name[0]=kim&name[1]=jim&country_id=dk&language_id=en'

    it "returns #{json_url}" do
      expect(subject.url).to eq(json_url)
      expect(genderizeio.url).to eq(json_url)
    end

    it "returns #{json_url_batch}" do
      expect(genderizeio_batch.url).to eq(json_url_batch)
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

  describe '.param_name' do
    it 'returns "?name=kim"' do
      expect(subject.send(:param_name)).to eq('?name=kim')
    end

    it 'returns "?name[0]=kim&name[1]=jim"' do
      expect(genderizeio_batch.send(:param_name)).to eq('?name[0]=kim&name[1]=jim')
    end
  end

  describe '.param_country_id' do
    it 'returns nil' do
      expect(subject.send(:param_country_id)).to eq(nil)
    end

    it 'returns "&country_id=dk"' do
      expect(genderizeio_batch.send(:param_country_id)).to eq('&country_id=dk')
    end
  end

  describe '.param_language_id' do
    it 'returns nil' do
      expect(subject.send(:param_language_id)).to eq(nil)
    end

    it 'returns "&language_id=en"' do
      expect(genderizeio_batch.send(:param_language_id)).to eq('&language_id=en')
    end
  end

end
