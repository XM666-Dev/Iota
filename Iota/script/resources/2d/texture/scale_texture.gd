@tool
class_name ScaleTexture extends ProxyTexture2D

@export var scale: Vector2 = Vector2(1.0, 1.0)

func get_transform() -> Transform2D:
	return Transform2D.IDENTITY.scaled(scale)

func _draw(to_canvas_item: RID, pos: Vector2, modulate: Color, transpose: bool):
	draw_rect(to_canvas_item, Rect2(pos, get_size() * scale), false, modulate, transpose)

func _draw_rect_region(to_canvas_item: RID, rect: Rect2, src_rect: Rect2, modulate: Color, transpose: bool, clip_uv: bool):
	super(to_canvas_item, rect, get_transform().affine_inverse() * src_rect, modulate, transpose, clip_uv)

func _get_height():
	return super() * scale.y

func _get_width():
	return super() * scale.x
