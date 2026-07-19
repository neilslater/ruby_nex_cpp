# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'baz/version'

Gem::Specification.new do |gem|
  gem.name          = 'baz'
  gem.version       = Baz::VERSION
  gem.authors       = ['Neil Slater']
  gem.email         = ['slobo.777@gmail.com']
  gem.description   = 'Starter gem with native extensions in C++'
  gem.summary       = 'Native extension in C++'
  gem.homepage      = 'https://github.com/neilslater/ruby_nex_cpp'
  gem.license       = 'MIT'

  gem.required_ruby_version = '>= 3.3'

  gem.metadata = {
    'source_code_uri' => 'https://github.com/neilslater/ruby_nex_cpp',
    'bug_tracker_uri' => 'https://github.com/neilslater/ruby_nex_cpp/issues',
    'changelog_uri' => 'https://github.com/neilslater/ruby_nex_cpp/blob/main/CHANGELOG.md',
    'rubygems_mfa_required' => 'true'
  }

  gem.files = Dir[
    'CHANGELOG.md',
    'LICENSE.txt',
    'README.md',
    'lib/**/*.rb',
    'ext/**/*.{cpp,h}',
    'ext/**/extconf.rb'
  ]
  gem.extensions    = ['ext/baz/extconf.rb']
  gem.require_paths = ['lib']
end
