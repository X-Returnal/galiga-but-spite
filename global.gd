extends Node
@export
var friendlyfire = -1
@export
var current_score = 0
@export
var current_time = -1
@export
var map = -1
var level_score = 0
var cleared_floors = 0
var on_run = false

func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
#var gameover = preload("res://scenes/end_screen.tscn")

#func _process(_delta):
	#if on_run:
		#if current_time < 0:
			#end_run()
		#current_time -= 1

#func start_run():
	#current_score = 0
	#current_time = 30000
	#cleared_floors = 0
	#on_run = true
	#map = 0
	#get_tree().change_scene_to_file("res://scenes/lvl_0.tscn")

#func end_run():
	#on_run = false
	#map = -1
	##get_tree().change_scene_to_packed(gameover)
