extends Node2D

func _ready():
	$CanvasLayer/Fade.show()
	marpos = [Vector2(240, 135),Vector2(1,1),0]
	marscr = [Vector2(240, 135),Vector2(1,1),0]
	$Camera2D.pos[0] = Vector2(240, 135)
	$Camera2D.scr[0] = Vector2(240, 135)
	$Camera2D.pos[2] = 0.75
	$Camera2D.scr[2] = 0.1
	$Camera2D.spd[2] = 0.2

func debugtext():
	$CanvasLayer/Label.text = str(Engine.get_frames_per_second())
	$CanvasLayer/Label.text += "\n" + "animtimer: " + str(animtimer)

var animtimer = 0
var animtimer2 = 0

func _process(delta):
	debugtext()
	animtimer += 1 * delta
	animation1(delta)
	animation2(delta)

var marpos = [Vector2(),Vector2(),0]
var marscr = [Vector2(),Vector2(),0]
var marspd = [10,10,10]

func mariobounce(delta):
	$mariofallin.centered = true
	for i in marscr.size():
		marscr[i] = lerp(marscr[i],marpos[i],delta * marspd[i])
	$mariofallin.position = marscr[0]
	$mariofallin.scale = marscr[1]
	$mariofallin.rotation_degrees = marscr[2]


func animation2(delta):
	if animtimer > 14 and animtimer < 29:
		mariobounce(delta)
		$mariofallin/Glow.modulate.a -= 0.4 * delta
		if $Back0.modulate.v < 1:
			$Back0.modulate.v += 0.4 * delta
		else:
			$Back0.modulate.v = 1
	if animtimer > 14 and animtimer2 < 14:
		$mariofallin/Glow.modulate.a = 1
		$Back0.modulate.v = 0.2
		$mariofallin.centered = false
		$mariofallin.offset.y = -10
		$Facility.hide()
		$Back0.show()
		print($Music.get_playback_position())
		marpos = [Vector2(240, 135),Vector2(1,1),0]
		marscr = [Vector2(240, 135),Vector2(1.5,0.5),0]
		animtimer2 = 14
		ScreenShake("",10)
		$Camera2D.pos[2] = 0.20
		$Camera2D.scr[2] = 0.05
		$Camera2D.spd[2] = 5
		$Camera2D.pos[0] = Vector2(240, 125)
		$Camera2D.scr[0] = Vector2(240, 135)
		$mariofallin.rotation_degrees = 0
		$mariofallin.frame += 1

func animation1(delta):
	if animtimer < 4:
		marpos[2] += 0.5
	if animtimer > 4 and animtimer < 7:
		marpos[2] -= 100 * (animtimer - 4) * delta
		$Camera2D.pos[0] = $mariofallin.position
	if animtimer < 1.8:
		$CanvasLayer/Fade.modulate += Color(0,0,0,-0.001)
	if animtimer > 1.8 and animtimer2 < 3:
		$CanvasLayer/Fade.modulate += Color(0,0,0,-0.002)
	if animtimer > 1.8 and animtimer2 < 1.8:
		animtimer2 = 1.8
		$mariofallin.frame += 1
	if animtimer > 2.8 and animtimer2 < 2.8:
		animtimer2 = 2.8
		ScreenShake("",10)
		$Camera2D.scr[2] += 0.1
		$mariofallin.frame += 1
		$Camera2D.spd[3] = 10
	if animtimer > 4 and animtimer2 < 4:
		animtimer2 = 4
		$mariofallin.frame += 1
	if animtimer > 4.5 and animtimer2 < 4.5:
		animtimer2 = 4.5
		$mariofallin.frame += 1
	if animtimer > 5 and animtimer2 < 5:
		animtimer2 = 5
		$mariofallin.frame += 1
	if animtimer > 6 and animtimer2 < 6:
		animtimer2 = 6
		$Camera2D.pos[2] = 0.1
		$Camera2D.spd[2] = 0.9
		$mariofallin.frame += 1
	if animtimer > 7 and animtimer2 < 7:
		animtimer2 = 7
		$Camera2D.pos[2] = 1.5
		$Camera2D.spd[2] = 0.5
		$mariofallin.frame += 1
	if animtimer > 7.5 and animtimer2 < 7.5:
		animtimer2 = 7.5
		$mariofallin.frame += 1
	if animtimer > 9 and animtimer2 < 9:
		animtimer2 = 9
		$Camera2D.pos[2] = 1.2
		$"Falling Rocks".emitting = false
	if animtimer > 0 and animtimer < 14:
		mariobounce(delta)
		$Camera2D.pos[0] = $mariofallin.position
	if animtimer > 13.8 and animtimer < 14:
		$Facility.position.y -= 30
		$Facility.position.x -= 8
	if animtimer > 6 and animtimer < 14:
		marpos[2] -= 1500 * (6 - animtimer) * delta

func ScreenShake(type,value):
	$Camera2D.scr[3] = Vector2(value,value)
	match type:
		"Bone":
			Sound.playsound("res://Sounds/snd_impact_ch1.wav")
			$Camera2D.scr[3] = Vector2(value,value)
