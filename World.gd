extends CharacterBody2D

@onready var _animation_player = $PlayerMoveAnimation

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _enter_tree():
	set_multiplayer_authority(str(name).to_int())

func _ready():
	if not is_multiplayer_authority(): return

func _unhandled_input(event):
	if not is_multiplayer_authority(): return
	
func _process(delta):
	if Input.is_action_pressed("ui_right"):
		_animation_player.play("run_right")
	elif Input.is_action_pressed("ui_left"):
		_animation_player.play("run_left")
	elif Input.is_action_pressed("ui_up"):
		_animation_player.play("run_up")
	elif Input.is_action_pressed("ui_down"):
		_animation_player.play("run_down")
	else:
		_animation_player.stop()

	move_and_slide()
	
func _physics_process(delta):
	if not is_multiplayer_authority(): return
	# Get the player's input.
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# Normalize the input vector. This ensures that the character moves at the same speed in all directions.
	input = input.normalized()
	# Set the character's velocity based on the input.
	velocity = input * SPEED
	# Move the character.
	var _collision = move_and_slide()
	#move_and_collide(velocity * delta)
	#if _collision:
	#	print("I collided with ", _collision.get_collider().name)

