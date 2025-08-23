extends Node2D

@onready var bar = $ProgressBar
var max_hp = 100
var current_hp = 100

func _ready():
	# Set up bar range
	bar.min_value = 0
	bar.max_value = max_hp
	bar.value = current_hp
	
