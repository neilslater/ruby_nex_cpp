# Baz

[![Build Status](https://travis-ci.org/neilslater/ruby_nex_cpp.png?branch=master)](http://travis-ci.org/neilslater/ruby_nex_cpp)

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

Its purpose is to be a reference or starting point
for other gems with both Ruby and C++ code.

## Warning

The code still contains some "Cargo Cult" syntax where I am not sure
whether it is necessary or best practice. For instance in the line

    extern "C" VALUE baz_vector_magnitude( VALUE self )

I do not know whether the 'extern "C"' is doing anything useful.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
