package Bot::Deadline;
use strict;
use warnings;
use Time::Piece;
use Time::Seconds;
use POSIX qw/ceil/;

sub new {
	my ($class, %args) = @_;
	return bless \%args, $class;
}

sub leftdays {
	my ($self, $date) = @_;
	my $event_date = localtime->strptime($date, '%Y-%m-%d');
	my $current_date = localtime;
	my $days = ceil(($event_date - $current_date) / ONE_DAY);
	return $days >= 0 ? $days : -1;
}

1;
