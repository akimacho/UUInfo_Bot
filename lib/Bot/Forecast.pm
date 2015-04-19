package Bot::Forecast;
use strict;
use warnings;
use utf8;
use Carp qw/croak/;
use URI;
use LWP::UserAgent;
use JSON;

sub new {
	my ($class) = @_;
	my $uri = URI->new('http://weather.livedoor.com/forecast/webservice/json/v1');
	$uri->query_form(city => '090010'); # 090010 is a id of Utsunomiya city
	my $ua = LWP::UserAgent->new;
	my $res = $ua->get($uri);
	croak $res->status_line if $res->is_error;
	my $content = decode_json($res->content);
	my $forecasts = {
		today => {
			whether => $content->{forecasts}->[0]->{telop},
		},
		tomorrow => {
			whether => $content->{forecasts}->[1]->{telop},
		},
	};
	return bless $forecasts, $class;
}

sub today_forecast {
	my $self = shift;
	return $self->{today}->{whether};
}

sub tomorrow_forecast {
	my $self = shift;
	return $self->{tomorrow}->{whether};
}

1;
