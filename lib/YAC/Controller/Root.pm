package YAC::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

YAC::Controller::Root - Root Controller for YAC

It implements the YAC's Play machine

=head1 DESCRIPTION

The Play machine is the default instance of the YAC.

It shows the content to user.


=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # FIXME
    $c->response->body( "
        <html><head><title>YAC</title></head>
        <body style='background: url(\"static/images/yeast.jpg\") #f6edd0 center no-repeat ;'>
        <h1>
        YAC (YACCMS (Yet Another Catalyst CMS))
        </h1>
        </body>
        </html> 
        " );
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( '<h1>What? :P  ...</h1>' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Monsenhor, C<< <ricardo.filipo at gmail.com> >>


=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
