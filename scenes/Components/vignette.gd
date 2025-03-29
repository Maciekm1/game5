extends CanvasLayer

func _ready():
	$AnimationPlayer.play("RESET")
	Globals.player_damaged.connect(on_player_damaged)
	#GameEvents.player_healed.connect(on_player_healed)
	
func on_player_damaged() -> void:
	$AnimationPlayer.play("player_damage")
	
func on_player_healed() -> void:
	$AnimationPlayer.play("player_heal")
