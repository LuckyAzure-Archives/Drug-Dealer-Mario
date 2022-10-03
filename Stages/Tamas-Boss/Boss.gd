extends Node2D

func _process(delta):
	$CanvasLayer/Label.text = str(Engine.get_frames_per_second())
	$CanvasLayer/Label.text += "\nis_on_floor: " + str($Mario.is_on_floor())
	$CanvasLayer/Label.text += "\n" + "jumping: " + str($Mario.jumping)
	$CanvasLayer/Label.text += "\n" + "jumphold: " + str($Mario.jumphold)
	$CanvasLayer/Label.text += "\n" + "velocity.y: " + str($Mario.velocity.y)
	$CanvasLayer/Label.text += "\n" + "velocity.x: " + str($Mario.velocity.x)
	$CanvasLayer/Label.text += "\n" + "is_on_wall: " + str($Mario.is_on_wall())
	$CanvasLayer/Label.text += "\n" + "is_on_floor: " + str($Mario.is_on_floor())
	var pos = $Mario.position
	$Camera2D.pos[0].x = 480 + (pos.x - 480) * 0.2
	$Camera2D.pos[0].y = 0 + (pos.y - 0) * 0.2

func _ready():
	$Music.play(22)
	$Mario.lock = false
	$Camera2D.camlock = true
	$Camera2D.pos[2] = 1
	$Camera2D.pos[0].x = 480
	$Camera2D.pos[0].y = 135
	$Camera2D.scr[2] = 2
	$Camera2D.scr[0].x = 480
	$Camera2D.scr[0].y = 400
