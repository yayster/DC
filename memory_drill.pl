#!/usr/bin/env perl

use strict;
use warnings;

my @list = 
    ('Mercury', 
     'Venus', 
     'Earth', 
     'Mars', 
     'Jupiter', 
     'Saturn', 
     'Uranus', 
     'Neptune', 
     'Pluto' );
my $FINISHED = 0;
do {
    print "Hello, world.\n";
    my @incorrect;
    my $order_ref = randomize_elements( \@list );
    &quiz( \@list, $order_ref, \@incorrect );
    if( scalar( @incorrect ) > 0 ) {
	&quiz( \@list, \@incorrect, \@incorrect );
    } else {
	$FINISHED = 1;
    }
} until( $FINISHED );
CORE::exit(0);
###############################################################################
# Subroutines
sub quiz {
    my $list_ref = shift;
    my $order_ref = shift;
    my $incorrect_ref = shift;
    foreach my $position ( @$order_ref ) {
	&question( $position, $list_ref, $incorrect_ref );
    }
}
sub question {
    my $position = shift;
    my $list_ref = shift;
    my $incorrect_ref = shift;
    my $number_answer = 0;
    my $type = int( rand( 3 ) );
    if( $type == 0 ) {
	&question_type_one( $position, $list_ref );
    } elsif( $type == 1 ) {
	&question_type_two( $position, $list_ref );
    } elsif( $type == 2 ) {
	&question_type_three( $position, $list_ref );
        $number_answer = 1;	
    }
    my $answer = <>;
    my $match = $list[ $position ];
    my $correct = 0;
    unless( $number_answer ) {
	$correct = 1 if( $answer =~ /$match/i );
    } else {
	$answer =~ /^(\d*)/;
	my $answer_number = $1;
	$correct = 1 if( $answer_number == $position + 1 );
    }	
    if( $correct ) {
	print "Correct!\n";
    } else {
	my $correct_answer;
	if( $number_answer ) {
	    $correct_answer = &numeric_suffix( $position + 1 );
	} else {
	    $correct_answer = $$list_ref[ $position ];
	}
	print "Sorry!  \""
	    . $correct_answer 
	    . "\" is the correct answer.\n";
	push( @$incorrect_ref, $position );
    }
}
sub question_type_three {
    my $position = shift;
    my $list_ref = shift;
    print "What planet from the sun is " . $$list_ref[ $position ] . "?\n";  
}
sub question_type_one {
    my $position = shift;
    my $list_ref = shift;
    my @list = @$list_ref;
    $position++;
    my $placement = &numeric_suffix( $position );
    print "What is the " . $placement . " planet from the Sun?\n";
}
sub numeric_suffix {
    my $number = shift;
    my $number_with_suffix;
    if( ( $number % 10 )  == 1 && $number != 11 ) {
	$number_with_suffix = $number . "st";
    } elsif( ( $number % 10 ) == 2 && $number != 12 ) {
	$number_with_suffix = $number . "nd";
    } elsif( ( $number % 10 ) == 3 && $number != 13 ) {
	$number_with_suffix = $number . "rd";
    } else {
	$number_with_suffix = $number . "th";
    }
    return( $number_with_suffix );
}
sub question_type_two {
    my $position = shift;
    my $list_ref = shift;
    if( $position == 0 ) {
	print "What planet is closer to the Sun than " 
	    . $$list_ref[ $position + 1 ] . "?\n";
    } elsif( $position == scalar( @$list_ref ) - 1 ) {
	print "What planet is after " . $$list_ref[ $position - 1 ] . "?\n";
    } else {
	print "What planet is between " . $$list_ref[ $position - 1 ]
	    . " and " . $$list_ref[ $position + 1 ] . "?\n";
    }
}
sub randomize_elements {
    my $list_ref = shift;
    my @list = @$list_ref;
    my $counter = 0;
    my @element_list;
    for( my $counter = 0; $counter < scalar( @list ); $counter++ ) {
	push( @element_list, $counter );
    }
    my @randomized_element_list;
    for( my $counter_two = 0; 
	 $counter_two < scalar( @list ); 
	 $counter_two++ ) {
	my $element_position = int( rand( scalar( @element_list ) ) );
	push( @randomized_element_list, $element_list[ $element_position ] );
	# taken from : http://stackoverflow.com/questions/174292/what-is-the-best-way-to-delete-a-value-from-an-array-in-perl
	my $index = 0;
	$index++ until $element_list[ $index ] 
	    == $element_list[ $element_position ];
	splice( @element_list, $index, 1 );
	# end of taken from
    }
    return( \@randomized_element_list );
}
__END__

A tool for "drilling" if you have to memorize some sort of sequence.

Like an easy sequence would be the planets in the solar system, harder would be
the presidents of the USA in order, harder still would be the periodic table.

You program it for the list you want to memorize and it acts like flash cards.
"What's the third elements?" and you say lithium and get it right, then "What's
the 6th elements?" and you say "iron" and get it wrong.  Then it remembers that
so it drills you extra hard with the 6th element.

[It is] an idea I've had for decades actually, it would be fairly easy to
implement and actually be useful


I've looked for similar things online, there are some things that come kind of
close but not quite what i have in mind.  The idea that it remembers what you
got wrong and drills it into your head is important.

Also that it phrases questions in multiple ways, e.g. "What element comes after
hydrogen?" "What is element #2?" "What element number is helium?"

[It would be] so much better than all of these stupid "brain games" sites that
promise to make you smarter; here we actually could boast "in 40 minutes you'll
know all of the presidents backwards and forwards"

-------------------------------------------------------------------------------
