# frozen_string_literal: true

# ext/baz/extconf.rb
require 'mkmf'
$CXXFLAGS << ' -Wall -Wextra -Wpedantic'
create_makefile('baz/baz')
