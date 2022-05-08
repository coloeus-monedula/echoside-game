

#logic for doing an entire battle
class Battle:
	#list of enemies that will show up
	var enemy_array
	var enemy_rngs = {}
	var rng_script
	var rng

	#TODO: should be imported from player state
	var player_stats = {
		"attack": 12,
		"defend": 12,
		"falter": 12,
		"hp": 3
	}
	
	func _init(enemy_array):
		rng_script = preload("res://src/battle_system/rng.gd")
		rng = rng_script.Rng.new()
		# currently hardcoded but will need to be passed in
		self.enemy_array = enemy_array
	
	
	func start_battle():	
		rng.choose_enemy(enemy_array, enemy_rngs)
		do_round()

	
		
	func do_round():
		var player_action = rng.decide_action(player_stats)
		#TODO: CHANGE SO THIS ISNT HARDCODED
		var enemy_action = rng.decide_action(enemy_rngs[0])
		
		if (player_action == "a"):
			print("You're set up for an attack!")
		elif (player_action == "d"):
			print("You're set up to defend!")
		else:
			#if ERROR returned, auto falter
			player_action = "f"
			print("You fumbled your set up this time...")
			
		print("The ", enemy_rngs[0].name, " is: ")
		if (enemy_action == "a"):
			print("Attacking!")
		elif (enemy_action == "d"):
			print("Defending!")
		else:
			enemy_action = "f"
			print("Doing nothing...")
			
		
		get_outcome(player_action, enemy_action, enemy_rngs[0])
		print(player_stats, enemy_rngs[0])
		
			
	
	func get_outcome(player_action, enemy_action, enemy_stats):
		if (player_action == "a" and enemy_action == "a"):
			player_stats.hp -=1
			enemy_stats.hp -=1
			
			print("Ouch! You both hurt each other...")
		elif (player_action == "a" and enemy_action == "d"):
			print("Your attack is blocked!")
		elif (player_action == "d" and enemy_action == "a"):
			print("You blocked its attack!")
		elif (player_action == "d" and enemy_action == "d"):
			print("You both blocked, but neither of you attack.")
		elif (player_action == "f" and enemy_action == "a"):
			player_stats.hp -=2
			
			print("It hit you while you were vulnerable!")
		elif (player_action == "a" and enemy_action == "f"):
			enemy_stats.hp -=2
			
			print("You struck it while it was weak!")
		elif (player_action == "f" and enemy_action == "d"):
			print("It defended against nothing.")
		elif (player_action == "d" and enemy_action == "f"):
			print("You defended against nothing.")
		else:
			print("Nothing happens...")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

