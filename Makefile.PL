use inc::Module::Install;

name     'YAC';
all_from 'lib/YAC.pm';
author   q{Monsenhor <ricardo.filipo@gmail.com>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

