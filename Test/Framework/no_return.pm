package Test::Framework::no_return;

use strict;
use base qw(QA::Test::TestCase);
use QA::Test;

sub test_does_not_return_1 {
    my $self = shift;
    pass("Hello World Pass");
}

sub test_does_not_return_0 {
    my $self = shift;
    fail("Bye World Pass");
}

sub test_pass_but_return_0 {
    my $self = shift;
    pass("Hello World Pass");
    
    return 0;
}

sub test_pass_but_return_1 {
    my $self = shift;
    fail("Bye World Pass");
    
    return 1;
}
