#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;

my ($n, $sum, $squared_sum) = (0, 0, 0);

while (<>) {
    next unless $_ =~ /^[+-]?\d+(\.\d*)?([eE][+-]?\d+)?$/;

    $n++;
    $sum += $_;
    $squared_sum += $_ * $_;
}

unless ($n == 10) {
    print "Has $n runs\n";
    exit;
}

my $avg = $sum / $n;
my $var = ($squared_sum - $sum * $sum / $n) / ($n - 1);
my $se  = sqrt($var / $n);

printf "avg=%g se=%g\n", $avg, $se;
