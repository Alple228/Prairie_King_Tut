extends CharacterBody2D

var speed : int
var screen_size : Vector2

func _ready():
	screen_size = get_viewport_rect().size
	# since screen_size is a vector, this places the player in the middle of the x and y axes
	position = screen_size / 2
	speed = 200
	print("Screen size:", screen_size, "\nPlayer position:", position)

func get_input(): 
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed
	

func _physics_function(_delta):
	# player movement
	get_input()
	move_and_slide()
	
	# limit movement to window size
	position = position.clamp(Vector2.ZERO, screen_size)
	
	# player rotation
	var mouse = get_local_mouse_position()
	var angle = snappedf(mouse.angle(), PI / 4) / (PI / 4)
	angle = wrapi(int(angle), 0, 8)
	
	$AnimatedSprite2D.animation = "walk" + str(angle)
	
	if velocity.length() != 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 1
		
