extends KinematicBody2D


var velocity := Vector2.ZERO
export var speed := 1000
export var speed_jump := -1000
export var gravity := 1000
var extra_jump:bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	calculate_walk_direction()
	if not is_on_wall():
		calculate_gravity()
	else:
		velocity.y = 0
	if is_on_floor() or extra_jump or is_on_wall():
		calculate_jump()
	move_and_slide(velocity,Vector2.UP)

func calculate_jump():
	if Input.is_action_just_pressed("jump"):
		velocity.y = speed_jump
		extra_jump = not extra_jump

func calculate_gravity():
	velocity.y += gravity * get_physics_process_delta_time()

func calculate_walk_direction():
	var direction := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * 1000
