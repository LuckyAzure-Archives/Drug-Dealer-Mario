extends Node2D

func _process(delta):
	mayro(delta)
	if Input.is_action_just_pressed("ui_accept"):
		Fade.next_scene("MadnessCutscene0")

var animcount = 0

func mayro(delta):
	animcount += 1 * delta
	$Torso/LeftArm.rotation_degrees = sin(animcount) * 5
	$Torso/RightArm.rotation_degrees = -sin(animcount) * 5
	$Torso/Head.position.y = -54 - (sin(animcount) * 5)
