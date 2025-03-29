class_name HealthBar
extends ProgressBar

@export var visible_only_if_damaged: bool = false
@export var fade_away: bool = false
@export var fade_away_after: float = 1
@export var fade_away_duration: float = 1
@export var health_component: HealthComponent
@onready var take_damage_animator: AnimationPlayer = $TakeDamageAnimator
@onready var low_health_animator: AnimationPlayer = $LowHealthAnimator
@onready var fade_away_timer = $FadeAwayTimer

func _ready():
	if fade_away or visible_only_if_damaged:
		modulate.a = 0
	value = 1
	health_component.health_changed.connect(on_health_changed)
	
	fade_away_timer.wait_time = fade_away_after
	fade_away_timer.timeout.connect(on_fade_away_timer_timeout)
	
func on_health_changed():
	# Visible
	modulate.a = 1
	
	if take_damage_animator.is_playing():
		take_damage_animator.stop()
	take_damage_animator.play("take_damage")
	value = health_component.get_health_percent()
	if health_component.current_health <= 2:
		low_health_animator.play("low_health")
	
	if fade_away:
		fade_away_timer.start()
	
func on_fade_away_timer_timeout():
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, 'modulate:a', 0, fade_away_duration)
	
