class_name PackageRegistry

static var packages := {}

static func get_package(unique_name: StringName) -> GDScript:
	return packages.get(unique_name)

static func get_unique_names() -> Array[StringName]:
	return IS.as_string_name_array(packages.keys())

static func get_unique_name(package: GDScript) -> StringName:
	return package.UNIQUE_NAME

static func register_package(package: GDScript):
	var unique_name := get_unique_name(package)
	assert(unique_name.is_valid_identifier())
	assert(!packages.has(unique_name))
	packages[unique_name] = package
