extends Node3D
@onready var spawns = $RoomGeometry/SpawnerParent
@onready var navigation_region = $RoomGeometry/NavigationRegion3D

var enemy = load("res://enemy.tscn")
var instance 

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _get_random_child(parent_node):
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id)


func _on_spawn_timer_timeout():
	var spawn_point = _get_random_child(spawns).global_position
	instance = enemy.instantiate()
	instance.position = spawn_point
	navigation_region.add_child(instance)
