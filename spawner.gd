extends Marker2D


@export
var unit_spawn:PackedScene

@export_range(3, 10, 1, "or_greater")
var unit_value:int

@export_range(.5, 100,0.001, "or_greater")
var unit_health:float

@export
var unit_shoot = false

@export_range(-1, 10, 1, "or_greater")
var limit_spawn:int = 3
@export
var progress_speed:float = 15

var progress:float = 0

var spawned:int = 0



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawned < limit_spawn or limit_spawn < 0:
		progress += progress_speed*delta
		if progress > 100:
			spawnunit()
			spawned+=1
			progress = 0

func spawnunit():
	var unit = unit_spawn.instantiate()
	owner.add_child(unit)
	unit.transform = global_transform
	unit.mob_value = unit_value
	unit.health = unit_health
	unit.has_weapon = unit_shoot
