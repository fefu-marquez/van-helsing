extends CharacterBody2D

@export var speed := 20.0

func _process(delta: float) -> void:
	move_towards_player($"../../Player".position)
	move_and_slide()

func move_towards_player(player_position: Vector2) -> void:
	var direction := (player_position - position).normalized()
	velocity = direction * speed
