class_name SlotContainer extends FlowContainer

@export var slot_scene: PackedScene
@export var storage: ItemStorage
@export var slot_number: Vector2i = Vector2i(9, 3)

var slots: Array[Slot]

func add_slot(coords: Vector2i):
	var slot := slot_scene.instantiate()
	slot.coords = coords
	slots.push_back(slot)
	add_child(slot)

func update():
	var slot_singleton := ISNode.get_singleton(slot_scene) as Slot
	custom_minimum_size = slot_singleton.size * Vector2(slot_number)
	for slot in slots:
		slot.free()
	for coords in IS.range_vector2i(slot_number):
		add_slot(coords)

func _ready():
	update()
