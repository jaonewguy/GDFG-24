extends Node2D


const L1_TIME_LEFT : int = 19

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var level_timer = $UI/LevelTimer/Timer
onready var level_timer_label = $UI/LevelTimer/TimeLeftLabel

# Time left in stage
var time_left = L1_TIME_LEFT


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    time_left -= delta
    level_timer_label.text = str(time_left)
