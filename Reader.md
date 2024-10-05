CREATE VIEW filtered_student_choices_view AS  SELECT * FROM student_choices WHERE program IN (SELECT program FROM programs WHERE show = 1)
AND weekday IN (SELECT choice FROM choices WHERE show = 1)

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
  s.student_id
  
  
  CREATE VIEW filtered_demand_view AS SELECT * FROM demand_view WHERE program IN (SELECT program FROM programs WHERE show = 1)
  
  CREATE VIEW filtered_demand_view AS SELECT * FROM demand_view WHERE program IN (SELECT program FROM programs WHERE show = 1)