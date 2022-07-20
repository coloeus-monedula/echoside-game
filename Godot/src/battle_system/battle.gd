extends Node2D
#list of enemies that can be encountered in a place
var enemy_array: Array

var enemy_stats = {}
const Rng_script = preload("res://src/battle_system/rng.gd")
var rng: Rng_script
var round_done: bool = false
var battle_done: bool = false

var DOT_player = {
}
#name: [counter, amount]
var DOT_enemies = []
#[{id:1, #name: [counter, amount]}, {id: 2...} ]

#TODO: should be imported from player state
var player_stats = {
	"attack": 12,
	"defend": 12,
	"falter": 12,
	"hp": 3,
	"run": 40,
	"attack_cards": {
		"basic": {
			"type": "attack"
		}
	},
	"defend_cards": {},
	"fumble_cards": {}
}
#card is structured like so:
#name: {type:, }

func _ready() -> void:
	rng = Rng_script.new()



func start_battle(enemy: Array) -> void:	
	self.enemy_array = enemy
	rng.choose_enemy(enemy_array, enemy_stats)
	print("Press enter to start or f to run")
	round_done = true

	
func do_round() -> void:
	var player_action = rng.decide_action(player_stats)
	#TODO: CHANGE SO THIS ISNT HARDCODED
	var enemy_action = rng.decide_action(enemy_stats[0])
	
	if (player_action == "a"):
		print("You're set up for an attack!")
	elif (player_action == "d"):
		print("You're set up to defend!")
	else:
		#if ERROR returned, auto falter
		player_action = "f"
		print("You fumbled your set up this time...")
		
	print("The ", enemy_stats[0].name, " is: ")
	if (enemy_action == "a"):
		print("Attacking!")
	elif (enemy_action == "d"):
		print("Defending!")
	else:
		enemy_action = "f"
		print("Fumbling...")
		
	
	get_outcome(player_action, enemy_action, enemy_stats[0])
	round_done = true
	print(player_stats, enemy_stats[0])
			

func get_outcome(player_action, enemy_action, enemy_stats) -> void:
	var player_card = {}
	var enemy_card = {}
	
	if (player_action == "a" and enemy_action == "a"):
		player_card = choose_card(player_stats.attack_cards, true)
		enemy_card = choose_card(enemy_stats.attack_cards)

	elif (player_action == "a" and enemy_action == "d"):
		player_card = choose_card(player_stats.attack_cards, true)
		enemy_card = choose_card(enemy_stats.defend_cards)

	elif (player_action == "d" and enemy_action == "a"):
		player_card = choose_card(player_stats.defend_cards, true)
		enemy_card = choose_card(enemy_stats.attack_cards)

	elif (player_action == "d" and enemy_action == "d"):
		player_card = choose_card(player_stats.defend_cards, true)
		enemy_card = choose_card(enemy_stats.defend_cards)

	elif (player_action == "f" and enemy_action == "a"):
		player_card = choose_card(player_stats.fumble_cards, true)
		enemy_card = choose_card(enemy_stats.attack_cards)
	
	elif (player_action == "a" and enemy_action == "f"):
		player_card = choose_card(player_stats.attack_cards, true)
		enemy_card = choose_card(enemy_stats.fumble_cards)
	
	elif (player_action == "f" and enemy_action == "d"):
		player_card = choose_card(player_stats.fumble_cards, true)
		enemy_card = choose_card(enemy_stats.fumble_cards)

	elif (player_action == "d" and enemy_action == "f"):
		player_card = choose_card(player_stats.defend_cards, true)
		enemy_card = choose_card(enemy_stats.fumble_cards)


	else: 
		print("Nothing happens... This is an error and shouldn't occur.")
	
	#var player_damage = damage_hp(player_stats)
		
	if player_stats.hp <=0:
		battle_done = true
		print("Player has been defeated!")
	elif enemy_stats.hp <=0:
		battle_done = true
		print("Enemy has been defeated!")
	
# ACTIONS
func run_away(run_stat) -> void:
	if (rng.is_run_successful(run_stat)):
		print("You ran away!")
		round_done = true
		battle_done = true
	else:
		print("You tried to run, but failed!")
		var enemy_action = rng.decide_action(enemy_stats[0])
		get_outcome("f", enemy_action, enemy_stats[0])
		round_done = true
		print(player_stats, enemy_stats[0])			

#pure numbers here?
func damage_hp(stats, defend, attack, attack_buff = 0, defense_buff = 0):
	var hp_loss = attack + attack_buff - defend - defense_buff
	if (hp_loss < 0):
		hp_loss = 0
	stats.hp -= hp_loss

func choose_card(cards, isPlayer=false):
	print("")


func do_DOT(player_stats, enemy_stats):
	for key in DOT_player.keys():
		#only affects if counter is above 0
		var counter = DOT_player[key][0]
		if (counter > 0):
			var damage =  DOT_player[key][1]
			print("Player taking damage from " + key + "for" + damage)
			player_stats.hp -= damage
			#take 1 from counter
			DOT_player[key][0] -= 1

	for enemy in DOT_enemies:
		#individual enemy 
		var id = enemy.id
		for key in enemy.keys():
			if (key != "id"): 
				var counter = DOT_player[key][0]
				if (counter > 0):
					var damage = enemy[key][1]
					var name = enemy_stats[id].name
					print ("Enemy "+name + "taking damage from" + key + "for" + damage)
					enemy_stats[id].hp -= damage
					DOT_player[key][0] -= 1
					


		

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

