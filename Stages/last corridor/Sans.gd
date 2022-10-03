extends Position2D

var Animations = "Idle"
var dodge = false
var dodge2 = 0
var dodgedir = false
var animtimer = 0

var missobj = preload("res://Stages/last corridor/Miss.tscn")

func _process(delta):
	animtimer += 75 * delta
	var dcol = 0.75 + (sin(animtimer) * 0.25)
	$Dodge.modulate = Color(dcol,dcol,dcol,dcol)
	$DodgeParticle.scale.x = scale.x 
	if get_tree().get_current_scene().get_node("Mario"):
		if get_tree().get_current_scene().get_node("Mario").position.x > position.x:
			scale.x = -0.4
		else:
			scale.x = 0.4
	Animations(delta)
	if dodge:
		Dodge(delta)
	else:
		$DodgeParticle.emitting = false

func Animations(delta):
	$Idle.visible = false
	$Dodge.visible = false
	$Attack1.visible = false
	get_node(Animations).visible = true

func _on_Area2D_body_entered(body):
	if body.get_name().to_lower() == "mario" and dodge == false and Animations == "Idle":
		var miss = missobj.instance()
		add_child(miss)
		miss.position.y -= 120
		$Miss.emitting = true
		body.velocity.x = body.velocity.x * 0.5
		if position.x > 320:
			dodgedir = false
		elif position.x < 120:
			dodgedir = true
		else:
			if rand_range(0,10) >= 5:
				dodgedir = true
			else:
				dodgedir = false
		dodge = true
		$Dodging.play()
		dodge2 = 50

func Dodge(delta):
	Animations = "Dodge"
	dodge2 -= 100 * delta
	if dodge2 > 10:
		$DodgeParticle.emitting = true
	else:
		$DodgeParticle.emitting = false
	if dodgedir:
		position.x += dodge2 * 12 * delta
	else:
		position.x -= dodge2 * 12 * delta
	if dodge2 <= 0:
		dodge = false
		Animations = "Idle"
