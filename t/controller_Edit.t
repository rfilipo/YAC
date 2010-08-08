use strict;
use warnings;
use lib 'lib';
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'YAC' }
BEGIN { use_ok 'YAC::Controller::Edit' }

ok( request('/edit')->is_success, 'Request should succeed' );


