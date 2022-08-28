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

module MRML
  class << self
    def to_title(template)
      call(:title, template)
    end

    def to_preview(template)
      call(:preview, template)
    end

    def to_html(template)
      call(:to_html, template)
    end

    private

    def call(method, template)
      return if template.nil?

      result = Template.new(template)
      result.send(method)
    end
  end
end
