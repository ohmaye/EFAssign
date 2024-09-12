extends Node

# Constants (Available everywhere in the project -- autoloaded)

# Students
const STUDENT_COLUMN_NAMES = ["firstName", "lastName", "email", "level","program","enddate","active"]
const STUDENT_KEY = "student_id"


# Teachers
const TEACHER_COLUMN_NAMES = ["name", "nameJP", "email", "active"]
const TEACHER_COLUMN_RATIOS = [1,1,1,0.2]
const TEACHER_KEY = "teacher_id"

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
