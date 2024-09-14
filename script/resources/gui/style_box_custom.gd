@tool
class_name StyleBoxCustom extends StyleBox

@export var texture: Texture2D
@export var texture_margin_left: float
@export var texture_margin_top: float
@export var texture_margin_right: float
@export var texture_margin_bottom: float

func _draw(to_canvas_item: RID, rect: Rect2):
	var rect_center := rect
	var rect_left := Rect2(rect_center.position.x - texture_margin_left, rect_center.position.y, texture_margin_left, rect_center.size.y)
	var rect_top := Rect2(rect_center.position.x, rect_center.position.y - texture_margin_top, rect_center.size.x, texture_margin_top)
	var rect_right := Rect2(rect_center.end.x, rect_center.position.y, texture_margin_right, rect_center.size.y)
	var rect_bottom := Rect2(rect_center.position.x, rect_center.end.y, rect_center.size.x, texture_margin_bottom)
	var rect_left_top := Rect2(rect_center.position - Vector2(texture_margin_left, texture_margin_top), Vector2(texture_margin_left, texture_margin_top))
	var rect_right_bottom := Rect2(rect_center.end, Vector2(texture_margin_right, texture_margin_bottom))
	var rect_left_bottom := Rect2(rect_center.position.x - texture_margin_left, rect_center.end.y, texture_margin_left, texture_margin_bottom)
	var rect_right_top := Rect2(rect_center.end.x, rect_center.position.y - texture_margin_top, texture_margin_right, texture_margin_top)

	var src_rect_center := Rect2(Vector2(), texture.get_size()) \
		.grow_individual(-texture_margin_left, -texture_margin_top, -texture_margin_right, -texture_margin_bottom)
	var src_rect_left := Rect2(0, texture_margin_top, texture_margin_left, src_rect_center.size.y)
	var src_rect_top := Rect2(texture_margin_left, 0, src_rect_center.size.x, texture_margin_top)
	var src_rect_right := Rect2(src_rect_center.end.x, texture_margin_top, texture_margin_right, src_rect_center.size.y)
	var src_rect_bottom := Rect2(texture_margin_left, src_rect_center.end.y, src_rect_center.size.x, texture_margin_bottom)
	var src_rect_left_top := Rect2(0, 0, texture_margin_left, texture_margin_top)
	var src_rect_right_bottom := Rect2(src_rect_center.end, Vector2(texture_margin_right, texture_margin_bottom))
	var src_rect_left_bottom := Rect2(0, src_rect_center.end.y, texture_margin_left, texture_margin_bottom)
	var src_rect_right_top := Rect2(src_rect_center.end.x, 0, texture_margin_right, texture_margin_top)

	texture.draw_rect_region(to_canvas_item, rect_center, src_rect_center)
	texture.draw_rect_region(to_canvas_item, rect_left, src_rect_left)
	texture.draw_rect_region(to_canvas_item, rect_top, src_rect_top)
	texture.draw_rect_region(to_canvas_item, rect_right, src_rect_right)
	texture.draw_rect_region(to_canvas_item, rect_bottom, src_rect_bottom)
	texture.draw_rect_region(to_canvas_item, rect_left_top, src_rect_left_top)
	texture.draw_rect_region(to_canvas_item, rect_right_bottom, src_rect_right_bottom)
	texture.draw_rect_region(to_canvas_item, rect_left_bottom, src_rect_left_bottom)
	texture.draw_rect_region(to_canvas_item, rect_right_top, src_rect_right_top)

func _get_draw_rect(rect: Rect2):
	return rect.grow_individual(texture_margin_left, texture_margin_top, texture_margin_right, texture_margin_bottom)

func _get_minimum_size():
	return Vector2(texture_margin_left + texture_margin_right, texture_margin_top + texture_margin_bottom)
