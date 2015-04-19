package Bot::DB::Schema;
use DBIx::Skinny::Schema;

install_table Events => schema {
	pk 'id';
	columns qw/user_name user_id event_title event_date description registration_date/;
};

1;
