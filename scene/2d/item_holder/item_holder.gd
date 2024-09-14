class_name ItemHolder extends Sprite2D

const MARKER_HOLDER := "Holder"
const MARKER_HOLDING := "Holding"

var storage: ItemStorage
var coords: Vector2i

func get_item() -> Item:
	return storage.get_item(coords)

func get_holder_transform() -> Transform2D:
	var holder_marker := get_parent().get_node(MARKER_HOLDER) as Marker2D
	return holder_marker.transform

func get_holding_transform() -> Transform2D:
	var item := get_item()
	var marker_transform: Variant = MarkerTexture.get_marker_transform(item.get_texture(), MARKER_HOLDING)
	return Transform2D.IDENTITY if marker_transform == null else marker_transform

func _process(_delta):
	texture = get_item().get_texture()
	transform = get_holder_transform() * get_holding_transform().affine_inverse()
