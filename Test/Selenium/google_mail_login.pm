package Test::Selenium::google_mail_login;

use strict;
use base qw(QA::Test::TestCase);
use Test::More;


########################################################################
######################## Common Set-up #################################
########################################################################

sub set_up
{
    my $self = shift;
    
    ## Check for required variables
    return 0 unless ok((
        defined $self->{selenium}->{host},
        and defined $self->{selenium}->{port},
        and defined $self->{selenium}->{browser},
        and defined $self->{selenium}->{url}
    ),"Selenium Configurations passed!");
    
    ## Please ignore Selenium Singleton Referencing Logic
    $self->{sel} = $self->get_selenium_singleton(
        host => $self->{selenium}->{host},
        port => $self->{selenium}->{port},
        browser => $self->{selenium}->{browser},
        browser_url => $self->{selenium}->{url},
        slow_down => $self->{selenium}->{slow_down},
        debug => $self->{selenium}->{debug},
        enable_network_capture => $self->{selenium}->{enable_network_capture}
    );
    $self->{sel}->start();
    
    ## Go To Homepage
    $self->{sel}->open_ok("$self->{selenium}->{url}");
    $self->{sel}->click_ok("link=Sign out") unless not $self->{sel}->is_element_present("link=Sign out");
    
    return 1;
}


########################################################################
############################### Tests ##################################
########################################################################

sub test_login_valid
{
    my $self = shift;
    my $sel = $self->{sel};
    
    ## Login
    $sel->type_ok("Email", $self->{credentials}->{user});
    $sel->type_ok("Passwd", $self->{credentials}->{password});
    $sel->click_and_wait_ok("signIn");
    
    ## Logout
    $self->verify_success();
    $sel->click_ok("link=Sign out");
    #$sel->open_ok("https://mail.google.com/mail/?logout");
    
    return 1;
}

sub test_login_empty
{
    my $self = shift;
    my $sel = $self->{sel};
    
    ## Login
    $sel->type_ok("Email", "");
    $sel->type_ok("Passwd", "");
    $sel->click_and_wait_ok("signIn");
    
    ## Verify Object is NOT present
    $self->verify_failure();
    
    return 1;
}

sub test_login_no_password #()
{
    my $self = shift;
    my $sel = $self->{sel};
    
    ## Login
    $self->login($self->{credentials}->{user}, "");
    
    ## Verify Object is NOT present
    $self->verify_failure();
    
    return 1;
}


########################################################################
######################## Common Sub-routines ###########################
########################################################################

sub login #($user, $password)
{
    my ($self, $user, $password) = @_;
    my $sel = $self->{sel};
    my $eval = 1;
    
    $eval = ($sel->type_ok("Email", $user) and $eval);
    $eval = ($sel->type_ok("Passwd", $password) and $eval);
    $eval = ($sel->click_and_wait_ok("signIn") and $eval);
    
    return $eval;
}


########################################################################
######################## Verifications #################################
########################################################################


sub verify_success #()
{
    my ($self) = @_;
    my $sel = $self->{sel};
    return ok(($sel->is_element_present("link=Sign out")), "Sign out link is present!");
}

sub verify_failure #()
{
    my ($self) = @_;
    my $sel = $self->{sel};
    return ok((not $sel->is_element_present("link=Sign out")), "Successfully failed to login!");
}
