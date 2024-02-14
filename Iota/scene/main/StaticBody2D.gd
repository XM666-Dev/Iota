extends StaticBody2D

func _process(delta):
	queue_redraw()

func _draw():
	var rect := get_viewport_transform().affine_inverse() * get_viewport_rect()
	var point_from := Vector2(rect.position.x, 0)
	var point_to := Vector2(rect.end.x, 0)
	draw_line(point_from, point_to, Color.SKY_BLUE)
