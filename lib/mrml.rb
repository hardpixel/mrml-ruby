require 'ffi'
require 'mrml/binding'
require 'mrml/error'
require 'mrml/version'

module MRML
  class << self
    def to_title(template)
      call(:to_title, template)
    end

    def to_preview(template)
      call(:to_preview, template)
    end

    def to_html(template)
      call(:to_html, template)
    end

    private

    def call(method, template)
      return if template.nil?

      result = Binding.send(method, template)
      raise Error, result if result.start_with?('Error')

      result
    end
  end
end
