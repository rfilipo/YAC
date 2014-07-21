use inc::Module::Install;
use Module::Install::Catalyst;

requires 'Catalyst::Runtime' => '5.80025';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General';
requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::Store::FastMmap';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::StackTrace';
requires 'Catalyst::Authentication::Realm::SimpleDB';
requires 'JSON';
requires 'Path::Class';
requires 'Image::Size';
requires 'Image::Magick';
requires 'PSGI';

name     'YAC';
all_from 'lib/YAC.pm';
author   q{Monsenhor <monsenhor@cpan.org>};
license  'perl';

build_requires 'Test::More';
test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');

auto_install;

WriteAll;

