
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
  name TEXT NOT NULL,
  nameJP TEXT,
  email TEXT,
  active INT
);

-- MATCH (c:Course) RETURN c.id, c.code, c.name, c.active
DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
  course_id TEXT NOT NULL UNIQUE PRIMARY KEY,
  code TEXT NOT NULL,
  title TEXT,
  active INT
);

-- MATCH (r:Room) return r.id, r.name r.type, r.capacity, r.active
DROP TABLE IF EXISTS rooms;
CREATE TABLE rooms (
  room_id TEXT NOT NULL UNIQUE PRIMARY KEY,
  name TEXT NOT NULL,
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
  student_id INTEGER NOT NULL,
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