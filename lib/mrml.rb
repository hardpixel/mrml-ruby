require 'ffi'
require 'mrml/version'

module MRML
  class Error < StandardError
  end

  class << self
    extend FFI::Library

    ffi_lib File.expand_path("mrml.#{FFI::Platform::LIBSUFFIX}", __dir__)

    attach_function :__to_title, :to_title, [:string], :string
    attach_function :__to_preview, :to_preview, [:string], :string
    attach_function :__to_html, :to_html, [:string], :string

    private :__to_title
    private :__to_preview
    private :__to_html

    def to_title(template)
      call(:__to_title, template)
    end

    def to_preview(template)
      call(:__to_preview, template)
    end

    def to_html(template)
      call(:__to_html, template)
    end

    private

    def call(method, template)
      return if template.nil?

      result = send(method, template)
      raise Error, result if result.start_with?('Error')

      result
    end
  end
end
