

#import specific array from somewhere
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng: RandomNumberGenerator

func _init() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()


func choose_enemy(enemy_array: Array, enemy_stats: Dictionary) -> void:
	var choice: int = rng.randi_range(0, enemy_array.size() - 1)
	create_enemy_rng(enemy_array[choice], enemy_stats)

#used for the dictionary key.
var counter: int = 0;
#Given enemy data from a (JSON?) file (or dictionary within a file), creates a RNG wheel for them
#Which is then added to dictionary passed in
func create_enemy_rng(enemy: String, enemy_stats: Dictionary) -> void:
	var enemy_roulette: Array = [] 
	#TODO: grab these from enemy data.
	var enemy_attack = 12
	var enemy_defend = 16
	var enemy_falter = 8
	var enemy_hp = 3
	#atm just drawn from enemy
	var enemy_name = enemy

		
	# adds to enemy rngs with id = counter
	var enemy_block: Dictionary = {
		"attack": enemy_attack,
		"defend": enemy_defend,
		"falter": enemy_falter,
		"hp": enemy_hp,
		"name": enemy_name
	}
	enemy_stats[counter] = enemy_block
	counter +=1


func decide_action(creature_block):
	var total = creature_block.attack + creature_block.defend + creature_block.falter
	if total < 1:
		print("Error: Creature has no stats")
		#automatically means creature will falter
		return "ERROR"
	var choice = rng.randi_range(1, total)
	if (choice <= creature_block.attack) :
		return "a"
	elif (choice <= creature_block.attack + creature_block.defend):
		return "d"
	else:
		return "f"


func is_run_successful(percentage):
	var chance = rng.randi_range(1, 100)
	if (chance <= percentage):
		return true
	else:
		return false
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
