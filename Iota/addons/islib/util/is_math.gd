class_name ISMath

const INT32_MAX := 1 << 31

static func number_modulo(a: Variant, b: Variant) -> Variant:
	return a % b if a is int else fmod(a, b)

static func floor_divide(a: Variant, b: Variant) -> Variant:
	if a is Vector2:
		return Vector2(floor_divide(a.x, b.x), floor_divide(a.y, b.y))
	if a is Vector2i:
		return Vector2i(floor_divide(a.x, b.x), floor_divide(a.y, b.y))
	var value := number_modulo(a, b)
	return a / b - int(value < 0)

static func floor_modulo(a: Variant, b: Variant) -> Variant:
	if a is Vector2:
		return Vector2(floor_modulo(a.x, b.x), floor_modulo(a.y, b.y))
	if a is Vector2i:
		return Vector2i(floor_modulo(a.x, b.x), floor_modulo(a.y, b.y))
	var value := number_modulo(a, b)
	return value + int(value < 0) * b

static func angle_positive(angle: float) -> float:
	return floor_modulo(angle, PI * 2)

static func angle_difference_clockwise(a: float, b: float) -> float:
	var difference := a - b
	return angle_positive(difference) if difference < 0.0 else difference
