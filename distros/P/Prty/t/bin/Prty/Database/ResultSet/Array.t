#!/usr/bin/env perl

package Prty::Database::ResultSet::Array::Test;
use base qw/Prty::Test::Class/;

use strict;
use warnings;

# -----------------------------------------------------------------------------

sub test_loadClass : Init(1) {
    shift->useOk('Prty::Database::ResultSet::Array');
}

# -----------------------------------------------------------------------------

package main;
Prty::Database::ResultSet::Array::Test->runTests;

# eof
