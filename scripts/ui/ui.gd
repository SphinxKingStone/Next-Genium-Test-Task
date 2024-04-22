extends CanvasLayer

@onready var hp_label = %HPLabel as Label
@onready var keys_label = %KeysLabel as Label
@onready var text_label = %TextLabel as Label
@onready var text_timer = $TextTimer as Timer

func  _ready() -> void:
	update_keys_label(0)
	update_hp_label(Player.hp, Player.max_hp)
	text_timer.timeout.connect(self._text_timer_timeout)

func update_keys_label(amount: int) -> void:
	keys_label.text = "Keys: %d" % amount

func update_hp_label(hp: int, max_hp: int) -> void:
	hp_label.text = "HP %d/%d" % [hp, max_hp]

func new_interactive_text(text: String) -> void:
	text_label.visible = true
	text_label.text = text
	text_timer.start(2)

func _text_timer_timeout() -> void:
	text_label.visible = false

func _on_button_pressed() -> void:
	get_tree().quit()

func death() -> void:
	$ColorRect.show()
