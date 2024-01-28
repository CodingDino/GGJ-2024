extends ProgressBar

@onready var health = $"../../Player/Health"

func _process(delta):
	value = health.health * 100 / health.max_health
