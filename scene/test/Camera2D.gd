extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed(Actions.MOVE_LEFT):
		position.x -= 5
	if Input.is_action_pressed(Actions.MOVE_RIGHT):
		position.x += 5
	if Input.is_action_pressed(Actions.MOVE_UP):
		position.y -= 5
	if Input.is_action_pressed(Actions.MOVE_DOWN):
		position.y += 5
	if Input.is_key_pressed(KEY_M):
		zoom += Vector2(0.1, 0.1)
	if Input.is_key_pressed(KEY_N):
		zoom -= Vector2(0.1, 0.1)
