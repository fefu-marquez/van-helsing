extends CharacterBody2D

@export var speed = 40

func _ready() -> void:
	$AnimatedSprite2D.play('idle')

func get_input() -> void:
	if ($AnimatedSprite2D.animation == "attack"):
		if ($AnimatedSprite2D.is_playing()):
			return
		else:
			$AnimatedSprite2D.play("idle")
	else:
		if (Input.is_action_pressed("attack")):
			$AnimatedSprite2D.play("attack")
			velocity = Vector2.ZERO
			return
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction.normalized() * speed
	#$"../Map".velocity = input_direction.normalized() * speed
	
	if (input_direction != Vector2.ZERO):
		$AnimatedSprite2D.play('walk')
		
		if (input_direction.x < 0):
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.offset.x = -32
		else:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.offset.x = 32
	else: 
		$AnimatedSprite2D.play('idle')

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
