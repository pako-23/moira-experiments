#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;

my $progress;

while (<>) {
    chomp;
    $progress = ($1*100)/$2 if /progress (\d+)\/(\d+)/
}

printf "%d\n", $progress if defined($progress);
