module MRML
  class Result < FFI::AutoPointer
    class << self
      def release(ptr)
        Binding.free(ptr)
      end
    end
  end
end
