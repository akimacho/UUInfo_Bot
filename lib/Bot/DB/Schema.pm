package Bot::DB::Schema;
use DBIx::Skinny::Schema;

install_table Deadline => schema {
	pk 'id';
	columns qw/id screen_name user_id 
						 event_title event_sense event_date event_description 
						 good bad 
						 registration_date/;
};

1;
