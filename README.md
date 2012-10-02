# Description

These are sample test scripts for the TestRunner Framework. The TestRunner framework libraries can be found on github under [QA-Perl-Lib](https://github.com/gradeawarrior/QA-Perl-Lib)

For high-level information about the [TestRunner Framework](https://github.com/gradeawarrior/QA-Perl-Lib/wiki/Test-Runner-Unit-Test-Framework), see the wiki under the [QA-Perl-Lib](https://github.com/gradeawarrior/QA-Perl-Lib/wiki/Test-Runner-Unit-Test-Framework) project.

# Installation

### 1. Install make and cpan

You will need *make* and *cpan* installed on your system. For notes on how to do this on OS X, see [Installing CPAN Notes](https://github.com/gradeawarrior/QA-Perl-Lib/wiki/Installing-CPAN-Notes).

### 2. Checkout QA Perl Libraries 

The testing perl libraries can be checked out here: 

	git clone git@github.com:gradeawarrior/QA-Perl-Lib.git

### 3. Install QA Perl Libraries 

The required CPAN libraries and installer can be found under the *cpan* directory. 

Once checked out, run the 'install-CPAN-Modules.sh' script to install the following modules listed in cpan/cpan_modules.list. It is required that all these modules be installed. See the README file for more information.

### 4. Export test_runner client tool

For the TestRunner framework, you will need the *test_runner* script. You can either copy (or symlink) this file into your scripts directory, or add a new entry in /etc/paths.d/:

	$ sudo vi /etc/paths.d/testrunner
	
And add the following contents:

	<YOUR_PATH>/QA-Perl-Lib/

### 5. Example Test Project
 
To help you get started in using the framework, checkout the following Test Project from github: 
 
	git clone git@github.com:gradeawarrior/TestRunner-Project.git  

Once checked out, cd into directory and try running the help: 
 
	  $ test_runner -h
  	Usage: /Users/psalas/Dev/git/qa-perl-lib/test_runner [-d/--datafile DATA_FILES] [-t/--test TEST] [-i/--include INCLUDE_DIRS] [-h/--help] [-v/--verbosity LEVEL] TestCase [TestCase]
  
  	Examples:
      
          test_runner -d config/imphal-config.json Test/Farmd/BasicEndpoints.pm
          test_runner -d config/imphal-config.json Test/FarmdIntegration/SendMail*
          test_runner -d config/imphal-config.json Test/FarmdIntegration/SendMail* -t ham
          test_runner -d config/imphal-config.json Test/FarmdIntegration/SendMail* -t ham spam
          test_runner -d config/imphal-config.json Test/Farmd/BasicEndpoints.pm Test/FarmdIntegration/SendMail* -t ham
          
  	Description:
  
          Uses the Test Runner Framework which is a Perl based implementation of
          the popular unit-test pattern xUnit. TestCases passed into framework
          should be blessed as type QA::Test::TestCase.
          
  	Details:
  
          -d/--datafile   A user defined configuration(s) file that will be
              DATA_FILES  imported into each TestCase object. This is how you
                          parameterize your variables within your script.
                          
          -t/--tests      An optional parameter where you can specify which tests
              TEST        or 'test_' subroutine to execute. This can be a list
                          of test sub-routines to execute against and uses regular
                          expression to evaluate.
                          
          -i/--include    A list of include directories if your script has
              INCLUDE     dependant perl libraries or packages that are not
                          currently a part of default Perl paths.
                          
          -v/--verbosity	Sets the verbosity level of your tests. CLEAN means that
              CLEAN	only your test subroutine will be printed if any
              INFO	failures occur. INFO will do the same as CLEAN, except
              TRACE	that if a failure occurs, then the verifications that
              DEBUG	lead to the failure are printed. TRACE will print
                          everything within the test subroutine call to STDOUT.
                          DEBUG will print everything including the set_up and
                          tear_down operations to STDOUT.
                          
          -h/--help       Prints this usage message
          
          TestCase        A perl module that is of type QA::Test::TestCase

# Usage

The sample TestRunner project contains examples for how to use the TestRunner framework. The framework consists of the following parts:

1. The [QA-Perl-Lib](https://github.com/gradeawarrior/QA-Perl-Lib)raries (aka the Framework Libraries)
2. DSL (Domain-Specific-Library) libraries specific to your product/project
3. Configuration
4. Scripts

The sample project will utilize each one of these above concepts.

## Run all test scripts under Test/Example with example.json configuration

	$ test_runner -d config/example.json Test/Example/*
	# ******** Testing Class 'Test::Example::Looping' ********
	PASS - Test::Example::Looping::test_looping
	# ******** Testing Class 'Test::Example::ParametersExample' ********
	PASS - Test::Example::ParametersExample::test_print_users
	# ******** Testing Class 'Test::Example::PassFail' ********
	PASS - Test::Example::PassFail::test_bye_world
	FAIL - Test::Example::PassFail::test_fail
	PASS - Test::Example::PassFail::test_hello_world
	# ******** Testing Class 'Test::Example::WebService' ********
	PASS - Test::Example::WebService::test_hit_google
    
    	Execution Statistics
    	====================
    	Tests:
        	- Execution Time:   0.166668 seconds
        	- Total:            6 tests
        	- Pass:             5 tests (83.333%)
        	- Fail:             1 tests (16.667%)
    	Verifications:
        	- Total:            15 verified
        	- Pass:             14 ok (93.333%)
        	- Fail:             1 not ok (6.667%)
    
    	Failed Tests:
        	1 - test_fail in Test::Example::PassFail
	1..15
	# Looks like you failed 1 test of 15.
	
You can see that you have one failed test giving you the following information:

- **Execution Time:** It took 0.166668 seconds
- **Pass Rate:** 83% pass rate
- **Fail Rate:** 16% fail rate
- **Verification Rate:** Of the 6 tests, there are a total of 15 verification checks that were evaluated with 1 verification that failed. A verification is a soft-assertion in the framework, and a single failed assertion means that the test is a failure.
- **Test Failures:** A list of failed tests in which file

## Re-run only the failed test from above with verbosity set to 'TRACE'

You have the option of choosing to run only a sub-set of tests via the '-t' option. To see more information about the execution of the test, you can set the verbosity level with '-v' option.

	$ test_runner -d config/example.json Test/Example/* -t test_fail -v TRACE
	# ******** Testing Class 'Test::Example::Looping' ********
	# ******** Testing Class 'Test::Example::ParametersExample' ********
	# ******** Testing Class 'Test::Example::PassFail' ********
	# -------->> Test Subroutine - Test::Example::PassFail::test_fail()
	not ok 1 - Failing this test
	#   Failed test 'Failing this test'
	#   at Test/Example/PassFail.pm line 25.
	FAIL - Test::Example::PassFail::test_fail
	# ******** Testing Class 'Test::Example::WebService' ********
    
    	Execution Statistics
    	====================
    	Tests:
        	- Execution Time:   7.9e-05 seconds
        	- Total:            1 tests
        	- Pass:             0 tests (0.000%)
        	- Fail:             1 tests (100.000%)
    	Verifications:
        	- Total:            1 verified
        	- Pass:             0 ok (0.000%)
        	- Fail:             1 not ok (100.000%)
    
    	Failed Tests:
        	1 - test_fail in Test::Example::PassFail
	1..1
	# Looks like you failed 1 test of 1.

## Configurations file

A script can optionally use a configuration file. For *Test/Example/ParameterExample.pm* script, it requires the following configurations to be defined:
	
	{ "users":
    	[
        	{
            	"name":"user1",
            	"id":1
        	},
        	{
            	"name":"user2",
            	"id":2
        	}
    	]
	}

When executed without the configuration file, you see the following exceptions and failures:

	$ testrunner-project psalas$ test_runner Test/Example/ParametersExample.pm 
	# ******** Testing Class 'Test::Example::ParametersExample' ********
	FAIL - Test::Example::ParametersExample::test_print_users (set_up)
	# $value is not a valid type boolean (true/false or 1/0) - value:'' ref: in QA::Test::Util::Boolean::isTrue
	# $value is not a valid type boolean (true/false or 1/0) - value:'' ref: in QA::Test::Util::Boolean::isTrue
    
    	Execution Statistics
    	====================
    	Tests:
        	- Execution Time:   0.003026 seconds
        	- Total:            1 tests
        	- Pass:             0 tests (0.000%)
        	- Fail:             1 tests (100.000%)
    	Verifications:
        	- Total:            3 verified
        	- Pass:             0 ok (0.000%)
        	- Fail:             3 not ok (100.000%)
    
    	Failed Tests:
        	1 - test_print_users in Test::Example::ParametersExample
	1..3
	# Looks like you failed 3 tests of 3.

Passing the config resolves the dependency problem:

	$ test_runner Test/Example/ParametersExample.pm -d config/example.json -v TRACE
	# ******** Testing Class 'Test::Example::ParametersExample' ********
	# -------->> Test Subroutine - Test::Example::ParametersExample::test_print_users()
	# name:user1 - id:1
	# name:user2 - id:2
	PASS - Test::Example::ParametersExample::test_print_users
    
    	Execution Statistics
    	====================
    	Tests:
        	- Execution Time:   0.003037 seconds
        	- Total:            1 tests
        	- Pass:             1 tests (100.000%)
        	- Fail:             0 tests (0.000%)
    	Verifications:
        	- Total:            3 verified
        	- Pass:             3 ok (100.000%)
        	- Fail:             0 not ok (0.000%)
    
    	Failed Tests:
	1..3
	
# A Real Example - Testing a BlobStorage Service

The following is an example project (code not included) of a BlobStorage API. It uses an additional parameter '-i' to include the DSL libraries for testing this service:

	$ test_runner -d config/peter-config.json -i lib/ Test/StorageService/*
	# ******** Testing Class 'Test::StorageService::v1_content_delete' ********
	PASS - Test::StorageService::v1_content_delete::test_delete_content_positive
	PASS - Test::StorageService::v1_content_delete::test_delete_non_existent_key_negative
	PASS - Test::StorageService::v1_content_delete::test_delete_previously_deleted_key_negative
	PASS - Test::StorageService::v1_content_delete::test_no_authentication_negative
	PASS - Test::StorageService::v1_content_delete::test_no_key_negative
	PASS - Test::StorageService::v1_content_delete::test_no_ssl_negative
	# ******** Testing Class 'Test::StorageService::v1_content_get' ********
	PASS - Test::StorageService::v1_content_get::test_get_content_positive
	PASS - Test::StorageService::v1_content_get::test_no_authentication_negative
	PASS - Test::StorageService::v1_content_get::test_no_key_negative
	PASS - Test::StorageService::v1_content_get::test_no_ssl_negative
	# ******** Testing Class 'Test::StorageService::v1_content_head' ********
	PASS - Test::StorageService::v1_content_head::test_head_operation_positive
	PASS - Test::StorageService::v1_content_head::test_no_authentication_negative
	PASS - Test::StorageService::v1_content_head::test_no_key_negative
	PASS - Test::StorageService::v1_content_head::test_no_ssl_negative
	PASS - Test::StorageService::v1_content_head::test_non_existent_key_negative
	# ******** Testing Class 'Test::StorageService::v1_content_partial_get' ********
	PASS - Test::StorageService::v1_content_partial_get::test_generate_entire_blob_by_retrieving_in_bytes_of_100_positive
	PASS - Test::StorageService::v1_content_partial_get::test_generate_entire_blob_by_retrieving_in_bytes_of_10_positive
	PASS - Test::StorageService::v1_content_partial_get::test_get_100_bytes_over_positive
	PASS - Test::StorageService::v1_content_partial_get::test_get_entire_content_positive
	PASS - Test::StorageService::v1_content_partial_get::test_get_first_10_bytes_positive
	PASS - Test::StorageService::v1_content_partial_get::test_get_last_10_bytes_positive
	PASS - Test::StorageService::v1_content_partial_get::test_get_out_of_range_bytes_negative
	PASS - Test::StorageService::v1_content_partial_get::test_no_authentication_negative
	PASS - Test::StorageService::v1_content_partial_get::test_no_key_negative
	PASS - Test::StorageService::v1_content_partial_get::test_no_ssl_negative
	# ******** Testing Class 	'Test::StorageService::v1_content_post' ********
	PASS - Test::StorageService::v1_content_post::test_no_authentication_negative
	PASS - Test::StorageService::v1_content_post::test_no_key_negative
	PASS - Test::StorageService::v1_content_post::test_no_sha256_negative
	PASS - Test::StorageService::v1_content_post::test_no_ssl_negative
	PASS - Test::StorageService::v1_content_post::test_request_key_non_existent_sha_negative
	PASS - Test::StorageService::v1_content_post::test_request_new_key_positive
	PASS - Test::StorageService::v1_content_post::test_request_same_key_positive
	# ******** Testing Class 	'Test::StorageService::v1_content_put' ********
	PASS - Test::StorageService::v1_content_put::test_all_alpha_key_positive
	PASS - Test::StorageService::v1_content_put::test_all_numeric_key_positive
	PASS - Test::StorageService::v1_content_put::test_alpha_numeric_key_positive
	PASS - Test::StorageService::v1_content_put::test_dummy_url_parameters_positive
	FAIL - Test::StorageService::v1_content_put::test_incorrect_hash_negative
	PASS - Test::StorageService::v1_content_put::test_insert_blank_blob_incorrect_sha_negative
	PASS - Test::StorageService::v1_content_put::test_insert_blank_blob_positive
	PASS - Test::StorageService::v1_content_put::test_insert_small_blob_positive
	PASS - Test::StorageService::v1_content_put::test_legalhold_key_syntax_positive
	PASS - Test::StorageService::v1_content_put::test_new_content_positive
	PASS - Test::StorageService::v1_content_put::test_no_authentication_negative
	PASS - Test::StorageService::v1_content_put::test_no_key_negative
	PASS - Test::StorageService::v1_content_put::test_no_sha256_positive
	PASS - Test::StorageService::v1_content_put::test_no_ssl_negative
	PASS - Test::StorageService::v1_content_put::test_same_content_in_existing_key_positive
	PASS - Test::StorageService::v1_content_put::test_same_content_in_new_key_positive
	PASS - Test::StorageService::v1_content_put::test_special_characters_dash_positive
	FAIL - Test::StorageService::v1_content_put::test_special_characters_plus_positive
	PASS - Test::StorageService::v1_content_put::test_special_characters_underscore_positive
	PASS - Test::StorageService::v1_content_put::test_trailing_slash_after_key_positive
	PASS - Test::StorageService::v1_content_put::test_updated_content_in_existing_key_negative
	PASS - Test::StorageService::v1_content_put::test_updated_content_in_new_key_postive
    
    	Execution Statistics
    	====================
    	Tests:
        	- Execution Time:   0.928094 seconds
        	- Total:            54 tests
        	- Pass:             52 tests (96.296%)
        	- Fail:             2 tests (3.704%)
    	Verifications:
        	- Total:            604 verified
        	- Pass:             600 ok (99.338%)
        	- Fail:             4 not ok (0.662%)
    
    	Failed Tests:
        	1 - test_incorrect_hash_negative in Test::StorageService::v1_content_put
        	2 - test_special_characters_plus_positive in Test::StorageService::v1_content_put
	1..604
	# Looks like you failed 4 tests of 604.

There were 2 test failures on the v1_content_put API, therefore, I am going to re-execute one of those tests and set the verbosity to *DEBUG* so that I can see what's going on:

	$ test_runner -d config/peter-config.json -i lib/ Test/StorageService/v1_content_put.pm -v DEBUG -t test_incorrect_hash_negative
	# ******** Testing Class 'Test::StorageService::v1_content_put' ********
	# -------->> Test Subroutine - Test::StorageService::v1_content_put::set_up_test_incorrect_hash_negative()
	ok 1 - Storage Services node defined - $self->{service}->{host}
	ok 2 - Storage Services Basic Auth user/password defined
	# -------->> Test Subroutine - Test::StorageService::v1_content_put::test_incorrect_hash_negative()
	# Request:
	# PUT http://10.21.43.37:20280/v1/content/59TNjGqrSs
	# Authorization: Basic c3M6c3M=
	# Content-Length: 50
	# X-Proofpoint-Content-SHA256: c3ab8ff13720e8ad9047dd39466b3c8974e592c2fa383d4a3960714caef0c4f2
	# 
	# 7k8gTSx1DGfzOSIAtpOAtbUey9a2sccCMFeYqo2udN52ElzBzb
	# 
	# Response:
	# HTTP/1.1 201 Created
	# Connection: close
	# Location: http://10.21.43.37:20280/v1/content/59TNjGqrSs
	# Client-Date: Tue, 02 Oct 2012 21:14:23 GMT
	# Client-Peer: 10.21.43.37:20280
	# Client-Response-Num: 1
	# Link: http://10.21.43.37:20280/v1/content/59TNjGqrSs; rel="self"
	# X-Proofpoint-Content-SHA256: 358e56435a6ad4c088df6e23e2471b6659fc917a08681b34f417a26c9a3f2eb6
	# 
	not ok 3 - Response code should be 400 Bad Request - actual: 201
	#   Failed test 'Response code should be 400 Bad Request - actual: 201'
	#   at /Users/psalas/lib/QA/Test.pm line 91.
	ok 4 - Created
	not ok 5 - Response code should not be 201 Created - actual: 201
	#   Failed test 'Response code should not be 201 Created - actual: 201'
	#   at /Users/psalas/lib/QA/Test.pm line 91.
	not ok 6 - Response message should not be 201 Created - actual: Created
	#   Failed test 'Response message should not be 201 Created - actual: Created'
	#   at /Users/psalas/lib/QA/Test.pm line 91.
	FAIL - Test::StorageService::v1_content_put::test_incorrect_hash_negative
	# -------->> Test Subroutine - Test::StorageService::v1_content_put::tear_down_test_incorrect_hash_negative()
	# Request:
	# DELETE http://10.21.43.37:20280/v1/content/59TNjGqrSs
	# Authorization: Basic c3M6c3M=
	# 
	# 
	# Response:
	# HTTP/1.1 204 No Content
	# Connection: close
	# Client-Date: Tue, 02 Oct 2012 21:14:23 GMT
	# Client-Peer: 10.21.43.37:20280
	# Client-Response-Num: 1
	# 
	ok 7 - Response code should be 204 - actual: 204
    
    	Execution Statistics
    	====================
    	Tests:
        	- Execution Time:   3.400468 seconds
        	- Total:            1 tests
        	- Pass:             0 tests (0.000%)
        	- Fail:             1 tests (100.000%)
    	Verifications:
        	- Total:            7 verified
        	- Pass:             4 ok (57.143%)
        	- Fail:             3 not ok (42.857%)
    
    	Failed Tests:
        	1 - test_incorrect_hash_negative in Test::StorageService::v1_content_put
	1..7
	# Looks like you failed 3 tests of 7.

As you can see, with verbosity set to *DEBUG* we can see the actual http request/response output, along with the validations. Thus, further enabling the test engineer to decide whether it is a problem with the test or a problem with the service.