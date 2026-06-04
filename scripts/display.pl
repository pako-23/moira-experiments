#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;

if (my $line = <STDIN>) {
    print "$line";
} else {
    print "N/A\n";
}
