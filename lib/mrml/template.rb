# frozen_string_literal: true

require 'json'

module MRML
  class Template
    class << self
      def from_hash(hash)
        from_json(JSON.generate(hash))
      end
    end

    def to_hash
      JSON.parse(to_json)
    end
  end
end
