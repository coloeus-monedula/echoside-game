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

func _ready() -> void:
	rng = Rng_script.new()





#TODO: this will probably also be mapped to buttons 	
func _input(event):
	if event.is_action_pressed("ui_accept") && round_done == true && battle_done == false:
		round_done = false
	elif event.is_action_pressed("run_away") && round_done == true && battle_done == false:
		round_done = false # Run away code

# check continually for win/lose condition
#func _process(delta):

