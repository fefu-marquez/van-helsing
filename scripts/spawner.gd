extends Node2D

@export var spawn_rate := 0.5 # Seconds per monster
var time_since_last_spawn: float = 0

const monster_routes: Array[String] = ["res://scenes/fireling.tscn"]
var monster_scenes = []

func _ready() -> void:
	for route in monster_routes:
		var scene = load(route)
		monster_scenes.append(scene)

func spawn_monster(monster_index: int, at_position: Vector2) -> void:
	var instance = monster_scenes[monster_index].instantiate()
	instance.position = at_position
	add_child(instance)
	
func _process(delta: float) -> void:
	if should_spawn(delta):
		spawn_random_monster()
	
func spawn_random_monster() -> void:
	var random_index := randi_range(0, len(monster_routes) - 1)
	var position := get_random_position_at_the_edge_of_screen()
	
	spawn_monster(random_index, position)
	
func should_spawn(delta: float) -> bool:
	time_since_last_spawn += delta
	var should_spawn := has_passed_enough_time_for_spawn(delta)
	
	if should_spawn:
		time_since_last_spawn -= spawn_rate
		
	return should_spawn
	
func has_passed_enough_time_for_spawn(delta: float) -> bool:	
	return spawn_rate <= time_since_last_spawn
	
func get_random_position_at_the_edge_of_screen() -> Vector2:
	var x: float = randf_range(-1, 1)
	var y: float = randf_range(-1, 1)
	
	var direction := Vector2(x, y).normalized()
	
	return direction * 190 + $"../Player".position
