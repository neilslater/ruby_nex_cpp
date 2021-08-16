# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rake/extensiontask'

desc 'Baz unit tests'
RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = 'spec/*_spec.rb'
  t.verbose = true
end

gemspec = Gem::Specification.load('baz.gemspec')
Rake::ExtensionTask.new do |ext|
  ext.name = 'baz'
  ext.source_pattern = '*.{c,cpp}'
  ext.ext_dir = 'ext/baz'
  ext.lib_dir = 'lib/baz'
  ext.gem_spec = gemspec
end

task default: %i[compile test]
