extends Control

var intensive_checkbox : CheckBox
var general_checkbox : CheckBox
var m1_checkbox : CheckBox
var m2_checkbox : CheckBox
var m3_checkbox : CheckBox
var w1_checkbox : CheckBox
var w2_checkbox : CheckBox
var w3_checkbox : CheckBox
var w4_checkbox : CheckBox
var w5_checkbox : CheckBox

var show_intensive : bool
var show_general : bool
var show_m1 : bool
var show_m2 : bool
var show_m3 : bool
var show_w1 : bool
var show_w2 : bool
var show_w3 : bool
var show_w4 : bool
var show_w5 : bool

var default_path : String = "res://data/EFAssign.db"
var file_path : String :
	set(path):
		file_path = path
		DisplayServer.window_set_title(path.get_file())