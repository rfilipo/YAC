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

Show a stack defined by this url as argument

sub begin : Private { 
    my ( $self, $c ) = @_;
    if ( !$c->request->arguments->[0] ) { 
        $c->forward('search',['index']);
        #exit();
    }
}
=cut


sub index :Path :Args(1) {
    my ( $self, $c, $url ) = @_;
    $c->forward('search',$url);
}

sub search: Private {
    my ( $self, $c, $url ) = @_;
    
    #print $url;
    my $result = $c->model('YAC::Stack')->search(
         {url => {'like' => $url } }
    );
    my @rs = $c->model('YAC::Stack')->search(
         {url => {'like' => $url } }
    );
    $c->stash( stacks => \@rs );
#use Data::Dumper;
#print "<pre>"; print Dumper(@rs); print "</pre>";

   
    if ($result->next){ 
    $c->stash( template => 'html/index.tt' );
    } else {
    $c->response->body( '<h1>What? :P  ...</h1><br><a href="/">&lt;-- </a>' );
    }

}

=head2 index


Show a list of all stacks in this system

=cut


sub list: Local {
    my ( $self, $c ) = @_;

    $c->stash(stacks => [$c->model('YAC::Stack')->all]);
    $c->stash(template => 'src/stacks/list.tt');
}



=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    if ( !$c->request->arguments->[0] ) { 
        $c->forward('search',['index']);
    } else {
       $c->response->body( '<h1>What? :P  ...</h1><br><a href="/">&lt;-- </a>' );
       $c->response->status(404);
    }
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
