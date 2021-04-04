require 'ffi'
require 'mrml/result'
require 'mrml/native'
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

      result = Native.send(method, template)
      result = result.read_string.force_encoding('UTF-8')

      raise Error, result if result.start_with?(Error.name)

      result
    end
  end
end
