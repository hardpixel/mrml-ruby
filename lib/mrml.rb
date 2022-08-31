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
    # @param template [String]
    # @return (see Template#to_html)
    # @raise (see Template#initialize)

    def to_html(template)
      call(:to_html, template)
    end

    # Render template as JSON.
    # @param template [String]
    # @return (see Template#to_json)
    # @raise (see Template#initialize)

    def to_json(template)
      call(:to_json, template)
    end

    # Render template as Hash.
    # @param template [String]
    # @return (see Template#to_hash)
    # @raise (see Template#initialize)

    def to_hash(template)
      call(:to_hash, template)
    end

    private

    def call(method, template)
      return if template.nil?

      result = Template.new(template)
      result.send(method)
    end
  end
end
