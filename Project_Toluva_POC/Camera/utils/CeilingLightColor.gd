extends "res://CeilingLight.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var red_color = .65
var blue_color = .25
var color1 = Color( red_color, 0.16, blue_color, 1 )
var time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta #time elapsed in ms since delta is in ms
	red_color = .75+(cos(time)/8)
	blue_color = .25+(sin(time)/8)
		

	#print("red ", red_color)
	#print("blue ", blue_color)
	
	color1 = Color( red_color, 0.16, blue_color, 1 )
	light_color = color1
