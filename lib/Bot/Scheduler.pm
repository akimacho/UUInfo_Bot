package Bot::Scheduler;
use strict;
use warnings;
use Time::Piece;
use Time::Seconds;

sub new {
	my ($class, %args) = @_;
	return bless \%args, $class;
}

sub getInterval {
	my $self = shift;
	my ($from, $to) = split(/-/, $self->{term});
	my $length = defined $_[0] ? $_[0] : ($to - $from);
	my $interval = ($to - $from) * ONE_HOUR / $length;
	return $interval;
}

1;
