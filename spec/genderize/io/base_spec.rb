# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Genderize::Io::Base do
  let(:klass1) { described_class.new('kim') }
  let(:klass2) { described_class.new('kim', country_id: 'dk', language_id: 'en') }

  describe '.initialize' do
    it 'returns "kim"' do
      expect(klass1.name).to eq('kim')
    end

    it 'returns "https://api.genderize.io"' do
      expect(klass1.host).to eq('https://api.genderize.io')
    end

    it 'returns nil' do
      expect(klass1.country_id).to eq(nil)
      expect(klass1.language_id).to eq(nil)
      expect(klass1.request).to eq(nil)
    end
  end

  describe '.param_country_id' do
    it 'returns nil' do
      expect(klass1.send(:param_country_id)).to eq(nil)
    end

    it 'returns "&country_id=dk"' do
      expect(klass2.send(:param_country_id)).to eq('&country_id=dk')
    end
  end

  describe '.param_language_id' do
    it 'returns nil' do
      expect(klass1.send(:param_language_id)).to eq(nil)
    end

    it 'returns "&language_id=en"' do
      expect(klass2.send(:param_language_id)).to eq('&language_id=en')
    end
  end

end
