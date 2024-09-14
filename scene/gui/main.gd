class_name Main extends Node2D

static var main: Main
static var timer: SceneTreeTimer

static func get_creatures() -> Node2D:
	return main.get_node("Creatures")

static func get_gui_layer() -> CanvasLayer:
	return main.get_node("GuiLayer")

static func get_player() -> Player:
	return get_creatures().get_node("Player")

static func get_player_inventory() -> PanelContainer:
	return get_gui_layer().get_node("PlayerInventory")

func _ready():
	main = self
	timer = get_tree().create_timer(INF)
	var storage := Main.get_player().get_storage()
	var inventory := Main.get_player_inventory()
	var slot_container := inventory.get_node("ScrollContainer/SlotContainer") as SlotContainer
	for coords in IS.range_vector2i(slot_container.slot_number):
		storage.set_item(coords, Item.from_dictionary({
			type = Registry.get_register(ItemType).values().pick_random()
		}))
	slot_container.storage = storage
