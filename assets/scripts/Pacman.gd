extends KinematicBody2D

onready var Grid  = get_parent()

var velocity:Vector2
var speed = 2.5
var type = GLOBALS.ENTITY_TYPES.PLAYER
var off = Vector2(0.5,0.5)

func _ready():
	position = GLOBALS.PAC_START_POS
	pass

func _process(delta):
	
	
	var targ =  Grid.calculate_next_position(self)
	
	
	#print(gird[0])
	#print(position)
	#print(velocity)
	velocity = (targ - position)
	
	var mult = speed / delta 
	#print(position)
	#print(velocity)
	if velocity.x < 0:
		velocity.x = -mult
	elif velocity.x > 0:
		velocity.x = mult
	if velocity.y < 0:
		velocity.y = -mult
	elif velocity.y > 0:
		velocity.y = mult
	#print(velocity)
	position += velocity * delta




	
	


