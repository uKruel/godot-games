extends Node

#onready var mainPlayerNode = get_node("PlayerObj/PlayerKB2D").canPlant
var asphalt_left = 50
var asphalt_message = "Asphalt: "
var canPlant = true
var score = 0


var nextBrickSprite = [("res://images/pixil-frame-0 (1).png"),"res://images/pixil-frame-2.png",("res://images/pixil-frame-0.png")]
onready var nextBrickTexture = null

onready var main_camera = find_node("Camera2D")

func present_next_brick(brickNum):
	if nextBrickTexture == null:
		nextBrickTexture = find_node("NextBrickTexture")
	nextBrickTexture.texture = load(nextBrickSprite[brickNum-1])

func point_obj_form(isRandom:bool,whatObj:String,coordX:float,coordY:float):
	var target_point_scene = null
	var target_point_obj = null
	if whatObj == "target":
		target_point_scene = load("res://Target_Point_01.tscn")
		target_point_obj = target_point_scene.instance()
	elif whatObj == "house_obstacle":
		target_point_scene = load("res://Costly_Obstacle_01.tscn")
		target_point_obj = target_point_scene.instance()
	elif whatObj == "bonus_asphalt":
		target_point_scene = load("res://Bonus_Asphalt_01.tscn")
		target_point_obj = target_point_scene.instance()
	
	if isRandom == true:
		var rand_p = RandomNumberGenerator.new()
		rand_p.randomize()
		var x_pos = rand_p.randf_range(-100,250)
		rand_p.randomize()
		var y_pos = rand_p.randf_range(-100,250)
		target_point_obj.position.x = x_pos
		target_point_obj.position.y = y_pos
		add_child(target_point_obj)
		
		
	
func generate_target_points(how_many_points):
	for _i in range(1,how_many_points):
		#point_obj_form(true,"target",0,0)
		point_obj_form(true,"house_obstacle",0,0)
		point_obj_form(true,"bonus_asphalt",0,0)
		
	
# Called when the node enters the scene tree for the first time.
func start():
	asphalt_left = 500
	score = 0
	$GameText.text = asphalt_message+str(asphalt_left)
	generate_target_points(4)

func _ready():
	start() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("reload_scene"):
		get_tree().reload_current_scene()
