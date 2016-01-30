#!/usr/bin/perl
use warnings; use strict;
while(<>) {
    chomp;
    next if (/^frame/); #skip header
    my ($frame, $time, $nform, @rformants) = split/\t/;
    my @sform = ();
    push @sform, ($rformants[0] ne '--undefined--') ? $rformants[0] : 0;
    push @sform, ($rformants[2] ne '--undefined--') ? $rformants[2] : 0;
    push @sform, ($rformants[4] ne '--undefined--') ? $rformants[4] : 0;
    push @sform, ($rformants[6] ne '--undefined--') ? $rformants[6] : 0;
    push @sform, ($rformants[8] ne '--undefined--') ? $rformants[8] : 0;
    my @oform = map { local $_ = $_ ; sprintf "%d", $_ } @sform;
    print "$frame & $time & " . join (" & ", @oform) . " \\\\\n";
}
