use inc::Module::Install;

name     'Quiz-Flashcards-Sets-Katakana-Romaji_Simple';
all_from 'lib/Quiz/Flashcards/Sets/Katakana/Romaji_Simple.pm';
author   'Christian Walde <mithaldu@yahoo.de>';
license  'perl';

build_requires 'Test::More';
build_requires 'Quiz::Flashcards';

auto_install;

WriteAll;

