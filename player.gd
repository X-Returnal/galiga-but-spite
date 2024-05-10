extends CharacterBody2D
# player stats
var health = 5

# movement stats
var speedmult = .02
const SPEED = 800.0

var bonk = false

# weapon stats
@export
var Bullet: PackedScene
var fire_speed:float = 250
@export
var burst_mode = false #modifer for bullets per shot // adds a small delay
@export
var burst_speed = 80
@export
var bullets_per_shot = 1
@export
var bullet_spread:float = 0.1
# detects holding down click 
var refire:bool = false

var progress:float = 101

@export
var reset_progress = 185 #what progress is set to when letting go of click

var invultime:int = 120

var burst_clip = bullets_per_shot 

func _physics_process(delta):
	invultime -= 1
	fireloop(Input.is_action_pressed("click"),delta)
	
	
	
	if Input.is_action_just_pressed("f10"):
		$collision.disabled = !$collision.disabled
	
	
	
	# movement code
	if true:
		var direction = get_viewport().get_mouse_position() - position
		
		if bonk:
			speedmult = 0.02
		
		
		if speedmult < 10:
			speedmult += .02
		velocity = direction * speedmult
		
		bonk = move_and_slide()
func fireloop(clickstate, delta):
	if clickstate:
		progress += fire_speed*delta
		if progress > 100:
			var pellets = bullets_per_shot
			
			while pellets >0 and !burst_mode:
				pellets-=1 
				fire()
				refire = true
				progress = 0
			if burst_mode:
				fire()
				if burst_clip > 0:
					burst_clip -= 1
					progress = burst_speed
				else:
					burst_clip = bullets_per_shot
					progress = 0
	else:
		progress = reset_progress
		refire = false
func fire():
	var bullet = Bullet.instantiate()
	bullet.bullet_team = 1
	
	owner.add_child(bullet)
	var deviation_angle = PI * bullet_spread
	bullet.transform = $barrel.global_transform
	if refire:
	
		bullet.rotation += randf_range(-deviation_angle, deviation_angle)
func damage(amount):
	if invultime > 0:
		return false
	else:
		health -= amount
		invultime = 5
		return true
