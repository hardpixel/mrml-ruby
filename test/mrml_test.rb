# frozen_string_literal: true

require 'test_helper'

class MrmlTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MRML::VERSION
  end

  def test_that_it_generates_title
    result = ::MRML::Template.new(valid_template)
    assert_equal 'Newsletter Title', result.title
  end

  def test_that_it_generates_preview
    result = ::MRML::Template.new(valid_template)
    assert_equal 'Newsletter Preview', result.preview
  end

  def test_that_it_generates_html
    result = ::MRML.to_html(valid_template)

    refute_match %r{</?mj.+?>}, result
    assert_match %r{</?body>}, result
    assert_match 'Hello World', result
  end

  def test_that_it_generates_json
    result = ::MRML.to_json(valid_template)
    assert_match '"type":"mjml"', result
  end

  def test_that_it_generates_hash
    result = ::MRML.to_hash(valid_template)

    assert_kind_of Hash, result
    assert_equal 'mjml', result['type']
  end

  def test_that_it_raises_an_exception
    assert_raises ::MRML::Error do
      ::MRML.to_html(invalid_template)
    end
  end

  private

  def valid_template
    @valid_template ||= File.read(
      File.join(__dir__, 'fixtures/valid.mjml')
    )
  end

  def invalid_template
    @invalid_template ||= File.read(
      File.join(__dir__, 'fixtures/invalid.mjml')
    )
  end
end
