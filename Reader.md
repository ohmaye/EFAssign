CREATE TABLE students (
  student_id TEXT NOT NULL UNIQUE PRIMARY KEY,
  email	TEXT,
  firstName TEXT,
  lastName TEXT,
  level TEXT,
  program TEXT,
  timestamp TEXT,
  active int
)

CREATE TABLE "survey" (
	"student_id"	TEXT NOT NULL UNIQUE,
	"timestamp"	TEXT,
	"email"	TEXT,
	"firstName"	TEXT,
	"lastName"	TEXT,
	"level"	TEXT,
	"program"	TEXT,
	"IM1"	TEXT,
	"IM2"	TEXT,
	"IM3"	TEXT,
	"Ia1"	TEXT,
	"Ia2"	TEXT,
	"Ia3"	TEXT,
	"Ia4"	TEXT,
	"Ia5"	TEXT,
	"Ga1"	TEXT,
	"Ga2"	TEXT,
	"Ga3"	TEXT,
	"Ga4"	TEXT,
	"Ga5"	TEXT,
	PRIMARY KEY("student_id")
)

CREATE TABLE teacherpreferences (
  teacher_id TEXT,
  course_id TEXT,
  rating INT
)

CREATE TABLE teachers (
  teacher_id TEXT NOT NULL UNIQUE PRIMARY KEY,
  name TEXT,
  nameJP TEXT,
  email TEXT,
  note TEXT,
  active INT
)

CREATE TABLE timeslots (
  timeslot_id TEXT NOT NULL UNIQUE PRIMARY KEY,
  weekday TEXT,
  start_time TEXT,
  end_time TEXT,
  active INT
)

CREATE TABLE weekdays (
  sort_key INT,
  weekday TEXT
)