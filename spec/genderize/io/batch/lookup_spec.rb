# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Genderize::Io::Batch::Lookup do
  let(:klass) { described_class.new(%w[kim jim]) }

  describe '.initialize' do
    it 'returns { ... }' do
      expect(klass.data).to eq('rate_limits' => {}, 'responses' => [])
    end
  end

  describe '.determine' do
    it 'returns populated data' do
      VCR.use_cassette('batch') do
        klass.determine

        expect(klass.data['rate_limits'].empty?).to eq(false)
        expect(klass.data['responses'].empty?).to eq(false)
      end
    end
  end

  describe '.url' do
    base_url = 'https://api.genderize.io?name[0]=kim&name[1]=jim'
    opts_url = 'https://api.genderize.io?api_key=xxx&name[0]=kim&name[1]=jim&country_id=dk&language_id=en'

    it "returns '#{base_url}'" do
      expect(klass.url).to eq(base_url)
    end

    it "returns '#{opts_url}'" do
      lookup = described_class.new(
        %w[kim jim],
        host: 'https://api.genderize.io?api_key=xxx',
        country_id: 'dk',
        language_id: 'en'
      )

      expect(lookup.url).to eq(opts_url)
    end
  end

  describe '.param_name' do
    it 'returns "name[0]=kim&name[1]=jim"' do
      expect(klass.send(:param_name)).to eq('name[0]=kim&name[1]=jim')
    end
  end

end
