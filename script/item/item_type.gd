class_name ItemType extends Resource

@export var item_class: GDScript = Item
@export var texture: Texture2D = PlaceholderTexture2D.new()
@export var max_number: int = 64

static func from_dictionary(dictionary: Dictionary) -> ItemType:
	return IS.create_from_dictionary(ItemType, dictionary)
