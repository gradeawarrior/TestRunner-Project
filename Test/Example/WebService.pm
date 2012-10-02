package Test::Example::WebService;

use strict;
use base qw(QA::Test::TestCase);
use Test::More;
use QA::Test::WebService::Session;

sub set_up {
    my $self = shift;
    
    $self->{test_session} = my $test_session = QA::Test::WebService::Session->new();
    $self->{test_session}->start();

    return ok(defined $self->{test_session}, "Test Session defined");
}

sub tear_down {
    my $self = shift;
    $self->{test_session}->stop();
    diag("Test took a total of " . $self->{test_session}->{elapsed}. " seconds");
}

sub test_hit_google {
    my $self = shift;
    my $return = 1;
    
    my $response = $self->{test_session}->runTest(
        'testname'  =>  'Hit Google',
        'method'    =>  'GET',
        'url'       =>  "http://www.google.com",
        'debug'     =>  $self->{debug}
    );
    $return = $self->{test_session}->verify_code(200);
    $return = ($self->{test_session}->verify_header("Content-Type", "text/html") and $return);
    
    return $return;
}