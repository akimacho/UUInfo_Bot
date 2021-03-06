use strict;
use warnings;
use utf8;
use Encode qw/encode_utf8 decode_utf8/;
use FindBin;
use lib "$FindBin::Bin/lib/";
use Bot::Message;
use Bot::Forecast;
use Bot::DB;
use Bot::Scheduler;
use Bot::Deadline;
use Bot::Tweet;

my $message = Bot::Message->new;
my $forecast = Bot::Forecast->new;
my $scheduler = Bot::Scheduler->new(term => '7-18');
my $deadline = Bot::Deadline->new;
my $tweetor = Bot::Tweet->new;
my $db = Bot::DB->new({
	dsn => 'dbi:SQLite:dbname=events.db',
});

my $itr = $db->search('Deadline', {});
my $interval = $scheduler->getInterval($itr->count);
my $gd_msg = $message->goodmorning(today => $forecast->today_forecast,);
print encode_utf8($gd_msg), "\n";
# $tweetor->tweet($gd_msg);

while (my $row = $itr->next) {
	my $leftdays = $deadline->leftdays($row->event_date);
	next if ($leftdays < 0);
	my $msg = $message->getTweetMassage(
		id			 => decode_utf8($row->id),
		title		 => decode_utf8($row->event_title),
		date		 => decode_utf8($row->event_date),
		sense		 => decode_utf8($row->event_sense),
		leftdays => $leftdays,
	);
	print encode_utf8($msg), "\n";
	#$tweetor->tweet($msg);
	#sleep($interval)
}

my $ge_msg = $message->goodevening(tomorrow => $forecast->tomorrow_forecast,);
print encode_utf8($ge_msg), "\n";
$tweetor->tweet($ge_msg);
