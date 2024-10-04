extends Node

# Constants (Available everywhere in the project -- autoloaded)

# Students
const STUDENT_COLUMN_NAMES = ["firstName", "lastName", "email", "program", "level", "active", "timestamp"]
const STUDENT_KEY = "student_id"


# Teachers
const TEACHER_COLUMN_NAMES = ["name", "nameJP", "email", "note", "active"]
const TEACHER_COLUMN_RATIOS = [1,1,1,2,0.2]
const TEACHER_KEY = "teacher_id"

# Classes
const CLASSES_COLUMN_NAMES = ["course", "class", "when", "where", "who"]
const CLASSES_KEY = "class_id"

# Courses
const COURSE_COLUMN_NAMES = ["code", "title", "active"]
const COURSE_KEY = "course_id"

# Rooms
const ROOM_COLUMN_NAMES = ["name", "type", "capacity", "active"]
const ROOM_KEY = "room_id"

# Time Slots
const TIMESLOT_COLUMN_NAMES = ["weekday", "start_time", "end_time", "active"]
const TIMESLOT_KEY = "timeslot_id"

# Survey
const SURVEY_COLUMN_NAMES = [  
	"student_id",
	"timestamp",
	"email",
	"firstName",
	"lastName",
	"level",
	"program",
	"IM1",
	"IM2",
	"IM3",
	"Ia1",
	"Ia2",
	"Ia3",
	"Ia4",
	"Ia5",
	"Ga1",
	"Ga2",
	"Ga3",
	"Ga4",
	"Ga5" 
]
const SURVEY_KEY = "student_id"

# Survey
const DEMAND_COLUMN_NAMES = [  
	"firstName",
	"lastName",
	"email",
	"level",
	"program",
	"IM1",
	"IM2",
	"IM3",
	"Ia1",
	"Ia2",
	"Ia3",
	"Ia4",
	"Ia5",
	"Ga1",
	"Ga2",
	"Ga3",
	"Ga4",
	"Ga5"
]
const DEMAND_KEY = "student_id"

# By Course
const BY_COURSE_COLUMN_NAMES = [  
    "course",
	"IM1",
	"IM2",
	"IM3",
	"Ia1",
	"Ia2",
	"Ia3",
	"Ia4",
	"Ia5",
	"Ga1",
	"Ga2",
	"Ga3",
	"Ga4",
	"Ga5",
    "Total"
]
const BY_COURSE_KEY = "course"

# By Level
const BY_LEVEL_COLUMN_NAMES = [  
    "course",
    "level",
	"IM1",
	"IM2",
	"IM3",
	"Ia1",
	"Ia2",
	"Ia3",
	"Ia4",
	"Ia5",
	"Ga1",
	"Ga2",
	"Ga3",
	"Ga4",
	"Ga5",
    "Total"
]
const BY_LEVEL_KEY = "level"

# Classes
const SUPPLY_BY_WEEKDAY_COLUMN_NAMES = ["course", "class", "when", "where", "who"]
const SUPPLY_BY_WEEKDAY_KEY = "class_id"