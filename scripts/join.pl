#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;
use Getopt::Long qw(GetOptions);


sub usage {
    my ($exit_status) = @_;
    my $fh = $exit_status == 0 ? *STDOUT : *STDERR;

    print {$fh} "Usage: $0 [--type inner|left|right] FILE1 FILE2\n";
    exit $exit_status;
}

sub read_records {
    my ($file) = @_;
    my %records;

    open my $fh, '<', $file
        or die "$0: cannot open '$file': $!\n";
    while (<$fh>) {
        chomp;
        s/, type: (?:brittle|victim)$//;
        s/.*, to: //;
        $records{$_} = 1;
    }

    close $fh;

    return \%records;
}


Getopt::Long::Configure(qw(no_auto_abbrev no_ignore_case));

my $type = 'inner';
my $help;

GetOptions(
    'type=s' => \$type,
    'help'   => \$help,
    'h'   => \$help,
) or usage(2);

usage(0) if $help;
usage(2) unless @ARGV == 2;

die "$0: invalid join type '$type' (expected inner, left, or right)\n"
    unless $type =~ /\A(?:inner|left|right)\z/;

my ($left_file, $right_file) = @ARGV;


my %left = %{read_records($left_file)};
my %right = %{read_records($right_file)};

if ($type eq 'right') {

    foreach (keys %right) {
        print "$_\n" if !exists $left{$_};
    }

} elsif ($type eq 'left') {

    foreach (keys %left) {
        print "$_\n" if !exists $right{$_};
    }

} else {

    foreach (keys %left) {
        print "$_\n" if exists $right{$_};
    }

}
