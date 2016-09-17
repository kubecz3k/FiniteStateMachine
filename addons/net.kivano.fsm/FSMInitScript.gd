tool
extends EditorPlugin

func _enter_tree():
	# Initialization of the plugin goes here
	# First load the dock scene and instance it:
	
	# Add the loaded scene to the docks:
	add_custom_type("FSM (Finite state machine)","Node",preload("content/fsm.gd"),preload("icon.png"))
    
	
    # Note that LEFT_UL means the left of the editor, upper-left dock
func _exit_tree():
    # Clean-up of the plugin goes here
    # Remove the scene from the docks:
    remove_custom_type("FSM (Finite state machine)")
