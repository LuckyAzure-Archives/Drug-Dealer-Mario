extends CanvasLayer

var pos = [0]
var scr = [1]

func _ready():
	reset()

func reset():
	nextscene = false
	pos[0] = 0
	scr[0] = 1

func _process(delta):
	for i in scr.size():
		scr[i] = lerp(scr[i],pos[i],delta * 2)
	$Black.modulate = Color(1,1,1,scr[0])
	_fade()

var scenedata
var nextscene = false

func next_scene(data):
	nextscene = true
	pos[0] = 1
	match data:
		"Menu":
			pass
		"Test-Stage":
			scenedata = "res://Stages/Test Stage.tscn"
		"Last-Corridor":
			scenedata = "res://Stages/last corridor/Last Corridor.tscn"
		"MadnessCutscene0":
			scenedata = "res://Cutscenes/CutsceneMadness0/Cutscene.tscn"

func _fade():
	if scr[0] > 0.99 and nextscene:
		reset()
		get_tree().change_scene(scenedata)
