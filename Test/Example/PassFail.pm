package Test::Example::PassFail;

use strict;
use base qw(QA::Test::TestCase);
use Test::More;

sub test_hello_world {
    my $self = shift;
    
    return pass("Hello World Pass");
}

sub test_bye_world {
    my $self = shift;
    
    pass("Hello World");
    ok (1, "This passes");
    
    return 1;
}

sub test_fail {
    my $self = shift;
    
    return fail("Failing this test");
}