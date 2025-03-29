extends Sprite2D

func _ready() -> void:
	var debuff = get_parent() as Debuff
	match debuff.type:
		Debuff.DEBUF_TYPE.player_slow:
			texture = load("res://assets/art/debuff1.png")
		Debuff.DEBUF_TYPE.enemy_speed_up:
			texture = load("res://assets/art/debuff2.png")
		Debuff.DEBUF_TYPE.enemy_spawn_rate_up:
			texture = load("res://assets/art/debuff3.png")

		
