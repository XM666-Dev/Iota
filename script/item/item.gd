class_name Item

var type: ItemType:
	get: return ItemTypes.AIR if type == null else type
var number: int = 1

static func create(item_type: ItemType) -> Item:
	return item_type.item_class.new()

static func from_dictionary(dictionary: Dictionary) -> Item:
	var item_type := dictionary["type"] as ItemType
	var item := create(item_type)
	IS.set_properties(item, dictionary)
	return item

func get_name() -> String:
	return Registry.get_id(self, ItemType).capitalize()

func get_texture() -> Texture2D:
	return type.texture
