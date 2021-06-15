require 'test_helper'

class MrmlTest < Minitest::Test
  TPL_PATH = File.expand_path('templates', __dir__)

  def test_that_it_has_a_version_number
    refute_nil ::MRML::VERSION
  end

  def test_that_it_generates_title
    result = ::MRML.to_title(valid_template)
    assert_equal result, 'Newsletter Title'
  end

  def test_that_it_generates_preview
    result = ::MRML.to_preview(valid_template)
    assert_equal result, 'Newsletter Preview'
  end

  def test_that_it_generates_html
    result = ::MRML.to_html(valid_template)

    refute result.match?(%r{</?mj.+?>})
    assert result.match?(%r{</?body>})
    assert result.match?('Hello World')
  end

  def test_that_it_raises_an_exception
    assert_raises ::MRML::Error do
      ::MRML.to_html(invalid_template)
    end
  end

  private

  def valid_template
    @valid_template ||= File.read(File.join(TPL_PATH, 'valid.mjml'))
  end

  def invalid_template
    @invalid_template ||= File.read(File.join(TPL_PATH, 'invalid.mjml'))
  end
end
