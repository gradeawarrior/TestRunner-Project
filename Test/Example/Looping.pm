package Test::Example::Looping;

use strict;
use base qw(QA::Test::TestCase);
use Test::More;

sub set_up {
    my $self = shift;
    
    $self->{loop} = [ 'a', 'b', 'c', 'd' ];
    return 1;
}

sub test_looping {
    my $self = shift;
    
    foreach (@{$self->{loop}}) {
        pass("Got $_");
    }
    
    return 1;
}