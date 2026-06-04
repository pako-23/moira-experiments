#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;

my %flaky_tests;

while (<>) {
    chomp;
    $flaky_tests{$1} = 1 if /from: (.+), to: .*/
}

printf "%d\n", scalar keys %flaky_tests;
