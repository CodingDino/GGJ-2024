extends Node

signal health_depleted
signal health_changed

@export var health = 10
@export var death_anim_name = "Death"
@export var death_anim_node = "../AnimatedSprite2D"
@export var remove_on_death = "../"
@export var score_on_death = 100

var anim = null
var to_remove_on_death = null
var max_health

func _ready():
	max_health = health
	if death_anim_node != "":
		anim = get_node(death_anim_node)
	if remove_on_death != "":
		to_remove_on_death = get_node(remove_on_death)

func is_alive():
	return health > 0

func heal(amount):
	var health_will_change = false
	if (max_health > health):
		health_will_change = true
	health += amount
	if health > max_health :
		health = max_health
	if health_will_change:
		health_changed.emit()
	
func take_damage(damage):
	if health <= 0:
		health = 0
		return
		
	health -= damage
	if health <= 0:
		health = 0
		health_depleted.emit()
		
		to_remove_on_death = get_node_or_null (remove_on_death)
		if score_on_death > 0:
			var score_display = get_tree().current_scene.get_node("CanvasLayer/Score")
			score_display.add_score(score_on_death)
		if death_anim_name != "":
			anim = get_node(death_anim_node)
			anim.play(death_anim_name)
		if to_remove_on_death != null:
			if anim != null:
				await anim.animation_finished
				to_remove_on_death.queue_free()
			else :
				to_remove_on_death.queue_free()
				
	health_changed.emit()
