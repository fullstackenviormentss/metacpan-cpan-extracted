use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.006008
use Test::Spelling 0.12;
use Pod::Wordlist;


add_stopwords(<DATA>);
all_pod_files_spelling_ok( qw( bin lib  ) );
__DATA__
Artur
Bergman
sky
Karen
Etheridge
ether
יובל
קוג
Yuval
Kogman
nothingmuch
Jesse
Luehrs
doy
Brad
Fitzpatrick
brad
Ed
mohawk2
Curtis
Brandt
curtisjbrandt
lib
Devel
Gladiator
