package Test::Example::ParametersExample;

use strict;
use base qw(QA::Test::TestCase);
use Test::More;

sub set_up {
    my $self = shift;
    
    my $return = ok(defined $self->{users}, "Users are defined");
    $return = (ok(defined $self->{users}->[0], "User1 is defined") and $return);
    $return = (ok(defined $self->{users}->[1], "User2 is defined") and $return);
    
    if (not $return) {
        diag("[ERROR] You must pass in config/example.json file into test_runner using -d parameter");
    }
    
    return $return;
}

sub test_print_users {
    my $self = shift;
    
    foreach my $user (@{$self->{users}}) {
        diag("name:$user->{name} - id:$user->{id}");
    }
    
    return 1;
}