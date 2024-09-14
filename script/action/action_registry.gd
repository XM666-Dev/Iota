class_name ActionRegistry

static var registry: Array[StringName]

static func register(action: StringName, index: int) -> StringName:
	InputMap.add_action(action)
	InputMap.action_add_event(action, get_event(index))
	registry.push_back(action)
	return action

static func get_event(index: int) -> InputEvent:
	var event: InputEvent
	if index <= MOUSE_BUTTON_XBUTTON2:
		event = InputEventMouseButton.new()
		event.button_index = index
	else:
		event = InputEventKey.new()
		event.keycode = index
	return event
