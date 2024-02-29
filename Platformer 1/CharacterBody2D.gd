extends CharacterBody2D
@export var curve: Curve = null

const SPEED = 250.0
const JUMP_VELOCITY = -300.0
@onready var starting_position = global_position
@onready var blueberry_pickup = preload("res://bberry_pickup.tscn")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 550 
var jump_count = 2
var last_time_on_floor = 0
var dash_velocity = Vector2(0,0)
var last_dash_time = 0
var dash_duration = 200.0
var dash_speed = 500
var player_health = 100

#func _dash_ease(t):
#	return - t**10+1
	
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor():
		jump_count = 2
		last_time_on_floor = Time.get_ticks_msec()
	var _can_coyotejump = Time.get_ticks_msec() - last_time_on_floor < 2000
		

	if jump_count !=0 and Input.is_action_just_pressed("action_jump"):
		velocity.y = JUMP_VELOCITY
		jump_count -= 1
		print (jump_count)
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("action_dash"):
		last_dash_time = Time.get_ticks_msec()
	var time_since_dash = Time.get_ticks_msec() - last_dash_time
	if time_since_dash < dash_duration:
		velocity+=Vector2(direction_x,direction_y) * dash_speed * curve.sample(time_since_dash/dash_duration)
		print(direction_y)
#		print("dashing")
#		print(curve.sample(time_since_dash/dash_duration))
	if player_health <= 0:
		global_position = starting_position
		player_health = 100
	move_and_slide()


func _on_hitbox_body_entered(body):
	
	print ("entered")
	if velocity.y > 0:
		player_health -= 20
		print(player_health)



func _on_bberry_pickup_2_body_entered(body):
	print("picked up item")
	if player_health < 100:
		player_health += 20
		print(player_health)
		
	if player_health > 100:
		player_health = 100
		print(player_health)
