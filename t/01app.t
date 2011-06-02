#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'YAC' }

ok( request('/')->is_success, 'Request should succeed' );
ok( request('/edit')->is_success, 'Request should succeed' );
ok( request('/admin')->is_success, 'Request should succeed' );
ok( request('/hack')->is_success, 'Request should succeed' );

done_testing();
