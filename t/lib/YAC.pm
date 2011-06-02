use strict;
use warnings;
use FindBin '$Bin';
use lib "$Bin/lib";
use Test::Most tests => 1;
use Catalyst::Test 'YAC';

my $content  = get('/');           # Content as string
my $response = request('/');       # HTTP::Response object
my($res, $c) = ctx_request('/');      # HTTP::Response & context object

like ($content, qr(SD88));
