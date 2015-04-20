use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib/";
use Test::More;

BEGIN {
	use_ok('Bot::Scheduler');
}

my $scheduler = Bot::Scheduler->new(term => '7-18');
isa_ok($scheduler, 'Bot::Scheduler');

is($scheduler->getInterval, 3600, 'no parameter');
is($scheduler->getInterval(2), 19800, 'with parameter');

done_testing;
