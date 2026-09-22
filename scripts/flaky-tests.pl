#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;

my %flaky_tests;

while (<>) {
    chomp;
    s/, type: (?:brittle|victim)$//;
    $flaky_tests{$1} = 1 if /, to: (.*)/;
}

printf "%d\n", scalar keys %flaky_tests;
