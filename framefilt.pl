#!/usr/bin/perl
use warnings; use strict;
# Times are hardcoded
my @beg = qw(0.4581200950698864 3.055065014920004 3.897152825776543 
             8.025616713925247 8.715284865072784);
my @end = qw(0.489452904932498 3.1012328756786514 3.9496205026691236 
             8.06078298961716 8.73416588192373);
my $f;
if (!$ARGV[0] || $ARGV[0] eq '') {
    $f = *STDIN;
} else {
    open ($f, "<$ARGV[0]");
}
my $lbeg = $beg[0];
while(<$f>) {
    chomp; s/\\\\//;
    my ($frame, $time, @formants) = split / \& /;
    my $skip = 1;
    for (my $i = 0; $i < 5; $i++) {
        $skip = 0 if ($time > $beg[$i] && $time < $end[$i]);
        if ($skip == 0) {
            if ($lbeg != $beg[$i]) {
                print "\\hline\n";
                $lbeg = $beg[$i];
            }
            print "$_\\\\\n";
            $skip = 1;
            next;
        }
    }
}
print "\\hline\n\n";

