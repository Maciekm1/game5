extends Node

var player_speed: float
var enemy_speed_min: float
var enemy_speed_max: float
var enemy_spawn_rate: int

func _ready() -> void:
	enemy_spawn_rate = 1
	player_speed = 400
	enemy_speed_min = 250
	enemy_speed_max = 500
	
