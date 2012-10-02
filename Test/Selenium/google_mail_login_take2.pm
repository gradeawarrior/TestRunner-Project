package Test::Selenium::google_mail_login_take2;

use strict;
use base qw(QA::Test::TestCase);
use Test::More;
use Google::Authentication;


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
    Google::Authentication->logout($self->{sel});
    
    return 1;
}


########################################################################
############################### Tests ##################################
########################################################################

sub test_login_valid_positive #()
{
    my $self = shift;
    my $sel = $self->{sel};
    
    ## Login
    Google::Authentication->login($sel, $self->{credentials}->{user}, $self->{credentials}->{password});
    
    ## Logout
    $self->verify_success();
    Google::Authentication->logout($sel);
    
    return 1;
}

sub test_login_empty_negative #()
{
    my $self = shift;
    my $sel = $self->{sel};
    
    ## Login
    Google::Authentication->login($sel, "", "");
    
    ## Verify Object is NOT present
    $self->verify_failure();
    
    return 1;
}

sub test_login_no_password_negative #()
{
    my $self = shift;
    my $sel = $self->{sel};
    
    ## Login
    Google::Authentication->login($sel, $self->{credentials}->{user}, "");
    
    ## Verify Object is NOT present
    $self->verify_failure();
    
    return 1;
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
