extends Camera2D

#position, angle, zoom, screenshake
var pos = [Vector2(0,0),0,0.5,Vector2(0,0)]
var scr = [Vector2(),0,0,Vector2(0,0)]
var spd = [10,10,10,10]

var camlock = false

func _ready():
	if get_tree().get_current_scene().get_node("Mario"):
		var mario_pos = get_tree().get_current_scene().get_node("Mario").position
		scr[0] = mario_pos
		scr[2] = 0.5

func _process(delta):
	#position = get_tree().get_current_scene().get_node("Mario").position
	for i in scr.size():
		scr[i] = lerp(scr[i],pos[i],delta * spd[i])
	if get_tree().get_current_scene().get_node("Mario"):
		if !camlock:
			var mario_pos = get_tree().get_current_scene().get_node("Mario").position
			mario_pos.y -= 15
			pos[0] = mario_pos
	position = scr[0] + Vector2(rand_range(-scr[3].x,scr[3].x),rand_range(-scr[3].y,scr[3].y))
	rotation_degrees = scr[1]
	zoom = Vector2(scr[2],scr[2])
