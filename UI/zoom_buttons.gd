extends MarginContainer


func _on_zoom_in_btn_pressed() -> void:
	Signals.emit_zoom_in()

func _on_zoom_out_btn_pressed() -> void:
	Signals.emit_zoom_out()

