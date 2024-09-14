class_name ISCanvas

enum CanvasLevel {
	LOCAL,
	PARENT,
	GLOBAL,
	VIEWPORT
}

const CANVAS_LEVEL_LOCAL = CanvasLevel.LOCAL
const CANVAS_LEVEL_PARENT = CanvasLevel.PARENT
const CANVAS_LEVEL_GLOBAL = CanvasLevel.GLOBAL
const CANVAS_LEVEL_VIEWPORT = CanvasLevel.VIEWPORT

static func get_transform(node: CanvasItem, level: CanvasLevel) -> Transform2D:
	match level:
		CANVAS_LEVEL_LOCAL:
			return Transform2D()
		CANVAS_LEVEL_PARENT:
			return node.get_transform()
		CANVAS_LEVEL_GLOBAL:
			return node.get_global_transform()
		CANVAS_LEVEL_VIEWPORT:
			return node.get_global_transform() * node.get_viewport_transform()
	return Transform2D()

static func set_transform(node: CanvasItem, level: CanvasLevel, transform: Transform2D):
	var final_transform := get_transform(node, level).affine_inverse() * node.get_transform() * transform
	var control := node as Control
	if control:
		control.position = final_transform.get_origin()
		control.rotation = final_transform.get_rotation()
		control.scale = final_transform.get_scale()
	var node_2d := node as Node2D
	if node_2d:
		node_2d.transform = final_transform

static func draw_set_level(node: CanvasItem, level: CanvasLevel) -> void:
	node.draw_set_transform_matrix(get_transform(node, level).affine_inverse())
