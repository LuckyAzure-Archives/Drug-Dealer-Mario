extends KinematicBody2D

var speed = 0

func _process(delta):
	speed += 800 * delta
	position.x -= speed * delta
	rotation_degrees -= speed * delta
	if speed > 700:
		$Sprite.play()
	if $Sprite.frame == 7 and $Sprite.animation == "default":
		$Sprite.animation = "New Anim"
		$Sprite.play()
	if position.x < 0:
		queue_free()
		if get_tree().get_current_scene().has_method("ScreenShake"):
			get_tree().get_current_scene().ScreenShake("Bone",10)
