#usr/bin/env perl
use strict;
use warnings;
use utf8;
use Encode qw/encode_utf8 decode_utf8/;
use FindBin;
use lib "$FindBin::Bin/lib/";
use Bot::Message;
use Bot::Forecast;
use Bot::DB;
use Bot::Tweet;
use Bot::Scheduler;
use Bot::Deadline;

my $message = Bot::Message->new;
my $forecast = Bot::Forecast->new;
my $scheduler = Bot::Scheduler->new(term => '7-18');
my $deadline = Bot::Deadline->new;
my $db = Bot::DB->new({
	dsn => 'dbi:SQLite:dbname=events.db',
});
my $itr = $db->search('Deadline', {});

print $itr->count, "\n";
print $scheduler->getInterval($itr->count), "\n";
print $message->goodmorning(today => $forecast->today_forecast,);
while (my $row = $itr->next) {
	my $msg = $message->getTweetMassage(
		id			 => $row->id,
		title		 => decode_utf8($row->event_title),
		date		 => $row->event_date,
		sense		 => $row->event_sense,
		leftdays => $deadline->leftdays($row->event_date),
	);
	print $msg, "\n\n";
}
print $message->goodevening(tomorrow => $forecast->tomorrow_forecast,);
