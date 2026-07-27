# Baz

[![CI](https://github.com/neilslater/ruby_nex_cpp/actions/workflows/ci.yml/badge.svg)](https://github.com/neilslater/ruby_nex_cpp/actions/workflows/ci.yml)

Example of gem that combines Ruby and C++ native extension.

## Installation

Add this line to your application's Gemfile:

    gem 'baz'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install baz

## Usage

This gem is a do-nothing skeleton, built starting from

    $ bundle gem baz

and then continued by adding support for native extensions in C++.

Its purpose is to be a reference or starting point for other gems with both Ruby and C++ code.

## Supported Ruby versions

Baz supports Ruby 3.3 and newer. CI tests Ruby 3.3, 3.4, and 4.0, covering all
Ruby release series that have not reached official end of life. See Ruby's
[maintenance schedule](https://www.ruby-lang.org/en/downloads/branches/) for
the current status of each release series.

## Development

A working C++ compiler toolchain is required to build the native extension.
Install dependencies and run the same core checks as CI with:

    bundle install
    bundle exec rake
    bundle exec rubocop
    bundle exec bundle-audit check --update
    bundle exec yard stats --list-undoc --exclude 'ext/.*'
    bundle exec gem build baz.gemspec

The native C++ quality checks are also available as Rake tasks:

    bundle exec rake c:lint
    bundle exec rake c:coverage
    bundle exec rake c:sanitize

`c:lint` performs a clean C++11 rebuild with strict compiler warnings treated
as errors. `c:coverage` runs the specs against a GCC-instrumented extension and
writes HTML, Cobertura XML, and text reports under `coverage/cpp/`.
`c:sanitize` runs the specs with GCC AddressSanitizer and
UndefinedBehaviorSanitizer instrumentation. Coverage and sanitizer checks
require Linux with a Ruby built using genuine GCC; coverage also requires
`gcovr`. CI is their canonical environment, while `c:lint` is also supported
locally on macOS.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
