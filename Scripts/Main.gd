extends Node2D

# Time left in stage
const L1_TIME_LEFT : int = 120
const GAME_OVER_TIMEOUT : int = 3
const NUM_WOOD_TO_WIN : int = 10

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var game_info = $HUD/GameInfo
onready var wood_count = $HUD/WoodCount
onready var level_timer = $HUD/LevelTimer/Timer
onready var level_timer_label = $HUD/LevelTimer/TimeLeftLabel
onready var stamina_bar = $HUD/Stamina
onready var start_button = $HUD/StartButton
onready var bgm = $BGM


var picked_up_wood: int = 0

# TODO: Refactor into a Level Loader
var level_one = preload("res://Scenes/Level.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    SignalBus.connect("wood_pickup", self, "_on_wood_pickup")
    SignalBus.connect("start_game", self, "_on_start_game")
    SignalBus.connect("game_won", self, "_on_game_won")
    SignalBus.connect("game_over", self, "_on_game_over")
    level_timer.set_wait_time(L1_TIME_LEFT)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    level_timer_label.text = str(level_timer.get_time_left())
    
func _on_game_over():
    get_node("Level").queue_free()
    # TODO: Get rid of all this
    game_info.show()
    game_info.text = "Game Over :("
    yield(get_tree().create_timer(GAME_OVER_TIMEOUT), 'timeout')
    get_tree().reload_current_scene()
    
func _on_game_won():
    game_info.show()
    game_info.text = "Game Won! :)"
    get_tree().paused = true
    yield(get_tree().create_timer(GAME_OVER_TIMEOUT), 'timeout')
    get_tree().reload_current_scene()
    
func _on_start_game():
    game_info.hide()
    var level = level_one.instance()
    add_child(level)
    level_timer.start()
    bgm.play()

# TODO: This originally belonged in Level. Move back.
func _on_wood_pickup() -> void:
    print("Wood picked up")
    picked_up_wood += 1
    wood_count.text = str(picked_up_wood)
    if picked_up_wood == NUM_WOOD_TO_WIN:
        SignalBus.emit_signal("game_won")

# TODO: Refactor
func _on_StartButton_pressed():
    start_button.hide()
    SignalBus.emit_signal("start_game")
