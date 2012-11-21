require "bundler/gem_tasks"

require 'rake/testtask'

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

# Default to spec.
task :default => :spec

Rake::TestTask.new do |test|
  test.test_files = FileList['spec/lib/wave/*_spec.rb']
  test.verbose = true
  # test.libs << 'lib' << 'test'
  # test.ruby_opts << "-rubygems"
  # test.pattern = 'test/**/*_test.rb'
  # test.verbose = true
end

