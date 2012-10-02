package Test::Framework::setup_exception;

use strict;
use base qw(QA::Test::TestCase);
use Carp 'croak';
use QA::Test;

sub set_up {
    my $self;
    pass("Something good happened");
    #croak "hello";
    hello();
}
sub test_no_exception {
    my $self = shift;
}
