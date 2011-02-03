use inc::Module::Install;

requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::Store::FastMmap';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::StackTrace';
requires 'Catalyst::Authentication::Realm::SimpleDB'; 

name     'YAC';
all_from 'lib/YAC.pm';
author   q{Monsenhor <ricardo.filipo@gmail.com>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

