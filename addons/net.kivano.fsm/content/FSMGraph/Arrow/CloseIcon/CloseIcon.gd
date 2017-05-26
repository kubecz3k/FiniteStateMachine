tool
extends Node2D
signal onCloseBtnClicked;

onready var animator = get_node("Animator")
onready var visual = get_node("Button");
func _ready():
	visual.set_opacity(0)


func _on_Area2D_input_event( viewport, event, shape_idx ):
	if(event.type==InputEvent.MOUSE_BUTTON):
		queue_free();

func _on_Button_mouse_enter():
	if(get_parent().getTargetNode()==null):return;
	visual.set_opacity(1);
	animator.queue("appear");

func _on_Button_mouse_exit():
	if(get_parent().getTargetNode()==null):return;
	visual.set_opacity(0);
	animator.queue("dissapear");

func _on_Button_pressed():
	if(get_parent().getTargetNode()==null):return;
	emit_signal("onCloseBtnClicked");
