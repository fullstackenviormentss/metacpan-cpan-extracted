#Test behavior if the server magically disappears
#Basically the policy is no death, return false when this happens.

use strict;
use warnings;

use TestRail::API;
use Test::More 'tests' => 54;
use Test::Fatal;
use Class::Inspector;
use Test::LWP::UserAgent;
use HTTP::Response;
use Capture::Tiny qw{capture};

my $tr = TestRail::API->new('http://hokum.bogus','bogus','bogus',undef,1);
$tr->{'browser'} = Test::LWP::UserAgent->new();
$tr->{'browser'}->map_response(qr/.*/, HTTP::Response->new('500', 'ERROR', ['Content-Type' => 'text/plain'], ''));

my $res;
capture { $res = $tr->_doRequest('badMethod')};
is($res, -500,"Bad Request fails");

is($tr->apiurl,'http://hokum.bogus',"APIURL OK");
is($tr->debug,1,"DEBUG OK");

capture {$res = $tr->createCase(1,'whee',1)};
is($res,-500,'createCase returns error');
capture {$res = $tr->createMilestone(1,'whee')};
is($res,-500,'createMilestone returns error');
capture {$res = $tr->createPlan(1,'whee')};
is($res,-500,'createPlan returns error');
capture {$res = $tr->createProject('zippy')};
is($res,-500,'createProject returns error');
capture {$res = $tr->createRun(1,1,'whee')};
is($res,-500,'createRun returns error');
capture {$res = $tr->createSection(1,1,'whee')};
is($res,-500,'createSection returns error');
capture {$res = $tr->createTestResults(1,1)};
is($res,-500,'createTestResults returns error');
capture {$res = $tr->createTestSuite(1,'zugzug')};
is($res,-500,'createTestSuite returns error');
capture {$res = $tr->deleteCase(1)};
is($res,-500,'deleteCase returns error');
capture {$res = $tr->deleteMilestone(1)};
is($res,-500,'deleteMilestone returns error');
capture {$res = $tr->deletePlan(1)};
is($res,-500,'deletePlan returns error');
capture {$res = $tr->deleteProject(1)};
is($res,-500,'deleteProject returns error');
capture {$res = $tr->deleteRun(1)};
is($res,-500,'deleteRun returns error');
capture {$res = $tr->deleteSection(1)};
is($res,-500,'deleteSection returns error');
capture {$res = $tr->deleteTestSuite(1)};
is($res,-500,'deleteTestSuite returns error');
capture {$res = $tr->getCaseByID(1)};
is($res,-500,'getCaseByID returns error');
capture {$res = $tr->getCaseByName(1,1,'hug')};
is($res,-500,'getCaseByName returns error');
capture {$res = $tr->getCaseTypeByName('zap')};
is($res,-500,'getCaseTypeByName returns error');
capture {$res = $tr->getCaseTypes()};
is($res,-500,'getCaseTypes returns error');
capture {$res = $tr->getCases(1,2)};
is($res,-500,'getCases returns error');
capture {$res = $tr->getMilestoneByID(1)};
is($res,-500,'getMilestoneByID returns error');
capture {$res = $tr->getMilestoneByName(1,'hug')};
is($res,-500,'getMilestoneByName returns error');
capture {$res = $tr->getMilestones(1)};
is($res,-500,'getMilestones returns error');
capture {$res = $tr->getPlanByID(1)};
is($res,-500,'getPlanByID returns error');
capture {$res = $tr->getPlanByName(1,'nugs')};
is($res,-500,'getPlanByName returns error');
capture {$res = $tr->getPlans(1)};
is($res,-500,'getPlans returns error');
capture {$res = $tr->getPossibleTestStatuses()};
is($res,-500,'getPossibleTestStatuses returns error');
capture {$res = $tr->getProjectByID(1)};
is($res,-500,'getProjectByID returns error');
capture {$res = $tr->getProjectByName('fake')};
is($res,-500,'getProjectByName returns error');
capture {$res = $tr->getProjects()};
is($res,-500,'getProjects returns error');
capture {$res = $tr->getRunByID(1)};
is($res,-500,'getRunByID returns error');
capture {$res = $tr->getRunByName(1,'zoom')};
is($res,-500,'getRunByName returns error');
capture {$res = $tr->getRuns(1)};
is($res,-500,'getRuns returns error');
capture {$res = $tr->getSectionByID(1)};
is($res,-500,'getSectionByID returns error');
capture {$res = $tr->getSectionByName(1,1,'zip')};
is($res,-500,'getSectionByName returns error');
capture {$res = $tr->getSections(1,1)};
is($res,-500,'getSections returns error');
capture {$res = $tr->getTestByID(1)};
is($res,-500,'getTestByID returns error');
capture {$res = $tr->getTestByName(1,'poo')};
is($res,-500,'getTestByName returns error');
capture {$res = $tr->getTestResultFields()};
is($res,-500,'getTestResultFields returns error');
capture {$res = $tr->getTestResults(1,1)};
is($res,-500,'getTestResults returns error');
capture {$res = $tr->getTestSuiteByID(1)};
is($res,-500,'getTestSuiteByID returns error');
capture {$res = $tr->getTestSuiteByName(1,'zap')};
is($res,-500,'getTestSuiteByName returns error');
capture {$res = $tr->getTestSuites(1)};
is($res,-500,'getTestSuites returns error');
capture {$res = $tr->getTests(1)};
is($res,-500,'getTests returns error');
capture {$res = $tr->getUserByEmail('tickle')};
is($res,0,'getUserByEmail returns error');
capture {$res = $tr->getUserByID(1)};
is($res,0,'getUserByID returns error');
capture {$res = $tr->getUserByName('zap')};
is($res,0,'getUserByName returns error');
capture {$res = $tr->getUsers()};
is($res,-500,'getUsers returns error');
capture {$res = $tr->getConfigurations(1)};
is($res,-500,'getConfigurations returns error');
capture {$res = $tr->closePlan(1)};
is($res,-500,'closePlan returns error');
capture {$res = $tr->closeRun(1)};
is($res,-500,'closeRun returns error');
