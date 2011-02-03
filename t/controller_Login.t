use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'YAC' }
BEGIN { use_ok 'YAC::Controller::Login' }

ok( request('/login')->is_success, 'Request should succeed' );
done_testing();
