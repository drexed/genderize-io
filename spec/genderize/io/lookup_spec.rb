# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Genderize::Io::Lookup do
  subject { Genderize::Io::Lookup.new('kim') }
  let(:genderizeio) { Genderize::Io::Lookup.determine('kim') }

  describe '.initialize' do
    it 'returns {}' do
      expect(subject.data).to eq({})
    end
  end

  describe '.determine' do
    it 'returns true for count key' do
      expect(genderizeio.data.key?('count')).to eq(true)
    end
  end

  describe '.url' do
    base_url = 'https://api.genderize.io?name=kim'
    opts_url = 'https://api.genderize.io?api_key=xxx&name=kim&country_id=dk&language_id=en'

    it "returns '#{base_url}'" do
      expect(subject.url).to eq(base_url)
    end

    it "returns '#{opts_url}'" do
      lookup = Genderize::Io::Lookup.new('kim',
                                         host: 'https://api.genderize.io?api_key=xxx',
                                         country_id: 'dk',
                                         language_id: 'en')

      expect(lookup.url).to eq(opts_url)
    end
  end

  Genderize::Io::Lookup::HEADER_KEYS.each do |key|
    describe ".#{key}" do
      it 'returns nil' do
        expect(subject.send(key)).to eq(nil)
      end

      it 'returns an integer' do
        expect(genderizeio.send(key).is_a?(Integer)).to eq(true)
      end
    end
  end

  Genderize::Io::Lookup::RESPONSE_KEYS.each do |key|
    describe ".#{key}" do
      it 'returns nil' do
        expect(subject.send(key)).to eq(nil)
      end

      it "returns value in response_hash['#{key}']" do
        expect(genderizeio.send(key)).to eq(response_hash[key])
      end
    end
  end

  describe '.param_name' do
    it 'returns "name=kim"' do
      expect(subject.send(:param_name)).to eq('name=kim')
    end
  end

end
