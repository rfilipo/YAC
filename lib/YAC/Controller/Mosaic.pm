package YAC::Controller::Mosaic;
use Moose;
use namespace::autoclean;
use Path::Class;
use Image::Size;
use Image::Magick;
use JSON;
use URI::Escape;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

YAC::Controller::Mosaic - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $serie  = 'default';
    my $layout = 'squares';
    my $width  = '20px';
    my $template_path = 'root/templates/default';

    $serie  = $c->request->params->{'serie'}   unless 
                !$c->request->params->{'serie'} ;
    $layout = $c->request->params->{'layout'}  unless 
                !$c->request->params->{'layout'};
    $width  = $c->request->params->{'width'}   unless 
                !$c->request->params->{'width'};
    
    # use config path if exists
    # overrides session
    if ($c->config->{'template_path'}) {
        $c->stash->{additional_template_paths} =
            [$c->config->{'template_path'}];

        $c->session->{template} = $c->config->{'template_path'};
    }
    # change path default unless not exists session config
    $template_path=$c->session->{template} unless ! $c->session->{template}; 
 
    $c->stash('title' => $c->config->{'site_name'}.' - '.$serie  );
    $c->stash('serie'  => $serie );
    $c->stash('layout' => $layout);
    $c->stash('width'  => $width );
}

=head2 show

=cut

sub show :Local :Args(2) {
    my ( $self, $c, $img_dir, $id ) = @_;
    my $template_path = 'root/templates/default';
    my $file     = 'root/images/yeast_infection_in_men.JPG';    

    # use config path if exists
    # overrides session
    if ($c->config->{'template_path'}) {
        $c->stash->{additional_template_paths} =
            [$c->config->{'template_path'}];

        $c->session->{template} = $c->config->{'template_path'};
    }
    # change path default unless not exists in session config
    $template_path=$c->session->{template} unless ! $c->session->{template}; 
    my $file_path = file($c->config->{'mosaic_path'}.$img_dir, $id); 
    $file_path->cleanup;
    if (-e $file_path) {
         $file = $file_path;
    } 
    $c->serve_static_file($file);
}

=head2 list

=cut

sub list :Local :Args(1) {
    my ( $self, $c, $img_dir ) = @_;

    my $template_path = 'root/templates/default';
    
    # use config path if exists
    # overrides session
    if ($c->config->{'template_path'}) {
        $c->stash->{additional_template_paths} =
            [$c->config->{'template_path'}];

        $c->session->{template} = $c->config->{'template_path'};
    }
    # change path default unless not exists session config
    $template_path=$c->session->{template} unless ! $c->session->{template}; 
    my $dir  = dir($c->config->{'mosaic_path'}, $img_dir);
    $dir->cleanup;

    my $handle = $dir->open;
    my $files  = [];
    if ($handle){
        while (my $file = $handle->read) {
            my $file_obj = $dir->file($file);
            my $file_name = $file_obj->{'file'};
            push (@{$files}, $file_name) unless 
                        $file_name eq '.' || 
                        $file_name eq '..';
        }
    }else{
        $c->response->body('Can not find '.$dir.'! :P');
        return 1;
    }

    @{ $c->view('Stack')->include_path } = $template_path;
    $c->stash(files => $files);
    $c->stash(path => $dir);
    #$c->stash(template => 'mosaic/list.tt');
    $c->forward( $c->view('Stack') );
}

=head2 json

=cut

sub json :Local :Args(1) {
    my ( $self, $c ) = @_;

    #$json_text   = $json->encode( $perl_scalar );
    $c->response->body('{(Isto e um),(JSON)(!!!!)}');
}

=head2 squares

Create a squares thumbs mosaic with images in the serie.
A serie is a directory in the mosaic path.

If not exists the croped squares, Mosaic would create ones.

If exists a file named index.png this image is used as the squares crop base. 
Otherwise Mosaic creates aleatory square crops of each image in serie.

Mosaic uses a file named mosaic.json for each serie for organize and map
the square thumb with the real image link.

If the file mosaic.json doesn't exist in that serie directory, Mosaic creates one with aleatory organization.

Mosaic loads the image mosaic_empty_square.png from the serie's directory in empty squares but this behavior can be overrided with the request <serie>/<width>?empty=<my_empty.png>

=cut

sub squares :Local :Args(2) {
    my ( $self, $c, $serie, $width ) = @_;
    my $template_path = 'root/templates/default';

    my $empty = $c->config->{'mosaic_path'}.$serie.'/mosaic_empty_square.png';
    $empty    = $c->request->params->{'empty'}   unless 
                !$c->request->params->{'empty'} ;
    my $mosaic_index_png= $c->config->{'mosaic_path'}.$serie.'/index.png';
    my $mosaic_json= $c->config->{'mosaic_path'}.$serie.'/mosaic.json';
   
    my $imga                 = [];
    my $images               = {};
    my $imagick              = {};

    # use path from config, if exists
    # overrides session
    if ($c->config->{'template_path'}) {
        $c->stash->{additional_template_paths} =
            [$c->config->{'template_path'}];

        $c->session->{template} = $c->config->{'template_path'};
    }
    # change path default unless not exists session config
    $template_path=$c->session->{template} unless ! $c->session->{template}; 
  
    # TODO
    # verify and make environment integrity
   # if exists index.png file and not exists croped images
   # if (-e $index_mosaic_png && !$cropped_images[0]) {
        # crop the image in 40 squares and 
        # save in $dir with form:  mosaic_<row>_<col>.png
                #if (-e $file_name){
                #    $imagick = new Image::Magick;
                #    $imagick->Read($file_name);
                #$imagick   = {};
                #}
   # }
    # else if not exists croped images
        # crop an aleatory square from each image and 
        # save in $dir with form:  mosaic_<row>_<col>.png
           # if there images are low than 40 this makes aleatory gaps 
    # else if not exists mosaic.json create it 
    

    # read mosaic.json
    if (-e $mosaic_json){
        open (MOSAIC, "<:encoding(UTF-8)", $mosaic_json);
        my @json_text = <MOSAIC> ;
        close MOSAIC   ;
        my $json_text = join '', @json_text;
    my $json = new JSON;
    $images = $json->decode( $json_text );
        } else { 
            $c->response->body('ERRO '.$mosaic_json);
            #TODO create o JSON
            return 0;
        } 

=pod 
    # open dir to locate images
    my $dir  = dir($c->config->{'mosaic_path'}, $serie);
    $dir->cleanup;
    my $handle = $dir->open;
    my $id = 0;
    if ($handle){
     my $file_obj             = {};
    my $file_name            = '';
 
       while (my $img = $handle->read) {
            $file_obj  = $dir->file($img);
            $file_name = $file_obj->{'file'};
            if ( $file_name ne '.' || $file_name ne '..'){
                push (@{$images}, {
                        file_name => $file_name,
                        class     => 'm_0',
                        id        => $id
                });
            }
            $id ++;
        }
    }else{
        $c->response->body("Can't find ".$serie."! :P");
        return 1;
    }

=cut

foreach my $sq (keys %{$images}) {
      my ($row, $col) = split ('_', $sq);
      my $mos = "mosaic_".$sq.".png";
      my $img = $c->config->{'mosaic_path'}.$serie."/".$images->{$sq};
      my ($x, $y) = imgsize($img);
      $imga->[$row]->[$col] = {
              file => uri_escape($images->{$sq}),
              x    => $x,
              y    => $y,
              mos  => $mos,
      };
}

#use Data::Dumper;
#print Dumper $imga;

    #$c->stash(template => 'mosaic/squares.tt');
    $c->stash(images => $imga);
    $c->stash(width => $width);
    $c->stash(serie => $serie);
    $c->forward( $c->view('Stack') );
}

=head1 AUTHOR

Monsenhor, monsenhor at cpan.org

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
