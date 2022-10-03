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
