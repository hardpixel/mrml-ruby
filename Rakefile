require "bundler/gem_tasks"
require "rake/testtask"
require "thermite/tasks"

Thermite::Tasks.new

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :default => ['thermite:build', :test]
