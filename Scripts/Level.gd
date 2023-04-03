extends Node


const WIN_CONDITION = 3
export var MAX_STAMINA = 30

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
    var boss_bat_sprite = boss_bat.get_node("Sprites/EnemySprite")
    boss_bat_sprite.apply_scale(Vector2(3,3))
    boss_bat_sprite.modulate = Color(0.862745, 0.0784314, 0.235294, 1)
    boss_bat.get_node("BatBodyCollision").apply_scale(Vector2(3,3))
    boss_bat.get_node("Hurtbox").queue_free()
    

func _on_wood_pickup() -> void:
    print("Wood picked up")
    picked_up_wood += 1
    if picked_up_wood == 3:
        SignalBus.emit_signal("game_won")

func _spawn_hidden_loot() -> void:
    var loot = hidden_loot_scene.instance()
    var loot2 = hidden_loot_scene.instance()
    
    add_child(loot)
    loot.set_position(Vector2(rand_range(80, 336), rand_range(50, 178)))
    loot.add_to_group("loot")
    
    add_child(loot2)
    loot2.set_position(Vector2(rand_range(80, 336), rand_range(50, 178)))
    loot2.add_to_group("loot")
    
    # TODO: prob need to refactor this when considering other loot, and get rid of duplication
    var wood_piece = wood.instance()
    var wood_piece2 = wood.instance()
#    wood_piece.hide()
#    wood_piece2.hide()
    loot.add_child(wood_piece)
    loot2.add_child(wood_piece2)
    print("Loot added at: ", loot.global_position)
    print("Loot2 added at: ", loot2.global_position)
