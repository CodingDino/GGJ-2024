extends ProgressBar

@onready var health = $"../../Player/Health"

func _process(_delta):
	value = health.health * 100 / health.max_health
