class_name Debuff extends Area2D

enum DEBUF_TYPE {
	player_slow, enemy_speed_up, enemy_spawn_rate_up
}

@export var type: DEBUF_TYPE


func _on_area_entered(area: Area2D) -> void:
	print("hit debuf", type)
	if (area is Player):
		match type:
			DEBUF_TYPE.player_slow:
				Globals.player_speed *= 0.8
			DEBUF_TYPE.enemy_speed_up:
				Globals.enemy_speed_max *= 1.2
				Globals.enemy_speed_min *= 1.2
			DEBUF_TYPE.enemy_spawn_rate_up:
				Globals.enemy_spawn_rate += 1
				
		queue_free()
