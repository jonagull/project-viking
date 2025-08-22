extends Node2D

@export var EnemyScene  = preload("res://scenes/Enemy.tscn")
var rng = RandomNumberGenerator.new()

func _ready():
	print("mainscne!")

func _on_timer_timeout() -> void:
	var enemy = EnemyScene.instantiate()
	enemy.position = Vector2(rng.randf_range(0, 100), 100)
	#enemy.player = PlayerScene
	add_child(enemy)
