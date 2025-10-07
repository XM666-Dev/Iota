class_name PatternBackground extends Node2D

const limit: int = 8192

@export var cell_size: Vector2 = Vector2(256, 256)
@export var cell_margin_left: float
@export var cell_margin_top: float
@export var cell_margin_right: float = cell_size.x
@export var cell_margin_bottom: float = cell_size.y
@export var patterns: Array[Pattern]

func wrap_inverse(number: int) -> int:
	return number + ISMath.INT32_MAX if number < 0 else number

func rect_from_to(from: Vector2i, to: Vector2i) -> Rect2i:
	return Rect2i(from, to - from)

func get_pattern_weights() -> Array[float]:
	return IS.as_float_array(patterns.map(func(pattern: Pattern): return pattern.weight))

func _ready():
	position = Vector2.ZERO

func _process(_delta):
	queue_redraw()

func _draw():
	var draw_rect = ((get_viewport_transform() * transform).affine_inverse() * get_viewport_rect()) \
		.grow_individual(cell_margin_left, cell_margin_top, cell_margin_right, cell_margin_bottom)
	var cell_rect := rect_from_to(
		(draw_rect.position / cell_size).floor(),
		(draw_rect.end / cell_size).floor()
	)
	var draw_origin := Vector2(cell_rect.position) * cell_size
	var draw_position := draw_origin
	var count := 0
	for y in range(cell_rect.position.y, cell_rect.end.y):
		draw_position.x = draw_origin.x
		for x in range(cell_rect.position.x, cell_rect.end.x):
			if !count < limit: break
			count += 1
			seed(wrap_inverse(y) << 32 | wrap_inverse(x))
			var index := IS.pick_weight_element(get_pattern_weights())
			var pattern := patterns[index]
			pattern.draw(get_canvas_item(), Rect2(draw_position, cell_size))
			draw_position.x += cell_size.x
		draw_position.y += cell_size.y
