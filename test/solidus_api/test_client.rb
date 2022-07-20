require "test_helper"

class TestClient < Minitest::Test
  def test_api_key
    client = SolidusApi::Client.new api_key: "key", api_endpoint: "https://localhost:4000/api"
    assert_equal "key", client.api_key
    assert_equal "https://localhost:4000/api", client.api_endpoint
  end
end
