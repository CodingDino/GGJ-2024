extends RigidBody3D


@export var explosion_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(_body):
	
	# TODO: hurt enemy
	
	# spawn explosion
	var explosion = explosion_scene.instantiate()
	explosion.position = self.global_position
	explosion.emitting = true
	get_tree().current_scene.add_child(explosion)
	
	# delete bullet
	queue_free()
	pass
