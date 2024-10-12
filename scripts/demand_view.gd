# File: res://scripts/DemandView.gd
extends Object

class_name DemandView  # Registers the class globally as 'DemandView'

# Survey
static var SHOW_COLUMNS = [  
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
static var KEY = "student_id"

# Class Properties
var student_id: String
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
var active: int

# Custom Constructor
func _init(data: Dictionary = {}):
    student_id = data.get("student_id", "")
    email = data.get("email", "")
    firstName = data.get("firstName", "")
    lastName = data.get("lastName", "")
    level = data.get("level", "")
    program = data.get("program", "")
    IM1 = data.get("IM1", "")
    IM2 = data.get("IM2", "")
    IM3 = data.get("IM3", "")
    Ia1 = data.get("Ia1", "")
    Ia2 = data.get("Ia2", "")
    Ia3 = data.get("Ia3", "")
    Ia4 = data.get("Ia4", "")
    Ia5 = data.get("Ia5", "")
    Ga1 = data.get("Ga1", "")
    Ga2 = data.get("Ga2", "")
    Ga3 = data.get("Ga3", "")
    Ga4 = data.get("Ga4", "")
    Ga5 = data.get("Ga5", "")
    active = data.get("active", 0)