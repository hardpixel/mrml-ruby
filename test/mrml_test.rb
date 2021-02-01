require 'test_helper'

class MrmlTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MRML::VERSION
  end
end
