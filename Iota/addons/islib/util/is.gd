class_name IS

static func as_int_array(array: Array) -> Array[int]:
	var new_array := [] as Array[int]
	new_array.assign(array)
	return new_array

static func as_float_array(array: Array) -> Array[float]:
	var new_array := [] as Array[float]
	new_array.assign(array)
	return new_array

static func as_vector2_array(array: Array) -> Array[Vector2]:
	var new_array := [] as Array[Vector2]
	new_array.assign(array)
	return new_array

static func as_vector2i_array(array: Array) -> Array[Vector2i]:
	var new_array := [] as Array[Vector2i]
	new_array.assign(array)
	return new_array

static func as_string_array(array: Array) -> Array[String]:
	var new_array := [] as Array[String]
	new_array.assign(array)
	return new_array

static func as_string_name_array(array: Array) -> Array[StringName]:
	var new_array := [] as Array[StringName]
	new_array.assign(array)
	return new_array

static func range_float(b: float, n: Variant = null, s: float = 1.0) -> Array[float]:
	var array := [] as Array[float]
	if n == null:
		n = b
		b = 0.0
	array.assign(range(ceili((float(n) - b) / s)).map(func(value): return b + value * s))
	return array

static func range_vector2i(b: Vector2i, n: Variant = null, s: Vector2i = Vector2i.ONE) -> Array[Vector2i]:
	var array := [] as Array[Vector2i]
	if n == null:
		n = b
		b = Vector2i.ZERO
	for y in range(b.y, n.y, s.y):
		for x in range(b.x, n.x, s.x):
			array.push_back(Vector2i(x, y))
	return array

static func sum(array: Array) -> Variant:
	return array.reduce(func(a, b): return a + b)

static func accumulate(array: Array, accum: Variant = null) -> Array:
	var new_array := []
	array.reduce(func(accum, value):
		new_array.push_back(accum)
		return accum + value
	, accum)
	return new_array

static func find_if(array: Array, method: Callable) -> int:
	var index := 0
	for element in array:
		if method.call(element):
			break
		index += 1
	return index

static func pick_weight_element(weights: Array[float]) -> int:
	var number := randf_range(0.0, sum(weights))
	return find_if(accumulate(weights), func(element): return element > number)

static func find_child(node: Node, type: String) -> Node:
	return node.find_children("", type, false)[0]

static func has_property(object: Object, property: StringName) -> bool:
	for dictionary in object.get_property_list():
		if dictionary["name"] == property: return true
	return false

static func set_properties(object: Object, properties: Dictionary):
	for key in properties:
		assert(has_property(object, key))
		object.set_indexed(key, properties[key])

static func create_from_dictionary(object_class: Object, properties: Dictionary) -> Object:
	var object := object_class.new() as Object
	set_properties(object, properties)
	return object

static func swap(object_a: Object, object_b: Object, property_a: NodePath, property_b: NodePath):
	var value_a := object_a.get_indexed(property_a)
	var value_b := object_b.get_indexed(property_b)
	object_a.set_indexed(property_a, value_b)
	object_b.set_indexed(property_b, value_a)

static func make_unique(string: String, array: Array[String]) -> String:
	if array.has(string):
		var number_length := 0
		var string_length := string.length()
		for i in range(string_length - 1, -1, -1):
			var str := string.substr(i, 1)
			if !str.is_valid_int():
				break
			number_length += 1
		var new_string := (string.right(number_length).to_int() + 1) as String
		return make_unique(new_string, array)
	return string
