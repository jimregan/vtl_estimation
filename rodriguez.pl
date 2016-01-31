#!/usr/bin/perl
use warnings;
use strict;
my $f;

# No model was available, so used an average for VTL
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

# VTL_{spk}(i) = \beta * VTL_{spk}(i - 1) + (1 - \beta) * VTL(i)
sub vtl_spk_i {
    my $vtl_i = $_[0];
    my $vtl_prev = $_[1];
    return (($beta * $vtl_prev) + ((1 - $beta) * $vtl_i));
}

# \alpha(i) = 1 + \lambda\frac{\overline{VTL}_{model} - VTL_{spk}(i)}{\overline{VTL}_{model}}
sub alpha_i {
    my $vtlspki = $_[0];
    return (1 + ($lambda * (($model - $vtlspki) / $model)));
}

# VTL_{spk}(0) = \overline{VTL}_{model}
my $prev = $model;

while (<$f>) {
    chomp; s/\\\\//;

    my ($vowel, $vtl) = split / & /;
    my $update = vtl_spk_i($vtl, $prev);
    $prev = $update;
    my $warp = alpha_i($update);
#    my $updout = sprintf("%.1f", $update);
    print "$vowel & $vtl & $update & $warp \\\\\n";
}
