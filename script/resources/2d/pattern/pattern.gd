@tool
class_name Pattern extends Resource

@export var weight: float = 1.0

func _draw(to_canvas_item: RID, rect: Rect2):
	pass

func draw(to_canvas_item: RID, rect: Rect2):
	_draw(to_canvas_item, rect)
