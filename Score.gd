extends Label

var score = 0
@export var toHeal = 5

@onready var player = $"../../Player"

func _ready():
	self.text = str(score)

func add_score(to_add):
	score += to_add
	Global.score = score
	player.get_node("Health").heal(toHeal)
	self.text = str(score)
