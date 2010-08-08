#!perl -T

use Test::More tests => 1;
use lib 'lib';

BEGIN {
    use_ok( 'YAC' ) || print "Bail out!
";
}

diag( "Testing YAC $YAC::VERSION, Perl $], $^X" );
