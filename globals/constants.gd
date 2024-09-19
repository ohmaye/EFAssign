extends Node

# Constants (Available everywhere in the project -- autoloaded)

# Students
const STUDENT_COLUMN_NAMES = ["firstName", "lastName", "email", "level","program","active"]
const STUDENT_KEY = "student_id"


# Teachers
const TEACHER_COLUMN_NAMES = ["name", "nameJP", "email", "active"]
const TEACHER_COLUMN_RATIOS = [1,1,1,0.2]
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
	"timestamp",
	"email",
	"firstName",
	"lastName",
	"level",
	"program",
	"IMon01",
	"IMon02",
	"IMon03",
	"IWed01",
	"IWed02",
	"IWed03",
	"IWed04",
	"IWed05",
	"GWed01",
	"GWed04",
	"GWed02",
	"GWed03",
	"GWed05" 
]
const SURVEY_KEY = "timestamp"

# Survey
const DEMAND_COLUMN_NAMES = [  
	"firstName",
	"lastName",
	"email",
	"level",
	"program",
	"Mon01",
	"Mon02",
	"Mon03",
	"Wed01",
	"Wed02",
	"Wed03",
	"Wed04",
	"Wed05"
]
const DEMAND_KEY = "student_id"

# By Course
const BY_COURSE_COLUMN_NAMES = [  
    "course",
	"Mon01",
	"Mon02",
	"Mon03",
	"Wed01",
	"Wed02",
	"Wed03",
	"Wed04",
	"Wed05",
    "Total"
]
const BY_COURSE_KEY = "course"

# By Level
const BY_LEVEL_COLUMN_NAMES = [  
    "course",
    "level",
	"Mon01",
	"Mon02",
	"Mon03",
	"Wed01",
	"Wed02",
	"Wed03",
	"Wed04",
	"Wed05",
    "Total"
]
const BY_LEVEL_KEY = "level"

# Classes
const SUPPLY_BY_WEEKDAY_COLUMN_NAMES = ["course", "class", "when", "where", "who"]
const SUPPLY_BY_WEEKDAY_KEY = "class_id"