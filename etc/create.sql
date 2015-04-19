CREATE TABLE Events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
	user_name TEXT NOT NULL,
	user_id TEXT NOT NULL,
	event_title TEXT NOT NULL,
	event_date TEXT NOT NULL,
	description TEXT NOT NULL,
	registration_date TEXT NOT NULL
);
