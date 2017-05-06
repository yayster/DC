#!/usr/bin/env perl

use strict;
use warnings;

my $number = 45;
for( my $position = 1; $position <= $number; $position++ ) {
    my $placement;
    if( ( $position % 10 )  == 1 && $position != 11 ) {
	$placement = $position . "st";
    } elsif( ( $position % 10 ) == 2 && $position != 12 ) {
	$placement = $position . "nd";
    } elsif( ( $position % 10 ) == 3 && $position != 13 ) {
	$placement = $position . "rd";
    } else {
	$placement = $position . "th";
    }
    print $placement . "\n";
}
