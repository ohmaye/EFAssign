extends Node

@export var color_demand : Color
@export var color_assign: Color
@export var color_supply: Color

# Constants (Available everywhere in the project -- autoloaded)

# Students
const STUDENT_SHOW_COLUMNS = ["firstName", "lastName", "email", "program", "level", "active", "timestamp"]
const STUDENT_KEY = "student_id"


# Teachers
const TEACHER_SHOW_COLUMNS = ["name", "nameJP", "email", "note", "active"]
const TEACHER_SHOW_COLUMN_RATIOS = [1,1,1,2,0.2]
const TEACHER_KEY = "teacher_id"

# Classes
const CLASSES_SHOW_COLUMNS = ["course", "class", "for_program", "when", "where", "who"]
const CLASSES_KEY = "class_id"

# Courses
const COURSE_SHOW_COLUMNS = ["code", "title", "active"]
const COURSE_KEY = "course_id"

# Rooms
const ROOM_COLUMN_NAMES = ["name", "type", "capacity", "active"]
const ROOM_KEY = "room_id"

# Time Slots
const TIMESLOT_SHOW_COLUMNS = ["weekday", "start_time", "end_time", "active"]
const TIMESLOT_KEY = "timeslot_id"

# Survey
const SURVEY_SHOW_COLUMNS = [  
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
const DEMAND_SHOW_COLUMNS = [  
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
const BY_COURSE_SHOW_COLUMNS = [  
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
const BY_LEVEL_SHOW_COLUMNS = [  
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
const SUPPLY_BY_WEEKDAY_SHOW_COLUMNS = ["course", "class", "when", "where", "who"]
const SUPPLY_BY_WEEKDAY_KEY = "class_id"