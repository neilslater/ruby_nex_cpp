# frozen_string_literal: true

# ext/baz/extconf.rb
require 'mkmf'
$CXXFLAGS << ' -Wall -Wextra -Wpedantic'
$CXXFLAGS << ' -Werror -Wno-error=unused-parameter' if ENV['BAZ_CXX_WERROR'] == '1'
create_makefile('baz/baz')
