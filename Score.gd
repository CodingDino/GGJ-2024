extends Label

var score = 0

func _ready():
	self.text = str(score)

func add_score(to_add):
	score += to_add
	self.text = str(score)
