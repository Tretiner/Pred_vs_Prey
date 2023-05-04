extends Label


func _input(event):
	if event.is_action_pressed("ui_mouse_left"):
		DisplayServer.clipboard_set(text)
