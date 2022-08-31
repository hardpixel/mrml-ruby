# frozen_string_literal: true

require 'json'

module MRML
  # Template object implemented in Rust that can parse MJML templates.
  class Template
    class << self
      # @!method from_json(json)
      # A new instance of Template from JSON.
      # @!scope class
      # @param json [String]
      # @return [Template]
      # @raise [Error] if json has invalid format

      # A new instance of Template from Hash.
      # @param hash [Hash]
      # @return [Template]
      # @raise [Error] if hash has invalid format

      def from_hash(hash)
        from_json(JSON.generate(hash))
      end
    end

    # @!method initialize(mjml)
    # A new instance of Template.
    # @param mjml [String]
    # @return [Template]
    # @raise [Error] if mjml is not a valid template

    # @!attribute [r] title
    # Gets mj-title tag value.
    # @return [String]

    # @!attribute [r] preview
    # Gets mj-preview tag value.
    # @return [String]

    # @!method to_mjml
    # MJML representation of the template.
    # @return [String]

    # @!method to_json
    # JSON representation of the template.
    # @return [String]

    # @!method to_html
    # HTML representation of the template.
    # @return [String]

    # Hash representation of the template.
    # @return [Hash]

    def to_hash
      JSON.parse(to_json)
    end
  end
end
