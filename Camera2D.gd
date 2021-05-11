extends Camera2D

export var target_path:NodePath
var target

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node_or_null(target_path)
	set_process(target != null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = target.position.x
	position.y = target.position.y - 400
