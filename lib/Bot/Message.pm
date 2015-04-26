package Bot::Message;
use strict;
use warnings;
use utf8;
use Encode qw/encode_utf8/;
use Time::Piece;

sub new {
	my $class = shift;
	return bless {}, $class;
}

sub getTweetMassage {
	my ($self, %args) = @_;
	my $msg = $args{title} . "は" . $args{date} . "です\n";
	$msg .= 'あと' . $args{leftdays} . "日です\n" if ($args{sense} eq 'countdown');
	$msg .= 'http://utsu-info.com/entry/' . $args{id};
	return encode_utf8($msg);
}

sub goodmorning {
	my ($self, %args) = @_;
	my $t = localtime;
	my $msg = 'おはようございます！';
	$msg .= $t->mon . '月' . $t->mday . '日' . '(' . $t->wdayname(qw/日 月 火 水 木 金 土/) . ")をお知らせします\n";
	$msg .= "今日の天気は" . $args{today}->{whether} . "です。また";
	$msg .= "予想最高気温は" . $args{today}->{max} . "度 " if ($args{today}->{max});
	$msg .= "予想最低気温は" . $args{today}->{min} . "度 " if ($args{today}->{min});
	$msg .= "です http://weather.livedoor.com/area/forecast/0920100";
	return encode_utf8($msg);
}

sub goodevening {
	my ($self, %args) = @_;
	my $msg = "今後の予定は以上です。";
	$msg .= "なお、明日の天気は" . $args{tomorrow}->{whether} . "、";
	$msg .= "予想最高気温は" . $args{tomorrow}->{max} . "度 " if ($args{tomorrow}->{max});
	$msg .= "予想最低気温は" . $args{tomorrow}->{min} . "度 " if ($args{tomorrow}->{min});
	$msg .= "です http://weather.livedoor.com/area/forecast/0920100\n";
	$msg .= "お疲れ様でしたー";
	return encode_utf8($msg);
}

1;
