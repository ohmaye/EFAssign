# File: res://scripts/Survey.gd
extends Assign

class_name Survey  # Registers the class globally as 'Survey'

# Survey
static var SHOW_COLUMNS = [  
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
static var KEY = "student_id"
static var TABLE = "survey"

# Class Properties
var student_id: String
var timestamp: String
var email: String
var firstName: String
var lastName: String
var level: String
var program: String
var IM1: String
var IM2: String
var IM3: String
var Ia1: String
var Ia2: String
var Ia3: String
var Ia4: String
var Ia5: String
var Ga1: String
var Ga2: String
var Ga3: String
var Ga4: String
var Ga5: String

# Custom Constructor
func _init(data: Dictionary = {}):
    student_id = data.get("student_id") if data.get("student_id") else ""
    timestamp = data.get("timestamp") if data.get("timestamp") else ""
    email = data.get("email") if data.get("email") else ""
    firstName = data.get("firstName") if data.get("firstName") else ""
    lastName = data.get("lastName") if data.get("lastName") else ""
    level = data.get("level") if data.get("level") else ""
    program = data.get("program") if data.get("program") else ""
    IM1 = data.get("IM1") if data.get("IM1") else ""
    IM2 = data.get("IM2") if data.get("IM2") else "" 
    IM3 = data.get("IM3") if data.get("IM3") else ""
    Ia1 = data.get("Ia1") if data.get("Ia1") else ""
    Ia2 = data.get("Ia2") if data.get("Ia2") else ""
    Ia3 = data.get("Ia3") if data.get("Ia3") else ""
    Ia4 = data.get("Ia4") if data.get("Ia4") else ""
    Ia5 = data.get("Ia5") if data.get("Ia5") else ""
    Ga1 = data.get("Ga1") if data.get("Ga1") else ""
    Ga2 = data.get("Ga2") if data.get("Ga2") else ""
    Ga3 = data.get("Ga3") if data.get("Ga3") else ""
    Ga4 = data.get("Ga4") if data.get("Ga4") else ""
    Ga5 = data.get("Ga5") if data.get("Ga5") else ""