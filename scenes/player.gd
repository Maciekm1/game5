class_name Player extends Area2D

@export var speed = 400
@export var health_component: HealthComponent
@export var bullet_scene: Bullet
var screen_size

signal hit
signal died

func _ready():
	hide()
	screen_size = get_viewport_rect().size
	health_component.died.connect(on_player_died)
	
func _process(delta: float) -> void:
	var vel = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		vel.x += 1
	if Input.is_action_pressed("move_left"):
		vel.x -= 1
	if Input.is_action_pressed("move_up"):
		vel.y -= 1
	if Input.is_action_pressed("move_down"):
		vel.y += 1
	if Input.is_action_just_pressed("take_damage"):
		health_component.take_damage(1)
	if Input.is_action_just_pressed("heal"):
		health_component.heal(1)
		
	if vel.length() > 0:
		vel = vel.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += vel * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	
	if vel.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = vel.x < 0
	elif vel.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = vel.y > 0
		

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_body_entered(body: Node2D) -> void:
	hit.emit()
	health_component.take_damage(1)
	if body is Mob:
		body.die()
	# Must be deferred as we can't change physics properties on a physics callback.
	# $CollisionShape2D.set_deferred("disabled", true) # Replace with function body.

func on_player_died():
	died.emit()
	
func reset_health():
	health_component.heal(999)
	

	
