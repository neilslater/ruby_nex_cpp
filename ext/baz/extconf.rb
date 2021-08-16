# frozen_string_literal: true

# ext/baz/extconf.rb
require 'mkmf'
have_library('stdc++')
$CFLAGS << ' -Wall'
create_makefile('baz/baz')
