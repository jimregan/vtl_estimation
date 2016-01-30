#!/usr/bin/perl
use warnings; use strict;
my $f;
if (!$ARGV[0] || $ARGV[0] eq '') {
    $f = *STDIN;
} else {
    open ($f, "<$ARGV[0]");
}
my $seen = 0; my @acc = (0, 0, 0, 0, 0); my $num = 0;
while(<$f>) {
    chomp; s/\\\\//;
    if ($seen == 1) {
        my @out = ();
        for (my $i = 0; $i < 5; $i++) {
            push @out, ($acc[$i] / $num);
        }
        # Manually fill in word and vowel after
        my @print = map { local $_ = $_ ; sprintf "%d", $_ } @out;
        print " & " . join(" & ", @print) . " \\\\\n";
        $num = 0;
        @acc = (0, 0, 0, 0, 0);
        $seen = 0;
    }
    exit if (/^$/);
    if (/\\hline/) {
        $seen = 1;
        next;
    }
    $num++;
    my ($frame, $time, @formants) = split / \& /;
    for (my $i = 0; $i < 5; $i++) {
        $acc[$i] += $formants[$i];
    }
}

