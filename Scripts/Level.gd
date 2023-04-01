extends Node


export var MAX_STAMINA = 20

onready var player = $YSort/Player
onready var bats = $YSort/Bats

var picked_up_wood: int = 0
var hidden_loot_scene = preload("res://Scenes/HiddenLoot.tscn")
var wood = preload("res://Scenes/Wood.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    randomize()
    SignalBus.connect("wood_pickup", self, "_on_wood_pickup")
    _spawn_hidden_loot()
    player.set_stamina(MAX_STAMINA)
    _setup_bats()
    
func _setup_bats() -> void:
    var num_bats : int = bats.get_child_count()
    var boss_bat : Node = get_node("YSort/Bats/Bat" + str(randi() % num_bats))
    boss_bat.get_node("Sprites/EnemySprite").apply_scale(Vector2(3,3))
    boss_bat.get_node("BatBodyCollision").apply_scale(Vector2(3,3))
    

func _on_wood_pickup() -> void:
    picked_up_wood += 1
    print(picked_up_wood)

func _spawn_hidden_loot() -> void:
    var loot = hidden_loot_scene.instance()
    
    add_child(loot)
    loot.set_position(Vector2(rand_range(80, 50), rand_range(336, 178)))
    loot.add_to_group("loot")
    
    # TODO: prob need to refactor this when considering other loot
    var wood_piece = wood.instance()
    loot.add_child(wood_piece)
    print("Loot added at: ", loot.global_position)
