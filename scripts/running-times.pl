#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;
use List::Util qw(max);

my $experiment_dir = shift;
my $prefix = shift;

die "Usage: $0 <experiment-dir> <prefix>\n" unless (defined $experiment_dir && defined $prefix);

my $running_times = "$experiment_dir/running-times";

exit unless (-f $running_times);

open my $fh, '<', $running_times or die "Cannot open $running_times: $!";

while (<$fh>) {
    print max($1, 1) . "\n" if /^$prefix:\s+(\d+)/;
}

close $fh;
