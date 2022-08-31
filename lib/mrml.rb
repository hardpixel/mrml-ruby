# frozen_string_literal: true

begin
  RUBY_VERSION =~ /(\d+\.\d+)/
  require "mrml/#{$1}/mrml"
rescue LoadError
  require 'mrml/mrml'
end

require 'mrml/error'
require 'mrml/template'
require 'mrml/version'

# Module that renders MJML templates into HTML/JSON using MRML,
# a reimplementation of the MJML markup language in Rust.
module MRML
  class << self
    # Render template as HTML.
    # @param mjml [String]
    # @return (see Template#to_html)
    # @raise (see Template#initialize)

    def to_html(mjml)
      return if mjml.nil?

      template = Template.new(mjml)
      template.to_html
    end

    # Render template as JSON.
    # @param mjml [String]
    # @return (see Template#to_json)
    # @raise (see Template#initialize)

    def to_json(mjml)
      return if mjml.nil?

      template = Template.new(mjml)
      template.to_json
    end

    # Render template as Hash.
    # @param mjml [String]
    # @return (see Template#to_hash)
    # @raise (see Template#initialize)

    def to_hash(mjml)
      return if mjml.nil?

      template = Template.new(mjml)
      template.to_hash
    end
  end
end
