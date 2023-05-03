extends Node2D


var graphs := {
	"bunny": [0, Color.WHITE_SMOKE],
	"molf": [0, Color.CORNFLOWER_BLUE],
	"folf": [0, Color.DARK_ORCHID]
}
var data: Dictionary
# 9 : {
#	"bunny": 0,
#	"molf": 1,
#	"folf": 2
#}
var maxY: int


func _ready():
	StatsCollector.on_tick_end.connect(queue_redraw)


func set_graphs(_graphs: Dictionary) -> void:
	graphs = _graphs


func set_data(_data: Dictionary, _maxY: int) -> void:
	data = _data
	maxY = _maxY


func _draw():
	get_window().popup_centered()
	set_data(StatsCollector.statsDict, get_window().size.y)

	# In pixels on screen
	var pixel_xmin = 0.0
	var pixel_xmax = get_window().size.x
	var pixel_ymin = get_window().size.y - 4
	var pixel_ymax = 1.0

	# Graph area
	var xmin := 0
	var xmax := data.size()
	var ymin = 0.0
	var ymax = maxY

	for graphName in graphs.keys():
		graphs[graphName][0] = data[0][graphName]

	# For each pixel along the X axis
	var lastX = 0
	for pixelX in range(pixel_xmin, pixel_xmax):
		var x = map(pixelX, pixel_xmin, pixel_xmax, xmin, xmax)
		if lastX == x:
			continue

		for graphName in graphs.keys():
			var lastY = map(graphs[graphName][0], ymin, ymax, pixel_ymin, pixel_ymax)
			var pixelY = map(data[x][graphName], ymin, ymax, pixel_ymin, pixel_ymax)
			draw_line(
				Vector2(lastX, lastY),
				Vector2(pixelX, pixelY),
				graphs[graphName][1]
			)
			graphs[graphName][0] = data[x][graphName]

		lastX = pixelX


func map(x: int, minFrom: int, maxFrom: int, minTo: int, maxTo: int) -> int:
	return (x - minFrom) * (maxTo - minTo) / (maxFrom - minFrom) + minTo
