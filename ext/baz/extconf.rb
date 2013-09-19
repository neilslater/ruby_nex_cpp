# ext/baz/extconf.rb
require 'mkmf'
$CPPFLAGS = ' --std=c++0x' if RUBY_VERSION == '1.8.7'
create_makefile( 'baz/baz' )
