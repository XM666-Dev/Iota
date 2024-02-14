class_name Slot extends Control

static var has_drop: bool

var coords: Vector2i

func get_slot_container() -> SlotContainer:
	return $".."

func get_storage() -> ItemStorage:
	return get_slot_container().storage

func get_item() -> Item:
	return get_storage().get_item(coords)

func get_sub_viewport_container() -> SubViewportContainer:
	return $SubViewportContainer

func get_sub_viewport() -> SubViewport:
	return get_sub_viewport_container().get_node("SubViewport")

func get_texture_rect() -> TextureRect:
	return get_sub_viewport().get_node("TextureRect")

func get_offset_mouse_position() -> Vector2:
	return get_global_mouse_position() - get_global_rect().size / 2

func swap(src_slot: Slot):
	var storage := get_storage()
	var src_storage := src_slot.get_storage()
	var item := get_item()
	var src_item := src_slot.get_item()
	storage.set_item(coords, src_item)
	src_storage.set_item(src_slot.coords, item)
	var container := get_sub_viewport_container()
	var src_container := src_slot.get_sub_viewport_container()
	container.z_index = 2
	src_container.z_index = 1
	var start_position := get_offset_mouse_position()
	var tween := create_tween()
	tween.tween_method(func(value):
		container.global_position = start_position.lerp(global_position, value)
		src_container.global_position = global_position.lerp(src_slot.global_position, value)
	, 0.0, 1.0, 0.1).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(func():
		container.z_index = 0
		src_container.z_index = 0
	)

func _process(_delta):
	get_texture_rect().texture = get_item().type.texture
	var flag := get_global_rect().has_point(get_global_mouse_position())
	modulate = Color(Color.WHITE, 0.8) if flag else Color.WHITE
	#get_sub_viewport_container().scale = Vector2(1.2, 1.2) if flag else Vector2(1.0, 1.0)

func _get_drag_data(_at_position):
	if get_item().type == ItemTypes.AIR: return
	var container := get_sub_viewport_container()
	container.visible = false
	var preview_control := Control.new()
	set_drag_preview(preview_control)
	var rect := TextureRect.new()
	rect.texture = get_sub_viewport().get_texture()
	rect.size = get_global_rect().size
	rect.position = -rect.size / 2
	preview_control.add_child(rect)
	preview_control.create_tween().tween_method(func(value):
		preview_control.global_position = get_global_rect().get_center().lerp(get_global_mouse_position(), value)
		preview_control.scale = Vector2.ONE.lerp(Vector2(0.8, 0.8), value)
	, 0.0, 1.0, 0.1).set_trans(Tween.TRANS_SINE)
	preview_control.connect("tree_exiting", func():
		container.visible = true
		#create_tween().tween_property(container, "scale", Vector2(1.0, 1.0), 1.1).from(Vector2(1.2, 1.2)).set_trans(Tween.TRANS_SINE)
		if !Slot.has_drop:
			var start_position := get_offset_mouse_position()
			create_tween().tween_method(func(value):
				container.global_position = start_position.lerp(global_position, value)
			, 0.0, 1.0, 0.1).set_trans(Tween.TRANS_SINE)
		Slot.has_drop = false
	)
	return self

func _can_drop_data(_at_position, data):
	return data is Slot

func _drop_data(_at_position, data):
	swap(data)
	Slot.has_drop = true
