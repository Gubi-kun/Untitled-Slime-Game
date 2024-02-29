extends CharacterBody2D

# Declare variables
var speed = Vector2(0,0)
var gravity = 800
var jump_force = -400
var is_on_ground = false
var move_speed = 100  # Adjust the move speed as needed
var change_direction_timer = 0
var time_to_change_direction = 1.5  # Adjust the time to change direction as needed

var move_timer = Timer.new()  # Timer for controlling movement
var min_move_time = 1.0
var max_move_time = 3.0

@onready var tilemap = TileMap

# Called when the node enters the scene tree for the first time
func _ready():
	move_timer.wait_time = randf_range(min_move_time, max_move_time)
	add_child(move_timer)
	move_timer.start()
	
# Called every frame
func _process(delta):
	# Apply gravity
	velocity.y += gravity * delta

	# Apply random side-to-side movement
	change_direction_timer -= delta
	if change_direction_timer <= 0:
		velocity.x = randf_range(-1, 1) * move_speed
		change_direction_timer = time_to_change_direction

	# Apply movement
	if is_on_ground and Input.is_action_pressed("ui_up"):
		velocity.y = jump_force
	move_and_slide()
	
func limit_to_platform():
	var position_on_tilemap = tilemap.world_to_map(global_position)
	var tile_id = tilemap.get_cell(position_on_tilemap.x, position_on_tilemap.y)

	if tile_id == -1:  # No tile (empty space), stop the character
		velocity.x = 0
	
# Called when the body enters the ground
func _on_Floor_area_entered(area):
	is_on_ground = true

# Called when the body exits the ground
func _on_Floor_area_exited(area):
	is_on_ground = false

# Called when the move_timer times out
func _change_direction():
	velocity.x = randf_range(-1, 1) * 200  # Adjust the speed as needed
	move_timer.wait_time = randf_range(min_move_time, max_move_time)
	move_timer.start()
