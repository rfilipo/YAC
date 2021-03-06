package YAC::Stack;

use strict;
use warnings;

use Moose;

has user => (
      is       => 'rw',
      isa      => 'Int',
      required => 1,
);

has url => (
      is       => 'rw',
      isa      => 'Str',
      required => 1,
);

has title => (
      is       => 'rw',
      isa      => 'Str',
      required => 1,
);

has content => (
      is       => 'rw',
      isa      => 'Str',
      required => 0,
);

has 'stacks' => (
   traits     => ['Array'],
   is         => 'rw',
   isa        => 'ArrayRef[Str]',
   default    => sub { [] },
   handles    => {
       all_stacks    => 'elements',
       add_stack     => 'push',
       map_stacks    => 'map',
       filter_stacks => 'grep',
       find_stack    => 'first',
       get_stack     => 'get',
       join_stacks   => 'join',
       has_stacks    => 'count',
       has_no_stacks => 'is_empty',
       sorted_stacks => 'sort',
   },
);

=head1 AUTHOR

filipo,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
