# frozen_string_literal: true

module LetManager
  extend RSpec::SharedContext

  let(:json_data) do
    <<-DATA
      {
        "name":"kim",
        "gender":"female",
        "probability":"0.88",
        "count":3561
      }
    DATA
  end

  let(:response_data) do
    {
      'name' => 'kim',
      'gender' => 'female',
      'probability' => '0.88',
      'count' => 3561
    }
  end

  let(:response_hash) do
    {
      'name' => 'kim',
      'gender' => 'female',
      'probability' => 0.88,
      'count' => 3561
    }
  end

end
