extends Node2D


const L1_TIME_LEFT : int = 120

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var level_timer = $HUD/LevelTimer/Timer
onready var level_timer_label = $HUD/LevelTimer/TimeLeftLabel
onready var stamina_bar = $HUD/Stamina
onready var start_button = $HUD/StartButton
onready var bgm = $BGM

# Time left in stage
#var time_left = L1_TIME_LEFT

# TODO: Refactor into a Level Loader
var level_one = preload("res://Scenes/Level.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    SignalBus.connect("start_game", self, "_on_start_game")
    level_timer.set_wait_time(L1_TIME_LEFT)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    level_timer_label.text = str(level_timer.get_time_left())
    
func _on_start_game():
    var level = level_one.instance()
    add_child(level)
    level_timer.start()
    bgm.play()

# TODO: Refactor
func _on_StartButton_pressed():
    start_button.hide()
    SignalBus.emit_signal("start_game")
