extends Node


const WIN_CONDITION = 3
const NUM_LOOT = 8
export var MAX_STAMINA = 25

onready var player = $YSort/Player
onready var bats = $YSort/Bats

var hidden_loot_scene = preload("res://Scenes/HiddenLoot.tscn")
var wood = preload("res://Scenes/Wood.tscn")

var grass_range = Vector2(rand_range(80, 336), rand_range(50, 178))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    randomize()
    _spawn_hidden_loot()
    player.set_stamina(MAX_STAMINA)
    _setup_bats()

func _setup_bats() -> void:
    var num_bats : int = bats.get_child_count()
    
    var boss_bat : Node = get_node("YSort/Bats/Bat" + str(randi() % num_bats))
    var boss_bat_sprite = boss_bat.get_node("Sprites/EnemySprite")
    boss_bat_sprite.apply_scale(Vector2(3,3))
    boss_bat_sprite.modulate = Color(0.862745, 0.0784314, 0.235294, 1)
    boss_bat.get_node("BatBodyCollision").apply_scale(Vector2(3,3))
    boss_bat.get_node("Hurtbox").queue_free()

func _create_hidden_loot() -> void:
    var loot = hidden_loot_scene.instance()
    add_child(loot)
    loot.set_position(grass_range)
    loot.add_to_group("loot")
    
    var wood_piece = wood.instance()
    wood_piece.z_index = -1
    wood_piece.disable_light_radius()
    loot.add_child(wood_piece)
    
    print("Loot added at: ", loot.global_position)

func _spawn_hidden_loot() -> void:
    for n in NUM_LOOT:
        _create_hidden_loot()
