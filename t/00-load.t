#!perl -T

use Test::More tests => 2;

BEGIN {
    use_ok( 'YAC' ) || print "Bail out! \n";
    use_ok( 'YACCMS' ) || print "Bail out! \n";
}

diag( "Testing YAC $YAC::VERSION, Perl $], $^X" );
