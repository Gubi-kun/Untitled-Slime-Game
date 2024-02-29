extends CharacterBody2D

var gravity = 550 
# Called when the node enters the scene tree for the first time.

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
