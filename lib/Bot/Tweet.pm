package Bot::Tweet;
use strict;
use warnings;
use Config::Tiny;
use FindBin;
use Carp qw/croak carp/;
use base qw/Net::Twitter::Lite::WithAPIv1_1/;
use Scalar::Util qw/blessed/;

sub new {
	my $class = shift;
	my $config = Config::Tiny->read("$FindBin::Bin/twitter.config", 'utf8');
	my $nt = $class->SUPER::new(
		consumer_key => $config->{twitter}->{consumer_key},
		consumer_secret => $config->{twitter}->{consumer_secret},
		access_token => $config->{twitter}->{access_token},
		access_token_secret => $config->{twitter}->{access_token_secret},
		ssl => 1,
	);
	return bless $nt, $class;
}

sub tweet {
	my ($self, $msg) = @_;
	eval {
		$self->update($msg);
	};
	if (my $err = $@) {
		croak $@ unless blessed $err && $err->isa('Net::Twitter::Lite::Error');
		carp "HTTP Response Code: ", $err->code, "\n",
			"HTTP Message......: ", $err->message, "\n",
			"Twitter error.....: ", $err->error, "\n";
	}
}

1;
