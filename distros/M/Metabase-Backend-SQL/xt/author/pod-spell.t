use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.007004
use Test::Spelling 0.12;
use Pod::Wordlist;


add_stopwords(<DATA>);
all_pod_files_spelling_ok( qw( bin lib ) );
__DATA__
Archive
Backend
Brocard
David
Golden
Index
Leon
Metabase
PostgreSQL
RDBMS
SQL
SQLite
Sharded
acme
dagolden
dbis
dsn
lib
sqlite
