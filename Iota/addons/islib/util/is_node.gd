@tool
class_name ISNode

static var singletons: Dictionary = {}

static func register_singleton(scene: PackedScene):
	singletons[scene] = scene.instantiate()

static func get_singleton(scene: PackedScene) -> Node:
	if !singletons.has(scene):
		register_singleton(scene)
	return singletons[scene]
