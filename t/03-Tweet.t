use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib/";
use Test::More;

BEGIN {
	use_ok('Bot::Tweet');
}

my $tweetor = Bot::Tweet->new;
isa_ok($tweetor, 'Bot::Tweet');

done_testing;
