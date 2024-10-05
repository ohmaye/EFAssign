
-- Create a UUID
SELECT lower(hex(randomblob(16)))


-- MATCH (t:Teacher) RETURN t.id, t.name, t.nameJP, t.email, t.active
DROP TABLE IF EXISTS teachers;
CREATE TABLE teachers (
  teacher_id TEXT NOT NULL UNIQUE PRIMARY KEY,
  name TEXT,
  nameJP TEXT,
  email TEXT,
  note TEXT,
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

-- MATCH (r:Room) return r.id, r.name, r.type, r.capacity, r.active
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

-- MATCH (s:Student)-[a:ATTENDS]-(e:Event) RETURN s.id, e.id
DROP TABLE IF EXISTS assignments;
CREATE TABLE assignments (
  student_id TEXT,
  class_id TEXT
);


-- Survey data
DROP TABLE IF EXISTS survey;
CREATE TABLE survey (
  student_id TEXT NOT NULL UNIQUE PRIMARY KEY,
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
)


-- Students
DROP TABLE IF EXISTS students;
CREATE TABLE students (
  student_id TEXT NOT NULL UNIQUE PRIMARY KEY,
  email	TEXT,
  firstName TEXT,
  lastName TEXT,
  level TEXT,
  program TEXT,
  timestamp TEXT,
  active int
);
INSERT INTO students (student_id, email, firstName, lastName, program, level, timestamp, active)
SELECT student_id, email, firstName, lastName, 
  CASE WHEN instr(program, "Intensive") THEN "Intensive" ELSE "General" END, 
  level, timestamp, 1 FROM survey LIMIT -1 OFFSET 1;
	

-- Demand view (denormalized students + student_choices)
-- Drop the demand view if it exists
DROP VIEW IF EXISTS demand_view;

-- Create the demand view
CREATE VIEW demand_view AS
SELECT
  s.student_id,
  s.email,
  s.firstName,
  s.lastName,
  s.level,
  s.program,
  -- Pivoting choices for Monday
  MAX(CASE WHEN sc.weekday = 'Mon01' THEN sc.course_code END) AS Mon01,
  MAX(CASE WHEN sc.weekday = 'Mon02' THEN sc.course_code END) AS Mon02,
  MAX(CASE WHEN sc.weekday = 'Mon03' THEN sc.course_code END) AS Mon03,
  -- Pivoting choices for Wednesday
  MAX(CASE WHEN sc.weekday = 'Wed01' THEN sc.course_code END) AS Wed01,
  MAX(CASE WHEN sc.weekday = 'Wed02' THEN sc.course_code END) AS Wed02,
  MAX(CASE WHEN sc.weekday = 'Wed03' THEN sc.course_code END) AS Wed03,
  MAX(CASE WHEN sc.weekday = 'Wed04' THEN sc.course_code END) AS Wed04,
  MAX(CASE WHEN sc.weekday = 'Wed05' THEN sc.course_code END) AS Wed05,
  s.active
FROM
  students s
LEFT JOIN
  student_choices sc ON s.student_id = sc.student_id
GROUP BY
  s.student_id;

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


-- Main query for pivot table By Course with totals (check below for Intensive/General)
SELECT course,
       SUM(CASE WHEN time_slot = 'Mon01' THEN 1 ELSE 0 END) AS Mon01,
       SUM(CASE WHEN time_slot = 'Mon02' THEN 1 ELSE 0 END) AS Mon02,
       SUM(CASE WHEN time_slot = 'Mon03' THEN 1 ELSE 0 END) AS Mon03,
       SUM(CASE WHEN time_slot = 'Wed01' THEN 1 ELSE 0 END) AS Wed01,
       SUM(CASE WHEN time_slot = 'Wed02' THEN 1 ELSE 0 END) AS Wed02,
       SUM(CASE WHEN time_slot = 'Wed03' THEN 1 ELSE 0 END) AS Wed03,
       SUM(CASE WHEN time_slot = 'Wed04' THEN 1 ELSE 0 END) AS Wed04,
       SUM(CASE WHEN time_slot = 'Wed05' THEN 1 ELSE 0 END) AS Wed05,
       -- Total for each row (course)
       SUM(CASE WHEN time_slot IN ('Mon01', 'Mon02', 'Mon03', 'Wed01', 'Wed02', 'Wed03', 'Wed04', 'Wed05') THEN 1 ELSE 0 END) AS Total
FROM (
    SELECT Mon01 AS course, 'Mon01' AS time_slot, program FROM demand WHERE Mon01 IS NOT NULL AND Mon01 != ''
    UNION ALL
    SELECT Mon02 AS course, 'Mon02' AS time_slot, program FROM demand WHERE Mon02 IS NOT NULL AND Mon02 != ''
    UNION ALL
    SELECT Mon03 AS course, 'Mon03' AS time_slot, program FROM demand WHERE Mon03 IS NOT NULL AND Mon03 != ''
    UNION ALL
    SELECT Wed01 AS course, 'Wed01' AS time_slot, program FROM demand WHERE Wed01 IS NOT NULL AND Wed01 != ''
    UNION ALL
    SELECT Wed02 AS course, 'Wed02' AS time_slot, program FROM demand WHERE Wed02 IS NOT NULL AND Wed02 != ''
    UNION ALL
    SELECT Wed03 AS course, 'Wed03' AS time_slot, program FROM demand WHERE Wed03 IS NOT NULL AND Wed03 != ''
    UNION ALL
    SELECT Wed04 AS course, 'Wed04' AS time_slot, program FROM demand WHERE Wed04 IS NOT NULL AND Wed04 != ''
    UNION ALL
    SELECT Wed05 AS course, 'Wed05' AS time_slot, program FROM demand WHERE Wed05 IS NOT NULL AND Wed05 != ''
)
WHERE program IN ('Intensive')
GROUP BY course

-- Add the row for column totals using a UNION ALL
UNION ALL

SELECT 'Total' AS course,
       SUM(CASE WHEN time_slot = 'Mon01' THEN 1 ELSE 0 END) AS Mon01,
       SUM(CASE WHEN time_slot = 'Mon02' THEN 1 ELSE 0 END) AS Mon02,
       SUM(CASE WHEN time_slot = 'Mon03' THEN 1 ELSE 0 END) AS Mon03,
       SUM(CASE WHEN time_slot = 'Wed01' THEN 1 ELSE 0 END) AS Wed01,
       SUM(CASE WHEN time_slot = 'Wed02' THEN 1 ELSE 0 END) AS Wed02,
       SUM(CASE WHEN time_slot = 'Wed03' THEN 1 ELSE 0 END) AS Wed03,
       SUM(CASE WHEN time_slot = 'Wed04' THEN 1 ELSE 0 END) AS Wed04,
       SUM(CASE WHEN time_slot = 'Wed05' THEN 1 ELSE 0 END) AS Wed05,
       -- Total across all columns (time slots)
       SUM(CASE WHEN time_slot IN ('Mon01', 'Mon02', 'Mon03', 'Wed01', 'Wed02', 'Wed03', 'Wed04', 'Wed05') THEN 1 ELSE 0 END) AS Total
FROM (
    SELECT Mon01 AS course, 'Mon01' AS time_slot, program FROM demand WHERE Mon01 IS NOT NULL AND Mon01 != ''
    UNION ALL
    SELECT Mon02 AS course, 'Mon02' AS time_slot, program FROM demand WHERE Mon02 IS NOT NULL AND Mon02 != ''
    UNION ALL
    SELECT Mon03 AS course, 'Mon03' AS time_slot, program FROM demand WHERE Mon03 IS NOT NULL AND Mon03 != ''
    UNION ALL
    SELECT Wed01 AS course, 'Wed01' AS time_slot, program FROM demand WHERE Wed01 IS NOT NULL AND Wed01 != ''
    UNION ALL
    SELECT Wed02 AS course, 'Wed02' AS time_slot, program FROM demand WHERE Wed02 IS NOT NULL AND Wed02 != ''
    UNION ALL
    SELECT Wed03 AS course, 'Wed03' AS time_slot, program FROM demand WHERE Wed03 IS NOT NULL AND Wed03 != ''
    UNION ALL
    SELECT Wed04 AS course, 'Wed04' AS time_slot, program FROM demand WHERE Wed04 IS NOT NULL AND Wed04 != ''
    UNION ALL
    SELECT Wed05 AS course, 'Wed05' AS time_slot, program FROM demand WHERE Wed05 IS NOT NULL AND Wed05 != ''
)


-- Classes
SELECT courses.code as 'course', classes.title as 'class', rooms.name as 'where', timeslots.weekday || ' ' || timeslots.start_time as 'when', teachers.name as 'who' FROM classes
LEFT JOIN courses USING (course_id)
LEFT JOIN rooms USING (room_id)
LEFT JOIN timeslots USING (timeslot_id)
LEFT JOIN teachers USING (teacher_id)



-- CREATE Views

-- Classes_view
DROP VIEW IF EXISTS "main"."classes_view";
CREATE VIEW classes_view as 
SELECT class_id, courses.code as 'course', 
classes.title as 'class', 
rooms.name as 'where', 
weekdays.sort_key as weekday_sort_key, 
timeslots.weekday as weekday,
 timeslots.weekday || ' ' || timeslots.start_time as 'when', 
 teachers.name as 'who'
 FROM classes
	LEFT JOIN courses USING (course_id)
	LEFT JOIN rooms USING (room_id)
	LEFT JOIN timeslots USING (timeslot_id)
	LEFT JOIN teachers USING (teacher_id)
	LEFT JOIN weekdays ON weekdays.weekday = timeslots.weekday
	ORDER BY course, classes.title, weekday_sort_key;

-- Demand_view
DROP VIEW IF EXISTS "main"."demand_view";
CREATE VIEW demand_view AS
SELECT
  s.student_id,
  s.email,
  s.firstName,
  s.lastName,
  s.level,
  s.program,
  -- Pivoting choices for Monday
  MAX(CASE WHEN sc.choice = 'IM1' THEN sc.course_code END) AS IM1,
  MAX(CASE WHEN sc.choice = 'IM2' THEN sc.course_code END) AS IM2,
  MAX(CASE WHEN sc.choice = 'IM3' THEN sc.course_code END) AS IM3,
  MAX(CASE WHEN sc.choice = 'Ia1' THEN sc.course_code END) AS Ia1,
  MAX(CASE WHEN sc.choice = 'Ia2' THEN sc.course_code END) AS Ia2,
  MAX(CASE WHEN sc.choice = 'Ia3' THEN sc.course_code END) AS Ia3,
  MAX(CASE WHEN sc.choice = 'Ia4' THEN sc.course_code END) AS Ia4,
  MAX(CASE WHEN sc.choice = 'Ia4' THEN sc.course_code END) AS Ia5,
  MAX(CASE WHEN sc.choice = 'Ga1' THEN sc.course_code END) AS Ga1,
  MAX(CASE WHEN sc.choice = 'Ga2' THEN sc.course_code END) AS Ga2,
  MAX(CASE WHEN sc.choice = 'Ga3' THEN sc.course_code END) AS Ga3,
  MAX(CASE WHEN sc.choice = 'Ga4' THEN sc.course_code END) AS Ga4,
  MAX(CASE WHEN sc.choice = 'Ga5' THEN sc.course_code END) AS Ga5,
  s.active
FROM
  students s
LEFT JOIN
  student_choices sc ON s.student_id = sc.student_id
GROUP BY
  s.student_id;


-- Filtered views

-- Filtered demand view
DROP VIEW IF EXISTS "main"."filtered_demand_view";
CREATE VIEW filtered_demand_view AS SELECT * FROM demand_view WHERE program IN (SELECT program FROM programs WHERE show = 1);

-- Filtered student_chocies view
DROP VIEW IF EXISTS "main"."filtered_student_choices_view";
CREATE VIEW filtered_student_choices_view AS  
SELECT * FROM student_choices sc JOIN students s USING (student_id)
WHERE s.program IN (SELECT program FROM programs WHERE show = 1)
AND sc.choice IN (SELECT choice FROM choices WHERE show = 1);

-- Filtered students view
DROP VIEW IF EXISTS "main"."filtered_students_view";
CREATE VIEW filtered_students_view AS SELECT * FROM students WHERE program IN (SELECT program FROM programs WHERE show = 1);