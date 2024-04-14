class_name MagicStaff

extends Weapon

@onready var firing_component = $FiringComponent
@onready var spawn_point = $Visuals/Shaft/Head/SpawnPoint



# Called when the node enters the scene tree for the first time.
func _ready():
	max_ammo_pool = sheet.max_ammo_pool
	max_current_ammo = sheet.magazine_size
	rate_of_fire = sheet.rate_of_fire
	current_ammo = max_current_ammo
	ammo_pool = max_ammo_pool
	trigger = firing_component
	muzzle = spawn_point
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	_check_status()
	
	if recoil_time > 0:
		recoil_time -= delta
	

func pull_trigger():
	
	# checks recoil time to see if rate of fire has been resolved
	if recoil_time <= 0:
		
		#checks to make sure there is ammo to shoot		
		if current_ammo > 0:
			
			trigger.fire(muzzle)
			
			current_ammo -= 1
			recoil_time = rate_of_fire
			
		else:
			#if no ammo it warns that recharge is necessary
			print("out of ammo")
	
	else:
		#warns about rate of fire
		print("This weapon doesn't shoot that fast!")

func recharge(mana_value):
	
	current_ammo = mana_value
		
