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
    bundle exec rake compile
    bundle exec rspec
    bundle exec rubocop
    bundle exec gem build baz.gemspec

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
