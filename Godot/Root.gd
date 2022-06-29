extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	var test_array = ["Wasp","Bear","Even Bigger Bear", "Enormous Wasp"]
	$"test battle".start_battle(test_array)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
