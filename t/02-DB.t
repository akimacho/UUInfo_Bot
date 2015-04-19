use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib/";
use Test::More;

BEGIN {
	use_ok('Bot::DB');
}

my $db = Bot::DB->new({
	dsn => "dbi:SQLite:dbname=test.db",
});
isa_ok($db, 'Bot::DB');

my $itr = $db->search('Events', {});
is($itr->count, 2, 'the number of rows');
is($itr->next->user_name, 'hoge', 'first row');

done_testing;
