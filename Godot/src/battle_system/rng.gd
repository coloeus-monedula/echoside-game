extends Node

#import specific array from somewhere
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#imported list of enemies that will show up
#TODO: hardcoded at the moment, and will only generate one enemy
var enemy_array = ["Wasp", "Centipede"]
var enemy_rngs = {}
#TODO: should be imported from player state
var player_stats = {
	"attack": 12,
	"defend": 12,
	"falter": 12
}


# Called when the node enters the scene tree for the first time.
func _ready():
	# catch signal here?
	pass # Replace with function body.


var counter = 0;
#Given enemy data from a (JSON?) file (or dictionary within a file), creates a RNG wheel for them
#Which is then added to dictionary (unique id will be id of enemy node in future) 
func create_enemy_rng(enemy):
	var enemy_roulette = [] 
	#TODO: grab these from enemy data.
	var enemy_attack = 12
	var enemy_defend = 16
	var enemy_falter = 8
	var enemy_hp
	
	for i in enemy_attack:
		enemy_roulette.append("a")
	for i in enemy_defend:
		enemy_roulette.append("d")
	for i in enemy_falter:
		enemy_roulette.append("f")
		
	# adds to enemy rngs with id = counter
	var enemy_block = {
		"roulette": enemy_roulette,
		"hp": enemy_hp
	}
	enemy_rngs[counter] = enemy_block
	counter +=1


#func decide_action():
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
