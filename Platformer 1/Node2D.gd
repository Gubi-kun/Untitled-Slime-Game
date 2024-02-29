extends Node2D
@export var soft_body: SoftBody2D = null

const SPEED = 5.0
const JUMP_VELOCITY = 7.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 250



func _physics_process(delta):
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		soft_body.apply_impulse(Vector2.UP * JUMP_VELOCITY)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		soft_body.apply_force(Vector2.RIGHT * SPEED * direction)
	
#	if 
