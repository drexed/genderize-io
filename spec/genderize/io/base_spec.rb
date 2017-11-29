# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Genderize::Io::Base do
  subject { Genderize::Io::Base.new('kim') }
  let(:genderizeio) { Genderize::Io::Base.new('kim', country_id: 'dk', language_id: 'en') }

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
      expect(subject.request).to eq(nil)
    end
  end

  describe '.param_country_id' do
    it 'returns nil' do
      expect(subject.send(:param_country_id)).to eq(nil)
    end

    it 'returns "&country_id=dk"' do
      expect(genderizeio.send(:param_country_id)).to eq('&country_id=dk')
    end
  end

  describe '.param_language_id' do
    it 'returns nil' do
      expect(subject.send(:param_language_id)).to eq(nil)
    end

    it 'returns "&language_id=en"' do
      expect(genderizeio.send(:param_language_id)).to eq('&language_id=en')
    end
  end

end
