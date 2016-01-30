#!/usr/bin/perl
use warnings;
use strict;
my $f;
my $model = 17.5; # default average
if ($ARGV[0] && $ARGV[0] ne '') {
    $model = $ARGV[0];
}
if (!$ARGV[1] || $ARGV[1] eq '') {
    $f = *STDIN;
} else {
    open ($f, "<$ARGV[0]");
}
my $lambda = 0.5;
my $beta = 0.99;
sub vtl_spk_i {
    my $vtl_i = $_[0];
    my $vtl_prev = $model;
    if (exists $_[1]) {
        $vtl_prev = $_[1];
    }
    return (($beta * $vtl_prev) + ((1 - $beta) * $vtl_i));
}
sub alpha_i {
    my $vtlspki = $_[0];
    return (1 + ($lambda * (($model - $vtlspki) / $model)));
}
while (<$f>) {
    chomp; s/\\\\//;
    my ($vowel, $vtl) = split / & /;
    my $update = vtl_spk_i($vtl);
    my $warp = alpha_i($update);
    print "$vowel & $vtl & $update & $warp \\\\\n";
}
