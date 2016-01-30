#!/usr/bin/perl
use warnings;
use strict;
sub flength {
    my $n = $_[0]; my $fn = $_[1]; my $c = 35000;
    my $res = $c * ((2 * $n) - 1) / (4 * $fn);
    $res;
}
my $f;
if (!$ARGV[0] || $ARGV[0] eq '') {
    $f = *STDIN;
} else {
    open ($f, "<$ARGV[0]");
}
while(<$f>) {
    chomp; s/\\\\//;
    next if (/^%/); # Skip comments
    my $comment = ''; # if not skipping, put it back
    $comment = '%' if (/^%/);
    my ($word, $vowel, @formants) = split / \& /;
    my @lns = (); my $acc = 0;
    for (my $i = 0; $i < 5; $i++) {
        my $ln = flength ($i+1, $formants[$i]);
        push @lns, $ln;
        $acc += $ln;
    }
    my $mean = sprintf ("%.1f", $acc / 5);
    my $h45mean = sprintf ("%.1f", ($lns[3] + $lns[4]) / 2);
    my $h345mean = sprintf ("%.1f", ($lns[2] + $lns[3] + $lns[4]) / 3);
    my $h34mean = sprintf ("%.1f", ($lns[2] + $lns[3]) / 2);
    my $h234mean = sprintf ("%.1f", ($lns[1] + $lns[2] + $lns[3]) / 3);
    my @plns = map { local $_ = $_ ; sprintf "%.1f", $_ } @lns;
    print $comment;
    print "$vowel & " . join(" & ", @plns) . " & $mean";
    print " & $h34mean & $h234mean & $h345mean & $h45mean \\\\\n";
}

