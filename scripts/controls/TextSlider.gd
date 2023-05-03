class_name TextSlider
extends Label


signal on_drag(newValue: float, delta: float)
signal on_drag_start()
signal on_drag_end(valueChanged: bool)


@export_multiline var template: String = "< %.1f >"

@export var value: float = 1.0
@export var minValue: float = 1.0
@export var maxValue: float = 100.0

@export var pixelsPerPoint: float = 10


var _dragged := false
var _preDragValue := value

func _input(event):
	if _dragged && event is InputEventMouseMotion:
		var delta = event.relative.x / pixelsPerPoint
		value = clamp(value + delta, minValue, maxValue)

		on_drag.emit(value, delta)
		text = template % value

	elif event.is_action_pressed("ui_mouse_left"):
		var mousePos = get_local_mouse_position()
		if  mousePos.x < 0 or mousePos.y < 0 or\
			mousePos.x > size.x or mousePos.y > size.y:
			return

		_preDragValue = value
		_dragged = true
		on_drag_start.emit()

	elif event.is_action_released("ui_mouse_left"):
		_dragged = false
		on_drag_end.emit(value != _preDragValue)
