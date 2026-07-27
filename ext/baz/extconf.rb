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

  cxx = RbConfig::CONFIG.fetch('CXX')
  host_os = RbConfig::CONFIG.fetch('host_os')
  # Ruby 4 headers contain an unused inline parameter under Apple Clang.
  $CXXFLAGS << ' -Wno-unused-parameter' if cxx.match?(/clang/) || host_os.match?(/darwin/)
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
