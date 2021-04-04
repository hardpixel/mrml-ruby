module MRML
  module Native
    extend FFI::Library

    LIBNAME = "mrml.#{FFI::Platform::LIBSUFFIX}".freeze
    LIBPATH = File.expand_path('..', __dir__).freeze

    ffi_lib File.expand_path(LIBNAME, LIBPATH)

    attach_function :to_title, :to_title, [:string], Result
    attach_function :to_preview, :to_preview, [:string], Result
    attach_function :to_html, :to_html, [:string], Result
    attach_function :free, :free_result, [Result], :void
  end
end
