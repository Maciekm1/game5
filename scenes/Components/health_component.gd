class_name HealthComponent
extends Node

signal died
signal health_changed
signal health_decreased
signal hit_while_dash_immune

@export var min_health: float = 10
@export var max_health: float = 10
@export var dash_component: Node
@export var grace_period: float = 0.0
@onready var grace_timer = $"../GraceTimer"
var current_health: float = 0

func _ready():
	current_health = randi_range(min_health, max_health)
	max_health = current_health
	if grace_period > 0:
		grace_timer.wait_time = grace_period

func take_damage(damage: float):
	if is_immune():
		return
	current_health = clamp(current_health - damage, 0, max_health)
	health_changed.emit()
	if damage > 0:
		health_decreased.emit()
		if grace_period > 0:
			grace_timer.start()
	Callable(check_death).call_deferred()
	
func heal(amount: int):
	take_damage(-amount)

func get_health_percent() -> float:
	if max_health <= 0:
		return 0
	return min(current_health / max_health, 1)
	
func check_death():
		if current_health == 0:
			died.emit()
			owner.queue_free()
			
func is_immune() -> bool:
	if dash_component and dash_component.is_immune():
		hit_while_dash_immune.emit()
	return !grace_timer.is_stopped() or (dash_component and dash_component.is_dashing and dash_component.immunity_frame) or (dash_component and dash_component.is_immune())
