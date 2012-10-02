package Google::Authentication;

use strict;
use Test::More;
use Carp qw(croak);

sub login #($sel, $user, $password)
{
    my ($self, $sel, $user, $password) = @_;
    my $func = (caller(0))[3];
    croak "sel undefined at $func!" unless defined $sel;
    croak "user undefined at $func!" unless defined $user;
    croak "password undefined at $func!" unless defined $password;
    my $eval = 1;
    
    $eval = ($sel->type_ok("Email", $user) and $eval);
    $eval = ($sel->type_ok("Passwd", $password) and $eval);
    $eval = ($sel->click_and_wait_ok("signIn") and $eval);
    
    return $eval;
}

sub logout #($sel)
{
    my ($self, $sel) = @_;
    my $func = (caller(0))[3];
    croak "sel undefined at $func!" unless defined $sel;
    my $eval = 1;
    
    diag("User is not logged-in") unless ($sel->is_element_present("link=Sign out"));
    return 1 unless ($sel->is_element_present("link=Sign out"));
    #$sel->click_ok("link=Sign out");
    $sel->open_ok("https://mail.google.com/mail/?logout");
    
    return $eval;
}

1;