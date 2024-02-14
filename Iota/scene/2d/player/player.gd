@tool
class_name Player extends CharacterBody2D

var current_hand: Sprite2D

func get_body() -> Node2D:
	return $Body

func get_body_node(path: NodePath) -> Sprite2D:
	return get_body().get_node(path)

func get_hands() -> Array[Sprite2D]:
	var hands := [] as Array[Sprite2D]
	hands.assign(get_tree().get_nodes_in_group("hand"))
	return hands

func update_hand(hand: Sprite2D, enabled: bool):
	hand.visible = enabled
	var remote := hand.get_node("RemoteTransform2D")
	remote.update_position = enabled
	remote.update_rotation = enabled
	remote.update_scale = enabled

func get_holder() -> ItemHolder:
	return get_node("ItemHolder")

func get_storage() -> ItemStorage:
	return $ItemStorage

func is_approx(a: float, b: float, c: float) -> bool:
	return a > b - c && a < b + c

func _process(_delta):
	var body := get_body()
	body.position = -get_body_node("Trunk").texture.get_size() / 2
	body.scale.x = 1

	if !Engine.is_editor_hint():
		if Input.is_action_pressed(Actions.MOVE_LEFT):
			velocity.x -= 20
		if Input.is_action_pressed(Actions.MOVE_RIGHT):
			velocity.x += 20
		if Input.is_action_pressed(Actions.MOVE_UP):
			#print(remap(velocity.y, -40.0, 20.0, 40.0, 20.0))
			velocity.y -= clampf(remap(velocity.y, -20.0, 40.0, 20.0, 100.0), 20.0, 100.0)
		if Input.is_action_pressed(Actions.MOVE_DOWN):
			velocity.y += 20
		if Input.is_action_just_pressed(Actions.OPEN_INVENTORY):
			var inventory := Main.get_player_inventory()
			inventory.visible = !inventory.visible
		if Input.is_action_just_pressed(Actions.MOVE_DASH):
			velocity += get_local_mouse_position().normalized() * 1000
	velocity += get_gravity() / 100 # 惯性太大了
	if is_on_floor():
		velocity *= Vector2(0.93, 0.99)
	else:
		velocity *= Vector2(0.95, 0.99)
	move_and_slide()

	var hand: Sprite2D = null
	if !Engine.is_editor_hint():
		const QUARTER_RIGHT_ANGLE := deg_to_rad(22.5)
		var mouse_position := get_local_mouse_position()
		var hand_angle := ISMath.angle_positive(mouse_position.angle())
		if mouse_position.x < 0.0:
			hand_angle = ISMath.angle_positive(deg_to_rad(180) - hand_angle)
			body.position.x = -body.position.x
			body.scale.x = -body.scale.x
		if is_approx(hand_angle, deg_to_rad(0), QUARTER_RIGHT_ANGLE) || is_approx(hand_angle, deg_to_rad(360), QUARTER_RIGHT_ANGLE):
			hand = get_body_node("Hand0")
		elif is_approx(hand_angle, deg_to_rad(45), QUARTER_RIGHT_ANGLE):
			hand = get_body_node("Hand45")
		elif is_approx(hand_angle, deg_to_rad(90), QUARTER_RIGHT_ANGLE):
			hand = get_body_node("Hand90")
		elif is_approx(hand_angle, deg_to_rad(270), QUARTER_RIGHT_ANGLE):
			hand = get_body_node("Hand270")
		else:
			hand = get_body_node("Hand315")
	else:
		for node: Sprite2D in get_hands():
			if node.visible: hand = node
		if hand == null: hand = get_body_node("Hand0")

	for node: Sprite2D in get_hands():
		update_hand(node, node == hand)

	if !Engine.is_editor_hint():
		var holder := get_holder()
		holder.storage = get_storage()
		holder.coords = Vector2i(0, 0)
		var holder_marker := get_node("Holder") as Node2D
		holder_marker.look_at(get_global_mouse_position())
