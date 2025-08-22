extends CharacterBody2D

@onready var anim_sprite = $AnimatedSprite2D
@export var speed := 100

var last_direction := "down"
var is_attacking := false

func _ready():
	# Connect animation finished signal
	print("ready player one")
	anim_sprite.connect("animation_finished", Callable(self, "_on_attack_finished"))

func _physics_process(_delta):
	#print(is_attacking)
	var input_vector = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	)

	if input_vector.length() > 0:
		velocity = input_vector.normalized() * speed
		move_and_slide()

		# Determine direction
		if abs(input_vector.x) > abs(input_vector.y):
			last_direction = "right" if input_vector.x > 0 else "left"
		else:
			last_direction = "down" if input_vector.y > 0 else "up"

		# Only change animation if not attacking
		if not is_attacking:
			anim_sprite.animation = "walk_" + last_direction
			anim_sprite.play()
	else:
		velocity = Vector2.ZERO
		if not is_attacking:
			anim_sprite.animation = "idle_" + last_direction
			anim_sprite.play()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		attack()

func attack():
	if is_attacking:
		return
	is_attacking = true
	var attack_anim = "chop_" + last_direction
	
	if anim_sprite.sprite_frames.has_animation(attack_anim):
		anim_sprite.animation = attack_anim
		anim_sprite.play()
	else:
		print("Missing attack animation:", attack_anim)
		is_attacking = false

func _on_animated_sprite_2d_animation_finished() -> void:
	print("finished")
	is_attacking = false
	#pass # Replace with function body.
