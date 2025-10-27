# DECLARATIONS
# ----------------------------
extends CharacterBody2D

#  VARIABLES
# ----------------------------
@onready var timer: Timer = $Timer
@export var speed: float = 40.0
@export var atktime: float = 1.5

#  PROCESSES
# ----------------------------
func _ready() -> void:
	timer.wait_time = atktime
	timer.start()
	$AnimatedSprite2D.play("idle")
	timer.timeout.connect(_on_timeout)

func _on_timeout() -> void:
	$AnimatedSprite2D.play("attack")

func _physics_process(delta: float) -> void:
	handle_input()
	update_animation()
	move_and_slide()

#  INPUT & MOVEMENT LOGIC
# ----------------------------
func handle_input() -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction.normalized() * speed

	# Handle sprite facing direction
	if input_direction.x < 0:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.offset.x = -32
	elif input_direction.x > 0:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.offset.x = 32

#  ANIMATION LOGIC
# ----------------------------
func update_animation() -> void:
	var anim = $AnimatedSprite2D

	# Prevent overriding attack animation
	if anim.animation == "attack":
		if anim.is_playing():
			return
		else:
			anim.play("idle")
			return

	# Movement animations
	if velocity.length() > 0:
		anim.play("walk")
	else:
		anim.play("idle")
