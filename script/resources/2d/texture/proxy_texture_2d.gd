@tool
class_name ProxyTexture2D extends Texture2D

@export var src_texture: Texture2D

func _draw(to_canvas_item: RID, pos: Vector2, modulate: Color, transpose: bool):
	src_texture.draw(to_canvas_item, pos, modulate, transpose)

func _draw_rect(to_canvas_item: RID, rect: Rect2, tile: bool, modulate: Color, transpose: bool):
	src_texture.draw_rect(to_canvas_item, rect, tile, modulate, transpose)

func _draw_rect_region(to_canvas_item: RID, rect: Rect2, src_rect: Rect2, modulate: Color, transpose: bool, clip_uv: bool):
	src_texture.draw_rect_region(to_canvas_item, rect, src_rect, modulate, transpose, clip_uv)

func _get_height():
	return src_texture.get_height()

func _get_width():
	return src_texture.get_width()

func _has_alpha():
	return src_texture.has_alpha()
