# frozen_string_literal: true

require_relative 'lib/mrml/version'

Gem::Specification.new do |spec|
  spec.name          = 'mrml'
  spec.version       = MRML::VERSION
  spec.authors       = ['Jonian Guveli']
  spec.email         = ['jonian@hardpixel.eu']

  spec.summary       = 'Ruby wrapper for MRML Rust'
  spec.description   = 'Ruby wrapper for MRML, the MJML parser implementation in Rust.'
  spec.homepage      = 'https://github.com/hardpixel/mrml-ruby'
  spec.license       = 'MIT'

  spec.files         = Dir['ext/**/src/*.rs', 'ext/**/Cargo.{lock,toml}', '{ext,lib}/**/*.rb', '*.{md,txt}']
  spec.extensions    = Dir['ext/**/extconf.rb']
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.7'

  spec.add_runtime_dependency 'rb_sys'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake-compiler', '~> 1.2'
end
