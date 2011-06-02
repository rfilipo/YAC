use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'YAC' }
BEGIN { use_ok 'YAC::Controller::Mosaic' }

ok( request('/mosaic')->is_success, 'Request should succeed' );

my $dir = 'default';
my $id  = 1;
my $width = '20px';

# Mosaic requests
ok( request('/mosaic/show/'.$dir.'/'.$id)->is_success, 'Can show images' );
ok( request('/mosaic/list/'.$dir)->is_success, 'Can list directories' );
ok( request('/mosaic/json/'.$dir)->is_success, 'Can return json objects' );
ok( request('/mosaic/squares/'.$width.'/'.$dir)->is_success, 'Can create a mosaic' );
done_testing();
