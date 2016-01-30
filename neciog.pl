#!/usr/bin/perl
use warnings;
use strict;
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
		my $part = ($$fk[$i-1] / ((2 * $i) -1));
		$acc += $part * $part;
	}
	return sqrt ($acc / $M);
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
    my $len = vtl(\@formants);
    print $comment;
    print "$vowel & $len \\\\\n";
}

