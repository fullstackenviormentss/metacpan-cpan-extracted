use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.007004
use Test::Spelling 0.12;
use Pod::Wordlist;


add_stopwords(<DATA>);
all_pod_files_spelling_ok( qw( examples lib script t xt ) );
__DATA__
Adam
Chris
David
Dolan
Etheridge
Golden
Karen
Kennedy
PPI
XS
adam
adamk
chris
dagolden
ether
irc
lib
xdg
