
-- MATCH (s:Student) RETURN s.id, s.firstName, s.lastName, s.email, s.level, s.program, s.enddate, s.active
DROP TABLE IF EXISTS students;
CREATE TABLE students (
  student_id TEXT NOT NULL UNIQUE PRIMARY KEY,
  firstName TEXT,
  lastName TEXT,
  email TEXT,
  level TEXT,
  program TEXT,
  enddate TEXT,
  active INT
);

-- MATCH (t:Teacher) RETURN t.id, t.name, t.nameJP, t.email, t.active
DROP TABLE IF EXISTS teachers;
CREATE TABLE teachers (
  teacher_id TEXT NOT NULL UNIQUE PRIMARY KEY,
  name TEXT,
  nameJP TEXT,
  email TEXT,
  active INT
);

-- MATCH (c:Course) RETURN c.id, c.code, c.name, c.active
DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
  course_id TEXT NOT NULL UNIQUE PRIMARY KEY,
  code TEXT,
  title TEXT,
  active INT
);

-- MATCH (r:Room) return r.id, r.name r.type, r.capacity, r.active
DROP TABLE IF EXISTS rooms;
CREATE TABLE rooms (
  room_id TEXT NOT NULL UNIQUE PRIMARY KEY,
  name TEXT,
  type TEXT,
  capacity INT,
  active INT
);

-- MATCH (t:TimeSlot) RETURN t.id, t.weekday, t.startTime, t.endTime, t.active
DROP TABLE IF EXISTS timeslots;
CREATE TABLE timeslots (
  timeslot_id TEXT NOT NULL UNIQUE PRIMARY KEY,
  weekday TEXT,
  start_time TEXT,
  end_time TEXT,
  active INT
);

-- MATCH (t:Teacher)-[r:TEACHES]->(c:Course) RETURN t.id, c.id, r.strength
DROP TABLE IF EXISTS teacherpreferences;
CREATE TABLE teacherpreferences (
  teacher_id TEXT,
  course_id TEXT,
  rating INT
);

-- MATCH (s:Student)-[r:WANTS]->(c:Course) RETURN s.id, r.choice, r.ranking, c.id  
DROP TABLE IF EXISTS studentpreferences;
CREATE TABLE studentpreferences (
  student_id TEXT NOT NULL,
  weekday TEXT,
  ranking INTEGER,
  course_id TEXT
);

-- MATCH (e:Event) RETURN e.id, e.what, e.courseID, e.roomID, e.timeSlotID, e.teacherID
DROP TABLE IF EXISTS classes;
CREATE TABLE classes (
  class_id TEXT NOT NULL UNIQUE PRIMARY KEY,
  title TEXT,
  course_id TEXT,
  room_id TEXT,
  timeslot_id TEXT,
  teacher_id TEXT
);

-- 
DROP TABLE IF EXISTS assignments;
CREATE TABLE assignments (
  student_id TEXT,
  class_id TEXT
);


-- Survey data
DROP TABLE IF EXISTS survey;
CREATE TABLE survey (
  timestamp TEXT,
  email	TEXT,
  firstName TEXT,
  lastName TEXT,
  level TEXT,
  program TEXT,
  IMon01 TEXT,
  IMon02 TEXT,
  IMon03 TEXT,
  IWed01 TEXT,
  IWed02 TEXT,
  IWed03 TEXT,
  IWed04 TEXT,
  IWed05 TEXT,
  GWed01 TEXT,
  GWed04 TEXT,
  GWed02 TEXT,
  GWed03 TEXT,
  GWed05 TEXT 
);

-- Demand data
DROP TABLE IF EXISTS demand;
CREATE TABLE demand (
  email	TEXT,
  firstName TEXT,
  lastName TEXT,
  level TEXT,
  program TEXT,
  Mon01 TEXT,
  Mon02 TEXT,
  Mon03 TEXT,
  Wed01 TEXT,
  Wed02 TEXT,
  Wed03 TEXT,
  Wed04 TEXT,
  Wed05 TEXT
);
INSERT INTO demand (email, firstName,lastName, level, program, Mon01, Mon02, Mon03, Wed01, Wed02, Wed03, Wed04, Wed05)
SELECT email, firstName, lastName, level, 
CASE WHEN instr(program, "Intensive") THEN "Intensive" ELSE "General" END, 
CASE WHEN instr(program, "Intensive") THEN IMon01 ELSE "" END, 
CASE WHEN instr(program, "Intensive") THEN IMon02 ELSE "" END, 
CASE WHEN instr(program, "Intensive") THEN IMon03 ELSE "" END, 
CASE WHEN instr(program, "Intensive") THEN IWed01 ELSE GWed01 END, 
CASE WHEN instr(program, "Intensive") THEN IWed02 ELSE GWed02 END, 
CASE WHEN instr(program, "Intensive") THEN IWed03 ELSE GWed03 END, 
CASE WHEN instr(program, "Intensive") THEN IWed04 ELSE GWed04 END, 
CASE WHEN instr(program, "Intensive") THEN IWed05 ELSE GWed05 END
FROM survey;
UPDATE demand SET Mon01 = substr(Mon01, instr(Mon01, '_') + 1);
UPDATE demand SET Mon02 = substr(Mon02, instr(Mon02, '_') + 1);
UPDATE demand SET Mon03 = substr(Mon03, instr(Mon03, '_') + 1);
UPDATE demand SET Wed01 = substr(Wed01, instr(Wed01, '_') + 1);
UPDATE demand SET Wed02 = substr(Wed02, instr(Wed02, '_') + 1);
UPDATE demand SET Wed03 = substr(Wed03, instr(Wed03, '_') + 1);
UPDATE demand SET Wed04 = substr(Wed04, instr(Wed04, '_') + 1);
UPDATE demand SET Wed05 = substr(Wed05, instr(Wed05, '_') + 1);

-- Weekdays
DROP TABLE IF EXISTS weekdays;
CREATE TABLE weekdays (
  sort_key INT,
  weekday TEXT
);
INSERT INTO weekdays VALUES (1, "Mon");
INSERT INTO weekdays VALUES (2, "Tue");
INSERT INTO weekdays VALUES (3, "Wed");
INSERT INTO weekdays VALUES (4, "Thu");
INSERT INTO weekdays VALUES (5, "Fri");
INSERT INTO weekdays VALUES (6, "Sat");
INSERT INTO weekdays VALUES (7, "Sun");