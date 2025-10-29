extends AnimatedSprite2D

var previous_position := Vector2.ZERO

func _process(delta: float) -> void:
	var node := get_parent()
	
	if node is CharacterBody2D:
		flip_sprite_using_velocity(node)
	else:
		flip_sprite_using_position(node)
	
func flip_sprite_using_velocity(character_body: CharacterBody2D) -> void:
	check_x_and_flip(character_body.velocity)

func flip_sprite_using_position(node: Node2D) -> void:
	if previous_position == Vector2.ZERO:
		previous_position = node.position
		return
	
	var direction := node.position - previous_position
	
	check_x_and_flip(direction)
	
	previous_position = node.position
	
func check_x_and_flip(vector: Vector2) -> void:
	if vector.x > 0:
		flip_h = false
	elif vector.x < 0:
		flip_h = true
	
