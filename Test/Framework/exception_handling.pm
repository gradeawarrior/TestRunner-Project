package Test::Framework::exception_handling;

use strict;
use base qw(QA::Test::TestCase);
use Carp 'croak';
use QA::Test;

sub test_no_exception {
    my $self = shift;
}

sub test_exception1 {
    my $self = shift;
    croak "Hello there?";
}

sub test_exception2 {
    my $self = shift;
    foobar();
}
