package YAC::View::Stack;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

YAC::View::Stack - TT View for YAC

=head1 DESCRIPTION

TT View for YAC.

=head1 SEE ALSO

L<YAC>

=head1 AUTHOR

Ricardo Filipo,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
