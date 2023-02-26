extends KinematicBody2D

var lock = false
const normalspeed = 150
const runspeed = 350
var inairspeed = 300
const jumpstrength = 300

var friction = 10
var acceleration = 10
const gravity = 1000

var Ability = "Medium"
var Animations = "Idle"

func _ready():
	$Animations.scale.x = -1

func _process(delta):
	get_input(delta)
	movement(delta)
	animation(delta)

func animation(delta):
	$Animations.get_node(Ability).animation = Animations
	if Ability == "Small":
		$SmallHitbox.disabled = false
		$MediumHitbox.disabled = true
	else:
		$SmallHitbox.disabled = true
		$MediumHitbox.disabled = false

func get_input(delta):
	Move.x = 0
	if !lock:
		if Input.is_action_pressed("Left"):
			Move.x = -1
		if Input.is_action_pressed("Right"):
			Move.x = 1
		running = Input.is_action_pressed("Run")
	else:
		running = false

#Movement's Variables
var velocity = Vector2.ZERO
var jumphold = 0
var jumping : bool
var running : bool
var Move : Vector2
var falling = false
var runmeter = 0
var speed = 0
var rspeed = 0

func movement(delta):
	$Skiddust.emitting = false
	if is_on_floor():
		speed = normalspeed
		friction = 20
		acceleration = 10
		if running:
			friction = 10
			speed = runspeed
		if abs(velocity.x) > normalspeed:
			rspeed = abs(velocity.x)
		else:
			rspeed = normalspeed
		if velocity.x > 0:
			$Animations.scale.x = -1
		if velocity.x < 0:
			$Animations.scale.x = 1
	

	
	if not is_on_floor():
		friction = 5
		acceleration = 5
		speed = rspeed
		if velocity.y < 0:
			Animations = "Jump"
		elif velocity.y > 0:
			Animations = "Fall"
		if $Skid.playing:
			$Skid.stop()
	elif abs(velocity.x) > 50 and not is_on_wall():
		$Animations.get_node(Ability).speed_scale = abs(velocity.x) * 0.0025
		if running and abs(velocity.x) > 145:
			friction = 5
			acceleration = 2
		else:
			friction = 10
		if abs(velocity.x) > 300:
			Animations = "Run"
		else:
			Animations = "Walk"
		if running and velocity.x > 0 and Move.x == -1:
			acceleration = 2
			$Skiddust.position.x = -4
			Animations = "Skidding"
			$Skiddust.emitting = true
			if !$Skid.playing:
				$Skid.play()
		elif running and velocity.x < 0 and Move.x == 1:
			acceleration = 2
			$Skiddust.position.x = 4
			$Skiddust.emitting = true
			Animations = "Skidding"
			if !$Skid.playing:
				$Skid.play()
		else:
			if $Skid.playing:
				$Skid.stop()
	else:
		if $Skid.playing:
			$Skid.stop()
		Animations = "Idle"
	
	Move = Move.normalized() * speed
	
	if not Move.x == 0:
		velocity.x = lerp(velocity.x, Move.x, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0, friction * delta)
	
	if not is_on_floor():
		if !falling:
			falling = true
			if velocity.y > 0:
				velocity.y = 0
		if velocity.y < 400:
			velocity.y += gravity * delta
		else:
			velocity.y = 400
	else:
		if falling:
			falling = false
		if Move.x != 0:
			velocity.y = 100
		elif velocity.x == 0:
			velocity.y = 0
	
	
	var jumpstr = -(jumpstrength + (abs(velocity.x) / 10))
	if Input.is_action_just_pressed("Jump") and !lock and is_on_floor():
		$Jump.play()
		velocity.y = jumpstr
		jumphold = 10 + (abs(velocity.x) * 0.01)
	if jumphold > 0 and Input.is_action_pressed("Jump") and !lock:
		velocity.y = jumpstr / 1.25
		jumphold -= 1 * (delta / 0.025)
	else:
		jumphold = 0
	
	if is_on_ceiling():
		jumping = false
		velocity.y = 10
	
	if is_on_wall() and abs(velocity.x) > 100:
		velocity.x = 0
	
	velocity.x = int(velocity.x)
	velocity.y = int(velocity.y)
	
	move_and_slide(velocity, Vector2.UP)
