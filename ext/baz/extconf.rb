# ext/baz/extconf.rb
require 'mkmf'
$CXXFLAGS = '--std=c++0x'
create_makefile( 'baz/baz' )
