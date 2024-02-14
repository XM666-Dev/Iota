@tool
class_name SpritePattern extends Pattern

@export var amount: int = 1
@export_group("Time")
@export_range(0.0, 600.0, 0.01) var cycle: float = 1.0
@export_range(0.0, 1.0, 0.01) var cycle_randomness: float = 0.0
@export_group("Drawing")
@export var texture: Texture2D
@export_group("Position")
@export var position_randomness: bool = false
@export_group("Scale")
@export var scale_amount_min: float = 1.0
@export var scale_amount_max: float = 1.0
@export_group("Color")
@export var color_ramp: Gradient
@export var color_initial_ramp: Gradient

func _draw(to_canvas_item: RID, rect: Rect2):
	for i in amount:
		var final_cycle := cycle * randf_range(1.0 - cycle_randomness, 1.0)
		var ratio := ISMath.floor_modulo(Main.timer.time_left, final_cycle) / final_cycle as float
		var position := Vector2(randf_range(rect.position.x, rect.end.x), randf_range(rect.position.y, rect.end.y)) \
			if position_randomness else rect.position
		var size := texture.get_size() * randf_range(scale_amount_min, scale_amount_max)
		var color := color_ramp.sample(ratio) if color_ramp != null else Color.WHITE * \
			color_initial_ramp.sample(randf()) if color_initial_ramp != null else Color.WHITE
		texture.draw_rect(to_canvas_item, Rect2(position, size), false, color)
