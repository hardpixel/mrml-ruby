module MRML
  class Result < FFI::AutoPointer
    class << self
      def release(ptr)
        Native.free(ptr)
      end
    end
  end
end
