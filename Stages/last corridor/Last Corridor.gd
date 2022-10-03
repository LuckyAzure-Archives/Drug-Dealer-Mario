extends Node2D

func _ready():
	$Mario.lock = true
	$Camera2D.camlock = true
	$Camera2D.pos[0].x = 240
	$Camera2D.pos[0].y = 135
	$Camera2D.scr[2] = 0.5
	$Camera2D.scr[0].x = 240
	$Camera2D.scr[0].y = 135

func _process(delta):
	debugtext()
	var color = 1.3 - (abs($Mario.position.x - 240) / 240)
	$Mario/Animations.modulate = Color(color,color,color)
	var color2 = 1.3 - (abs($Sans.position.x - 240) / 240)
	$Sans.modulate = Color(color2,color2,color2)
	intro(delta)
	


func debugtext():
	$CanvasLayer/Label.text = str(Engine.get_frames_per_second())
	$CanvasLayer/Label.text += "\nis_on_floor: " + str($Mario.is_on_floor())
	$CanvasLayer/Label.text += "\n" + "jumping: " + str($Mario.jumping)
	$CanvasLayer/Label.text += "\n" + "jumphold: " + str($Mario.jumphold)
	$CanvasLayer/Label.text += "\n" + "velocity.y: " + str($Mario.velocity.y)
	$CanvasLayer/Label.text += "\n" + "velocity.x: " + str($Mario.velocity.x)
	$CanvasLayer/Label.text += "\n" + "animtimer: " + str(animtimer)

var animtimer = 0
var animtimer2 = 0

func intro(delta):
	if animtimer < 15.6 and Input.is_action_just_pressed("ui_accept"):
		animtimer = 15.6
		animtimer2 = 15.5 - (1 * delta)
		$Music.play(15.5)
	animtimer += 1 * delta
	if animtimer > 0.01 and animtimer2 < 0.01:
		$HUD.cinemamode = true
		animtimer2 = 0.01
		$Camera2D.pos[0].x = 360
		$Camera2D.pos[0].y = 210
		$Camera2D.pos[2] = 0.2
		$Camera2D.spd[0] = 0.5
		$Camera2D.spd[2] = 0.5
	if animtimer > 8.5 and animtimer2 < 8.5:
		animtimer2 = 8.5
		ScreenShake("",10)
	if animtimer > 10.5 and animtimer2 < 10.5:
		animtimer2 = 10.5
		ScreenShake("",10)
	if animtimer > 12.5 and animtimer2 < 12.5:
		animtimer2 = 12.5
		ScreenShake("",10)
	if animtimer > 14.5 and animtimer2 < 14.5:
		animtimer2 = 14.5
		ScreenShake("",10)
	if animtimer > 15.5 and animtimer2 < 15.5:
		animtimer2 = 15.5
		$Mario.lock = false
		$Camera2D.pos[0].x = 240
		$Camera2D.pos[0].y = 135
		$Camera2D.pos[2] = 0.5
		$Camera2D.spd[0] = 5
		$Camera2D.spd[2] = 5
		$HUD.cinemamode = false

func ScreenShake(type,value):
	$Camera2D.scr[3] = Vector2(value,value)
	match type:
		"Bone":
			Sound.playsound("res://Sounds/snd_impact_ch1.wav")
			$Camera2D.scr[3] = Vector2(value,value)
