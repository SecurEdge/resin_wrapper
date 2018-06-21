require "bundler/gem_tasks"
task :default => :test

require 'rake/testtask'

task default: %w[test]

task :test do
  ruby "test/device/*_test.rb"
end
