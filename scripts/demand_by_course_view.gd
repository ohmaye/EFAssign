# File: res://scripts/DemandView.gd
extends Assign

class_name DemandByCourseView  # Registers the class globally as 'DemandView'

# Survey
const SHOW_COLUMNS = [  
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
static var KEY = "course"
static var EDITABLE : bool = false
# static var TABLE = "demand_by_course_view"    # This is a view, not a table

# Class Properties
var course: String
var IM1: int
var IM2: int
var IM3: int
var Ia1: int
var Ia2: int
var Ia3: int
var Ia4: int
var Ia5: int
var Ga1: int
var Ga2: int
var Ga3: int
var Ga4: int
var Ga5: int
var Total: int

# Custom Constructor
func _init(data: Dictionary = {}):
	# print("DemandByCourseView: ", data)
	course = data.get("course") if data.get("course") else ""
	IM1 = data.get("IM1") if data.get("IM1") else 0
	IM2 = data.get("IM2") if data.get("IM2") else 0
	IM3 = data.get("IM3") if data.get("IM3") else 0
	Ia1 = data.get("Ia1") if data.get("Ia1") else 0
	Ia2 = data.get("Ia2") if data.get("Ia2") else 0
	Ia3 = data.get("Ia3") if data.get("Ia3") else 0
	Ia4 = data.get("Ia4") if data.get("Ia4") else 0
	Ia5 = data.get("Ia5") if data.get("Ia5") else 0
	Ga1 = data.get("Ga1") if data.get("Ga1") else 0
	Ga2 = data.get("Ga2") if data.get("Ga2") else 0
	Ga3 = data.get("Ga3") if data.get("Ga3") else 0
	Ga4 = data.get("Ga4") if data.get("Ga4") else 0
	Ga5 = data.get("Ga5") if data.get("Ga5") else 0
	Total = data.get("Total") if data.get("Total") else 0
