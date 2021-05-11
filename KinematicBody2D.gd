extends KinematicBody2D


export var speed := 1000
export var jump_speed := -1600
export var jump_wall_speed := 10
export var gravity := 3000
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var velocity := Vector2.ZERO

var extra_jump:bool
var last_wall:KinematicCollision2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	calculate_walk_direction()
	calculate_gravity()
	if is_on_floor():
		calculate_jump()
	elif is_on_wall():
		calculate_wall_jump()
	elif extra_jump:
		calculate_jump()
	move_and_slide(velocity,Vector2.UP)

func calculate_wall_jump():
	if Input.is_action_just_pressed("jump"):
		var current_wall:KinematicCollision2D
		if get_slide_count()>0:
			current_wall = get_slide_collision(0) # primer objeto colisionando, debe ser la pared
			if last_wall and (current_wall.position.x - last_wall.position.x) == 0:
				last_wall = null
				return
			var direction:Vector2 = (position - current_wall.position).normalized()
			velocity.x = jump_wall_speed * direction.x
			velocity.y= jump_speed
			last_wall = current_wall

func calculate_jump():
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
		extra_jump = not extra_jump

func calculate_gravity(var reduce_factor:int = 1):
	velocity.y += (gravity/reduce_factor) * get_physics_process_delta_time()

func calculate_walk_direction():
	var direction := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if direction != 0:
		velocity.x =  lerp(velocity.x,direction * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x,0,friction)
