extends CharacterBody2D
@export
var speed:float = 150  # speed in pixels/sec

@export
var health:float = .5 # how much damage can be taken before being sent to the shadow realm
@export
var fear_factor:int = 30
@export
var mob_value:int = 3
@export
var has_weapon = false # do they have projectiles
@export
var progress_speed:float = 35

var progress:float = 0
@export
var projectile_base:PackedScene = preload("res://bullet.tscn")

@export
var projectile_speed:int = 250

func _ready():
	randomize()
	add_to_group("mobs")
	$shape.num_sides=mob_value
	position += Vector2(randf_range(-25,25),randf_range(-25,25))
func _physics_process(delta):
	if health <0.01:
		global.level_score += mob_value * 100
		queue_free()
	var player = get_closest_player()
	var direction = (player.global_position-global_position).clamp(Vector2(-1,-1),Vector2(1,1))
	look_at(player.position)
	
	
	if randi_range(0,9)==0:
		$collision.disabled = !$collision.disabled

	if get_closest_player().global_position.distance_to(global_position)>200:
		$collision.disabled =true
	
	
	
	if has_weapon:
		progress += progress_speed*delta
		if progress > 100:
			var b = projectile_base.instantiate()
			b.bullet_team =-1
			b.bullet_speed = projectile_speed
			owner.add_child(b)
			b.transform = global_transform
			progress = 0
		
	if player.global_position.distance_to(global_position)< fear_factor:
		direction *= -1
	velocity = direction * speed
	move_and_slide()
	
	
	
	
	
func get_closest_player():
	var players = get_tree().get_nodes_in_group("player")
	#assume first player is closest
	var nearest_player = players[0]

	# look through player to see if any are closer
	for player in players:
		if player.global_position.distance_to(global_position) < nearest_player.global_position.distance_to(global_position):
			nearest_player = player
	return nearest_player
	

func damage(amount):
	health -= amount
	if health <0.01:
		global.level_score += mob_value * 100
		queue_free()


func _on_hitbox_body_entered(body):
	if body.is_in_group("player"):
		var x = body.damage(1)
		print(body.health)
		print(x)
		if has_weapon:
			damage(1)
	
