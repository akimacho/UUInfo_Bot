use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib/";
use Test::More;
use Time::Piece;
use Time::Seconds;
use POSIX qw/ceil/;

BEGIN {
	use_ok('Bot::Deadline');
}

my $current_date = Bot::Deadline->new(
	date => localtime->date
);
isa_ok($current_date, 'Bot::Deadline');
is($current_date->leftdays, 0, 'the day of the event');

my $month_last_day = Bot::Deadline->new(
	date => localtime->strftime('%Y-%m') . '-' . localtime->month_last_day
);
my $l = localtime->strptime(
	localtime->strftime('%Y-%m') . '-' . localtime->month_last_day,
	'%Y-%m-%d'
);
my $t = localtime;
is(
	$month_last_day->leftdays,
	ceil(($l - $t) / ONE_DAY),
	'the date of the event is the end of the month'
);

my $yesterday = Bot::Deadline->new(
	(localtime() - ONE_DAY)->strftime('%Y-%m-%d')
);
is($yesterday->leftdays, -1, 'time is up');

done_testing;

