class_name ItemStorage extends Node

var items: Dictionary

func get_item(coords: Vector2i) -> Item:
	return items.get(coords)

func set_item(coords: Vector2i, item: Item):
	items[coords] = item

func get_coords() -> Array[Vector2i]:
	return IS.as_vector2i_array(items.keys())
