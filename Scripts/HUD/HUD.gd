extends CanvasLayer

var cinemamode = false
var tempcinemamode = false
var scr = [0,0,0]
var pos = [1,0,0]
var spd = [10,5,10]

func _ready():
	scr[1] = 96

func _process(delta):
	for i in scr.size():
		scr[i] = lerp(scr[i],pos[i],delta * spd[i])
	if cinemamode != tempcinemamode:
		if cinemamode:
			pos[0] = 0
			pos[1] = 96
		else:
			pos[0] = 1
			pos[1] = 0
		tempcinemamode = cinemamode
	$Hud0.modulate = Color(1,1,1,scr[0])
	$UpBar.rect_position.y = -96 + scr[1]
	$DownBar.rect_position.y = 541 - scr[1]
	if Input.is_action_just_pressed("Down"):
		cinemamode = false
	if Input.is_action_just_pressed("Up"):
		cinemamode = true
