# frozen_string_literal: true

module LetManager
  extend RSpec::SharedContext

  let(:json_data) do
    <<-DATA
      {
        "name":"peter",
        "gender":"male",
        "probability":"0.99",
        "count":796
      }
    DATA
  end

  let(:response_hash) do
    {
      'name' => 'peter',
      'gender' => 'male',
      'probability' => '0.99',
      'count' => 796
    }
  end

end
