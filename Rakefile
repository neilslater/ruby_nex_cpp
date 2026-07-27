# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'fileutils'
require 'open3'
require 'rbconfig'
require 'rspec/core/rake_task'
require 'rake/extensiontask'
require 'shellwords'

desc 'Baz unit tests'
RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = 'spec/*_spec.rb'
  t.verbose = true
end

gemspec = Gem::Specification.load('baz.gemspec')
Rake::ExtensionTask.new do |ext|
  ext.name = 'baz'
  ext.source_pattern = '*.cpp'
  ext.ext_dir = 'ext/baz'
  ext.lib_dir = 'lib/baz'
  ext.gem_spec = gemspec
end

task default: %i[compile test]

rebuild_and_test_native = lambda do |mode, test: true|
  tasks = %w[clean compile]
  tasks << 'test' if test

  sh(
    { 'BAZ_NATIVE_MODE' => mode },
    RbConfig.ruby,
    '-S',
    'bundle',
    'exec',
    'rake',
    *tasks
  )
end

# Native build orchestration is kept together so every mode shares the same
# compiler and clean-rebuild safeguards.
# rubocop:disable Metrics/BlockLength
namespace :c do
  desc 'Compile the C++ extension with warnings treated as errors'
  task :lint do
    rebuild_and_test_native.call('lint', test: false)
  end

  desc 'Measure C++ coverage using the full Ruby test suite'
  task :coverage do
    cxx = RbConfig::CONFIG.fetch('CXX')
    compiler_version = Open3.capture2e(*Shellwords.split(cxx), '--version').first

    unless compiler_version.match?(/gcc|g\+\+/i) && !compiler_version.match?(/clang/i)
      abort "c:coverage requires a GCC C++ Ruby build (current compiler: #{cxx})"
    end
    abort 'c:coverage requires gcovr on PATH' unless system('gcovr', '--version', out: File::NULL)

    rebuild_and_test_native.call('coverage')

    FileUtils.mkdir_p('coverage/cpp')
    sh(
      'gcovr',
      '--root', '.',
      '--filter', 'ext/baz/',
      '--html-details', 'coverage/cpp/index.html',
      '--xml', 'coverage/cpp/cobertura.xml',
      '--txt', 'coverage/cpp/summary.txt',
      '--print-summary'
    )
  end

  desc 'Run the Ruby tests with C++ ASan and UBSan instrumentation'
  task :sanitize do
    abort 'c:sanitize requires Linux' unless RUBY_PLATFORM.match?(/linux/)

    cxx = RbConfig::CONFIG.fetch('CXX')
    compiler_version = Open3.capture2e(*Shellwords.split(cxx), '--version').first
    unless compiler_version.match?(/gcc|g\+\+/i) && !compiler_version.match?(/clang/i)
      abort "c:sanitize requires a GCC C++ Ruby build (current compiler: #{cxx})"
    end

    libasan = Open3.capture2e(*Shellwords.split(cxx), '-print-file-name=libasan.so').first.strip
    abort 'c:sanitize could not locate the GCC ASan runtime' if libasan.empty? || libasan == 'libasan.so'

    rebuild_and_test_native.call('sanitize', test: false)
    sh(
      {
        'ASAN_OPTIONS' => 'detect_leaks=0',
        'BAZ_DISABLE_SIMPLECOV' => '1',
        'LD_PRELOAD' => libasan
      },
      RbConfig.ruby,
      '-S',
      'bundle',
      'exec',
      'rake',
      'test'
    )
  end
end
# rubocop:enable Metrics/BlockLength
