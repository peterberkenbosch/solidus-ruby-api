require "test_helper"

class SolidusApiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SolidusApi::VERSION
  end
end
