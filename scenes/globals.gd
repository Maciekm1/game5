extends Node

var player_speed: int
var enemy_speed_min: int
var enemy_speed_max: int
var enemy_spawn_rate: int

func _ready() -> void:
	enemy_spawn_rate = 1
	player_speed = 400
	enemy_speed_min = 250
	enemy_speed_max = 500
	
