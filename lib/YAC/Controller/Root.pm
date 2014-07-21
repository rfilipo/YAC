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

    if ($c->config->{'template_path'}) {
        $c->stash->{additional_template_paths} =
            [$c->config->{'template_path'}];

        $c->session->{template} = $c->config->{'template_path'};
    }
    $c->forward('search',$url);
}

=head2 template_path

Change the template_path configuration.

After this command is done all pages served will use the new template until it changes again. It can be a must in ajax aplications.

The site can use template_path configuration from web requests or from file yac.conf.

If you want to use configuration from web request coment the configuration diretive template_path in yac.conf. The web command only works if the template_path diretive isn't in the yac.conf.

Enjoy!

=cut


sub template_path :Local :Args(1) {
    my ( $self, $c, $path ) = @_;
    $path =~ s/_/\//g;
    $c->stash->{additional_template_paths} =
        [$c->config->{'template_path'}];
    $c->session->{template} = $path;
    $c->response->body("new_path $path");
}


sub search: Private {
    my ( $self, $c, $url ) = @_;

    if ($url eq "edit"){$c->response->redirect($c->uri_for("/edit", "index"))}
    if ($url eq "hack"){$c->response->redirect($c->uri_for("/hack", "index"))}

    # FIXME wy dis? :P dumb!
    my $result = $c->model('YAC::Stack')->search(
         {url => {'like' => $url } }
    );
    my @rs = $c->model('YAC::Stack')->search(
         {url => {'like' => $url } }
    );

#use Data::Dumper;
#print Dumper    $result;
#print Dumper    @rs;

    $c->stash( stacks => \@rs );


    if ($result->next){
        my $template_path = 'root/templates/default';
        $template_path=$c->session->{template} unless ! $c->session->{template};
        @{ $c->view('Stack')->include_path } = $template_path;
        $c->stash( template => 'index.tt' );
        $c->forward( $c->view('Stack') );
    } else {
        $c->response->body( '<h1>What? :P  ...</h1>'.$url.'<br><a href="/">&lt;-- </a>' );
    }

}

=head2 list


Show a list of all stacks in this system

=cut


sub list: Local {
    my ( $self, $c ) = @_;

    $c->stash(stacks => [$c->model('YAC::Stack')->all]);
    $c->stash(template => 'list.tt');
    #$c->forward( $c->view('Stack') );
}



=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;

    if ($c->config->{'template_path'}) {
        $c->stash->{additional_template_paths} =
            [$c->config->{'template_path'}];

        $c->session->{template} = $c->config->{'template_path'};
    }


    if ( !$c->request->arguments->[0] ) {
        $c->forward('search',[$c->config->{'homepage'}]);
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
