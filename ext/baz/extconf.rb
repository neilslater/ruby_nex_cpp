# frozen_string_literal: true

# ext/baz/extconf.rb
require 'mkmf'
require 'rbconfig'

case ENV.fetch('BAZ_NATIVE_MODE', 'release')
when 'release'
  # Use Ruby's configured extension flags for normal source-gem builds.
when 'lint'
  $CXXFLAGS << ' -std=c++11 -O0 -g'
  $CXXFLAGS << ' -Wall -Wextra -Wpedantic -Wformat=2 -Werror'
when 'coverage'
  $CXXFLAGS << ' -std=c++11 -O0 -g --coverage'
  $LDFLAGS << ' --coverage'
when 'sanitize'
  $CXXFLAGS << ' -std=c++11 -O1 -g -fsanitize=address,undefined'
  $CXXFLAGS << ' -fno-omit-frame-pointer'
  $LDFLAGS << ' -fsanitize=address,undefined'
else
  abort "Unknown BAZ_NATIVE_MODE: #{ENV.fetch('BAZ_NATIVE_MODE', nil)}"
end

create_makefile('baz/baz')
