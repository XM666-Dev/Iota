class_name Registry

static var registers: Dictionary

static func get_register(object_script: GDScript) -> Dictionary:
	registers.merge({ object_script: {} })
	return registers[object_script]

static func make_id(package: GDScript, unique_name: StringName) -> StringName:
	assert(unique_name.is_valid_identifier())
	return PackageRegistry.get_unique_name(package) + "." + unique_name

static func get_id(object: Object, object_script: GDScript) -> StringName:
	return get_register(object_script).find_key(object)

static func register_object(object: Object, object_script: GDScript, package: GDScript, unique_name: StringName):
	var register := get_register(object_script)
	var id := make_id(package, unique_name)
	assert(!register.has(id))
	register[id] = object
