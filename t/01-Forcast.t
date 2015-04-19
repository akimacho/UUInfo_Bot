use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib/";
use Test::More;
use URI;
use LWP::UserAgent;
use JSON;

BEGIN {
	use_ok('Bot::Forecast');
}

my $forecast = Bot::Forecast->new;
isa_ok($forecast, 'Bot::Forecast');

my $uri = URI->new('http://weather.livedoor.com/forecast/webservice/json/v1');
$uri->query_form(city => '090010');
my $ua = LWP::UserAgent->new;
my $res = $ua->get($uri);
die $res->status_line if $res->is_error;
my $content = decode_json($res->content);
is($forecast->today_forecast, $content->{forecasts}->[0]->{telop}, 'today forecast');
is($forecast->tomorrow_forecast, $content->{forecasts}->[1]->{telop}, 'tomorrow forecast');

done_testing;
