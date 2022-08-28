# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rake/extensiontask'

PLATFORM = %w[
  x86-linux x86_64-linux aarch64-linux
  x86-mingw32 x64-mingw-ucrt x64-mingw32
  x86_64-darwin arm64-darwin
]

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

Rake::ExtensionTask.new('mrml') do |ext|
  ext.lib_dir        = 'lib/mrml'
  ext.source_pattern = '*.{rs,toml}'
  ext.cross_compile  = true
  ext.cross_platform = PLATFORM
end

task default: %i[clobber compile test]
