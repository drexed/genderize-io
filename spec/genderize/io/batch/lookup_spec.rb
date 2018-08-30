# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Genderize::Io::Batch::Lookup do
  subject { Genderize::Io::Batch::Lookup.new(%w[kim jim]) }

  describe '.initialize' do
    it 'returns { ... }' do
      expect(subject.data).to eq({ 'rate_limits' => {},
                                   'responses' => [] })
    end
  end

  describe '.determine' do
    it 'returns populated data' do
      VCR.use_cassette('batch') do
        subject.determine

        expect(subject.data['rate_limits'].empty?).to eq(false)
        expect(subject.data['responses'].empty?).to eq(false)
      end
    end
  end

  describe '.url' do
    base_url = 'https://api.genderize.io?name[0]=kim&name[1]=jim'
    opts_url = 'https://api.genderize.io?api_key=xxx&name[0]=kim&name[1]=jim&country_id=dk&language_id=en'

    it "returns '#{base_url}'" do
      expect(subject.url).to eq(base_url)
    end

    it "returns '#{opts_url}'" do
      lookup = Genderize::Io::Batch::Lookup.new(%w[kim jim],
                                                host: 'https://api.genderize.io?api_key=xxx',
                                                country_id: 'dk',
                                                language_id: 'en')

      expect(lookup.url).to eq(opts_url)
    end
  end

  describe '.param_name' do
    it 'returns "name[0]=kim&name[1]=jim"' do
      expect(subject.send(:param_name)).to eq('name[0]=kim&name[1]=jim')
    end
  end

end
