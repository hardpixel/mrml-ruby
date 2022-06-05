require 'thermite/fiddle'

project_dir = File.dirname(File.dirname(__FILE__))

Thermite::Fiddle.load_module(
  'Init_mrml',
  cargo_project_path: project_dir,
  ruby_project_path: project_dir
)

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
