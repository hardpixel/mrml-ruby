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

  spec.files         = Dir['LICENSE.txt', 'README.md', 'Cargo.toml', '{ext,lib,src}/**/*']
  spec.extensions    = ['ext/Rakefile']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thermite'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 13.0'
end
