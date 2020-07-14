extends KinematicBody
 
const MOVE_SPEED = 3
const TURN_SPEED = 160
const GRAVITY = 98
const MAX_FALL_SPEED = 30
 
var y_velo = 0
var grounded = false
var flashlight = true 

func _physics_process(delta):
	var move_dir = 0
	var turn_dir = 0
	var speed_modifier = 1 #default speed modifier. It should be only changed upon a button press
	
	if Input.is_action_pressed("movement_forward"):
		move_dir += 1
	if Input.is_action_pressed("movement_backward"):
		move_dir -= 1
	if Input.is_action_pressed("movement_right"):
		turn_dir -= 1
	if Input.is_action_pressed("movement_left"):
		turn_dir += 1
	if Input.is_action_pressed("run_modifier"):
		# it would be probably appropriate to change the animation to "run" here when we get the models
		speed_modifier = 3 #changing the value of speed modifier to allow for run when the key is pressed and hold.
	if Input.is_action_just_released("run_modifier"):
		speed_modifier = 1 #run modifier key is released. Speed returns to normal
	if Input.is_action_pressed("turn_around"):
		#have to figure that one out
		pass
	if Input.is_action_just_pressed("flashlight_toggle"):
		if flashlight == true:
			get_node("SpotLight").light_energy = 0
			get_node("SpotLight2").light_energy = 0
			flashlight = false
		elif flashlight == false:
			get_node("SpotLight").light_energy = 6
			get_node("SpotLight2").light_energy = 4
			flashlight = true
	
	rotation_degrees.y += turn_dir * (TURN_SPEED+(40)*speed_modifier) * delta #allowing for faster rotation when running
	var move_vec = global_transform.basis.z * (MOVE_SPEED+speed_modifier) * move_dir 
	move_vec.y = y_velo
	move_and_slide(move_vec, Vector3(0, 1, 0))
   
	var was_grounded = grounded
	grounded = is_on_floor()
	y_velo -= GRAVITY * delta
	if grounded:
		y_velo = -0.1
	if y_velo < -MAX_FALL_SPEED:
		y_velo = -MAX_FALL_SPEED
