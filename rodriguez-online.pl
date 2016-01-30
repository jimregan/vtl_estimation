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
    my $vtl_prev = $_[1];
    return (($beta * $vtl_prev) + ((1 - $beta) * $vtl_i));
}
sub alpha_i {
    my $vtlspki = $_[0];
    return (1 + ($lambda * (($model - $vtlspki) / $model)));
}
sub vtl {
    my $f_one = fone($_[0]);
    my $v = 35000;
    return ($v / (4 * $f_one));
}
sub fone {
    my $fk = $_[0];
    my $M = $#$fk + 1;
    my $acc = 0;
    for (my $i = 1; $i < $M+1; $i++) {
        if ($$fk[$i-1] == 0) {
            $M--;
        } else {
            my $part = ($$fk[$i-1] / ((2 * $i) -1));
            $acc += $part * $part;
        }
    }
    return sqrt ($acc / $M);
}
my $prev = $model;
while (<$f>) {
    chomp;
    next if (/^frame/); #skip header
    my ($frame, $time, $nform, @rformants) = split/\t/;
    my @sform = ();
    next if (/--undefined--/);
    push @sform, ($rformants[0] ne '--undefined--') ? $rformants[0] : 0;
    push @sform, ($rformants[2] ne '--undefined--') ? $rformants[2] : 0;
    push @sform, ($rformants[4] ne '--undefined--') ? $rformants[4] : 0;
    push @sform, ($rformants[6] ne '--undefined--') ? $rformants[6] : 0;
    push @sform, ($rformants[8] ne '--undefined--') ? $rformants[8] : 0;
    my $vtl = vtl(\@sform);
    my $update = vtl_spk_i($vtl, $prev);
    my $warp = alpha_i($update);
    print "$frame & $prev & $update & $warp \\\\\n";
    $prev = $update;
}
