extends Node

@export var mob_scene: PackedScene
@export var debuff_scene: PackedScene
var score


func _on_player_hit() -> void:
	Globals.emit_played_damaged()
	
	
func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
func new_game():
	get_tree().call_group("mobs", "queue_free")
	
	score = 0
	$Player.start($StartPosition.position)
	$Player.reset_health()
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")


func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	for i in range(Globals.enemy_spawn_rate):
		var mob = mob_scene.instantiate()

		# Choose a random location on Path2D.
		var mob_spawn_location = $MobPath/MobSpawnLocation
		mob_spawn_location.progress_ratio = randf()

		# Set the mob's position to the random location.
		mob.position = mob_spawn_location.position

		# Set the mob's direction perpendicular to the path direction.
		var direction = mob_spawn_location.rotation + PI / 2

		# Add some randomness to the direction.
		direction += randf_range(-PI / 4, PI / 4)
		mob.rotation = direction

		# Choose the velocity for the mob.
		var velocity = Vector2(randf_range(Globals.enemy_speed_min, Globals.enemy_speed_max), 0.0)
		mob.linear_velocity = velocity.rotated(direction)

		# Spawn the mob by adding it to the Main scene.
		add_child(mob)


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	$DebuffTimer.start()


func _on_hud_start_game() -> void:
	new_game() # Replace with function body.


func _on_player_died() -> void:
	game_over()


func _on_debuff_timer_timeout() -> void:
	# Random position for debuff
	var screen_size = get_viewport().get_visible_rect().size
	var pos = Vector2(randf() * screen_size.x, randf() * screen_size.y)
	
	var debuff = debuff_scene.instantiate() as Debuff
	add_child(debuff)
	#debuff.type = randi() % len(Debuff.DEBUF_TYPE)
	debuff.position = pos
