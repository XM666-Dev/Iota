extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#transform = get_global_transform_with_canvas()
	#if !Input.is_key_pressed(KEY_A): return
	#ISCanvas.set_transform(self, ISCanvas.CANVAS_LEVEL_VIEWPORT, Transform2D())
	#print(get_global_transform_with_canvas().origin)
	#print("pos: ", position)
	queue_redraw()

func _draw():
	ISCanvas.draw_set_level(self, ISCanvas.CANVAS_LEVEL_VIEWPORT)
	#draw_set_transform_matrix(get_global_transform_with_canvas().affine_inverse())
	draw_rect(Rect2(0, 0, 100, 100), Color.AQUA)
