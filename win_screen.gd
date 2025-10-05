extends CanvasLayer

@onready var confetti1 = $Confetti
@onready var confetti2 = $Confetti2
@onready var sparkles = $Sparkles

func _ready():
	get_viewport().connect("size_changed", Callable(self, "_on_window_resized"))
	center_particles()
	
func _on_window_resized():
	center_particles()

func center_particles():
	var size = get_viewport().get_visible_rect().size
	var particleOffset = Vector2(200, 0)
	confetti1.position = (size / 2) - particleOffset
	confetti2.position = (size / 2) + particleOffset
	sparkles.position = size/2
	sparkles.emission_rect_extents = size*2
 
