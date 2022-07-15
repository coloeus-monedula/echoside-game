extends Node2D
#list of enemies that will show up
var enemy_array
var enemy_rngs = {}
var rng
var round_done = false
var battle_done = false

var DOT_player = {
}
#name: amount
var DOT_enemies = []

#TODO: should be imported from player state
var player_stats = {
	"attack": 12,
	"defend": 12,
	"falter": 12,
	"hp": 3,
	"run": 40
}

func _ready():
	var rng_script = load("res://src/battle_system/rng.gd")
	rng = rng_script.new()



func start_battle(enemy):	
	self.enemy_array = enemy
	rng.choose_enemy(enemy_array, enemy_rngs)
	print("Press enter to start or f to run")
	round_done = true

	
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
	round_done = true
	print(player_stats, enemy_rngs[0])
			

func get_outcome(player_action, enemy_action, enemy_stats):
	
	
	# if (player_action == "a" and enemy_action == "a"):
	# 	player_stats.hp -=1
	# 	enemy_stats.hp -=1
	
	# 	print("Ouch! You both hurt each other...")
	# elif (player_action == "a" and enemy_action == "d"):
	# 	print("Your attack is blocked!")
	# elif (player_action == "d" and enemy_action == "a"):
	# 	print("You blocked its attack!")
	# elif (player_action == "d" and enemy_action == "d"):
	# 	print("You both blocked, but neither of you attack.")
	# elif (player_action == "f" and enemy_action == "a"):
	# 	player_stats.hp -=2
	
	# 	print("It hit you while you were vulnerable!")
	# elif (player_action == "a" and enemy_action == "f"):
	# 	enemy_stats.hp -=2
	
	# 	print("You struck it while it was weak!")
	# elif (player_action == "f" and enemy_action == "d"):
	# 	print("It defended against nothing.")
	# elif (player_action == "d" and enemy_action == "f"):
	# 	print("You defended against nothing.")
	# else:
	# 	print("Nothing happens...")

	var player_attack = 0

	if player_action == "a":
		#TODO: check for attack buffs

	
	#var player_damage = damage_hp(player_stats)
		
	if player_stats.hp <=0:
		battle_done = true
		print("Player has been defeated!")
	elif enemy_stats.hp <=0:
		battle_done = true
		print("Enemy has been defeated!")
	
# ACTIONS
func run_away(run_stat):
	if (rng.is_run_successful(run_stat)):
		print("You ran away!")
		round_done = true
		battle_done = true
	else:
		print("You tried to run, but failed!")
		var enemy_action = rng.decide_action(enemy_rngs[0])
		get_outcome("f", enemy_action, enemy_rngs[0])
		round_done = true
		print(player_stats, enemy_rngs[0])			

#pure numbers here?
func damage_hp(stats, defend, attack, attack_buff = 0, defense_buff = 0):
	var hp_loss = attack + attack_buff - defend - defense_buff
	if (hp_loss < 0):
		hp_loss = 0
	stats.hp -= hp_loss

#TODO: add a rounds for damage over time
func do_DOT(player_stats, enemy_rngs):
	for key in DOT_player.keys():
		var damage =  DOT_player[key]
		print("Player taking damage from " + key + "for" + damage)
		player_stats.hp -= damage

	for enemy in DOT_enemies:
		#individual enemy
		var id = enemy.id
		for key in enemy.keys():
			if (key != "id"): 
				var damage = enemy[key]
				var name = enemy_rngs[id].name
				print ("Enemy "+name + "taking damage from" + key + "for" + damage)
				enemy_rngs[id].hp -= damage





		

#TODO: this will probably also be mapped to buttons 	
func _input(event):
	if event.is_action_pressed("ui_accept") && round_done == true && battle_done == false:
		round_done = false
		do_round()
	elif event.is_action_pressed("run_away") && round_done == true && battle_done == false:
		run_away(player_stats.run)

# check continually for win/lose condition
#func _process(delta):

			

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

