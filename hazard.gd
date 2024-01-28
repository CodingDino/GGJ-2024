extends Area3D

signal damage_dealt(target, damage)

@export var damage = 1
@export var targetGroup = "Player"
@export var damageFreq = 0.5
@export var autoDamage = true
@export var damageSound: EventAsset

var collidingWith = []
var lastDamaged = []


func deal_damage() :
	for i in collidingWith.size():
		if Time.get_ticks_usec() > lastDamaged[i] + damageFreq * 1000000:
			if collidingWith[i] != null :
				lastDamaged[i] = Time.get_ticks_usec()
				damage_dealt.emit(collidingWith[i], damage)
				collidingWith[i].take_damage(damage)
				FMODRuntime.play_one_shot_attached(damageSound, self)


func _physics_process(_delta):
	# deal damage automatically if we are supposed to
	if autoDamage:
		deal_damage()


func _on_body_entered(body):
	if body.is_in_group(targetGroup) and body.get_node_or_null("Health") :
		collidingWith.append(body.get_node("Health"))
		lastDamaged.append(0)
		print(body.name)


func _on_body_exited(body):
	if body.get_node_or_null("Health") :
		var loc = collidingWith.find(body.get_node("Health"))
		if loc >= 0 :
			collidingWith.remove_at(loc)
			lastDamaged.remove_at(loc)
