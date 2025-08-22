extends Area2D


@export var speed := 50  # pixels per second
var player: Node2D = null
#@export var PlayerScene  = preload("res://scenes/player.tscn")

func _ready() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]
	print("player", player.global_position)
	pass

func _process(delta):
	if player == null: return
	
	var direction = (player.global_position - global_position).normalized()
	position += direction * speed * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
