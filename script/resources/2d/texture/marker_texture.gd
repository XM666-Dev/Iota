@tool
class_name MarkerTexture extends ProxyTexture2D

@export var scene: PackedScene:
	get:
		return create_scene() if scene == null else scene

func create_scene() -> PackedScene:
	var sprite := Sprite2D.new()
	var scene := PackedScene.new()
	sprite.texture = src_texture
	scene.pack(sprite)
	scene.take_over_path(resource_path.trim_suffix(".tres") + ".tscn")
	return scene

static func get_marker_transform(texture: Texture2D, path: NodePath) -> Variant:
	var marker_texture := texture as MarkerTexture
	if !marker_texture: return null
	var node := ISNode.get_singleton(marker_texture.scene).get_node(path) as CanvasItem
	return null if !node else node.get_global_transform()
