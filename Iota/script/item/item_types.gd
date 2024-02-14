class_name ItemTypes

static var AIR := create("air", {
	texture = AtlasTexture.new()
})
static var DIAMOND := create("diamond", {
	texture = preload("res://resources/texture/item/diamond.png")
})
static var STICK := create("stick", {
	texture = preload("res://resources/texture/item/stick.png")
})
static var DIAMOND_SWORD := create("diamond_sword", {
	texture = preload("res://resources/texture/item/diamond_sword.tres")
})

static func create(unique_name: StringName, dictionary: Dictionary = {}) -> ItemType:
	var item_type := ItemType.from_dictionary(dictionary)
	Registry.register_object(item_type, ItemType, Iota, unique_name)
	return item_type
