module MRML
  module Binding
    extend FFI::Library

    LIBNAME = "mrml.#{FFI::Platform::LIBSUFFIX}".freeze
    LIBPATH = File.expand_path('..', __dir__).freeze

    ffi_lib File.expand_path(LIBNAME, LIBPATH)

    attach_function :to_title, :to_title, [:string], :string
    attach_function :to_preview, :to_preview, [:string], :string
    attach_function :to_html, :to_html, [:string], :string
  end
end
