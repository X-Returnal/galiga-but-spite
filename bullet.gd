extends Node2D

@export
#makes bullet go fast
var bullet_speed:int = 750
@export
var bullet_damage:int = 1
#makes that guy go ow
@export 
var bullet_pierce:int = 0
#prevents loss of bullet damage
@export
var bullet_team:int = 0
#set bullet's collison -1: bad 0: neutrial (dmg all) 1: player 1 2: player 2

var bullet = Node2D.new()
func _ready():
	add_child(bullet, true)

func _physics_process(delta):
	# move dat thang
	position += transform.x * bullet_speed * delta


func _on_area_2d_body_entered(body):
	if body.is_in_group("mobs"):
		var yes_kill = false
		if (bullet_team != -1):
			yes_kill = true
		if (global.friendlyfire > 1):
			yes_kill = true
			
		if yes_kill:
			body.damage(bullet_damage)
			if bullet_pierce > 0:
				bullet_pierce -= 1
			else:
				bullet_damage -= body.health
			if bullet_damage <0:
				queue_free()
	if body.is_in_group("player"):
		#check alignments
		if bullet_team < 1 or global.friendlyfire > 0:
			body.damage(bullet_damage)
			if bullet_pierce > 0:
				bullet_pierce -= 1
			else:
				bullet_damage -= body.health
			if bullet_damage <0:
				queue_free()
	if body.is_in_group("walls"):
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	await get_tree().create_timer(5).timeout
	queue_free()
