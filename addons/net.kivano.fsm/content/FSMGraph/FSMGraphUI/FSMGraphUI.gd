tool
extends Control

################################### R E A D M E ##################################
# 
#
#

##################################################################################
#########                     Imported classes/scenes                    #########
##################################################################################
const GraphNodeScript = preload("../GraphNode/GraphNode.gd");

##################################################################################
#########                       Signals definitions                      #########
##################################################################################
signal openScriptRequest(inFsmNode);
signal selectNodeRequest(inFsmNode);
##################################################################################
#####  Variables (Constants, Export Variables, Node Vars, Normal variables)  #####
######################### var myvar setget myvar_set,myvar_get ###################
onready var newElementBtn = get_node("NewElementBtn");
onready var fileChooserUI = get_node("transitionScriptChooseDialog");

var graph;
var fsmRef;

var lastCreateRequestFromGraphNode;

##################################################################################
#########                          Init code                             #########
##################################################################################
func _notification(what):
	if (what == NOTIFICATION_INSTANCED):
		graph = get_node("FSMGraph");
	elif(what == NOTIFICATION_READY):
		set_process_input(true)
		pass
#		get_node("initSetup").play("default");
#		graph.set_

func manualInit(inFsm):
	fsmRef = weakref(inFsm);
	graph.manualInit(inFsm);

func _input(event):
	if(event.type==InputEvent.MOUSE_BUTTON):
		if(event.global_pos.y<get_global_pos().y):
			if(event.global_pos.x<(get_rect().size).x):
				hide(); #user probably want to click '2d/3d/Script/AssetLib'
		elif((event.global_pos.x>get_rect().size.x) && (event.global_pos.x>get_viewport().get_visible_rect().size.x*0.95)):
			hide(); #quite possible he is clicking on script icon in scene tree
		

##################################################################################
#########                       Getters and Setters                      #########
##################################################################################

##################################################################################
#########              Should be implemented in inheritanced             #########
##################################################################################

##################################################################################
#########                    Implemented from ancestor                   #########
##################################################################################

##################################################################################
#########                       Connected Signals                        #########
##################################################################################
func _on_FSMGraph_openScriptRequest( inFsmNode ):
	emit_signal("openScriptRequest", inFsmNode)

func _on_NewElementBtn_stateCreateRequest( inStateName ):
	if(lastCreateRequestFromGraphNode!=null):
		graph.createStateGraphAndFSMNodeAndConnect2(inStateName, newElementBtn.get_global_pos(),lastCreateRequestFromGraphNode);
	else:
		graph.createStateGraphAndFSMNode(inStateName, newElementBtn.get_global_pos(),lastCreateRequestFromGraphNode);

var prevTransitionNameCreateRequest = "";
func _on_NewElementBtn_transitionCreateRequest( inTransitionName, inCreateScript):
	if(!fsmRef.get_ref()):
		get_parent().hide();
		return;
	var fsm = fsmRef.get_ref();
	
	prevTransitionNameCreateRequest = inTransitionName;
	if(inCreateScript):
		graph.createTransitionGraphAndFSMNodeAndConnect2(inTransitionName, newElementBtn.get_global_pos(), lastCreateRequestFromGraphNode, null);
	else:
		var dirPath = fsm.get_owner().get_filename().get_base_dir() + "/" + fsm.additionalSubDirectory4FSMData;
		fileChooserUI.set_current_dir(dirPath);
		get_node("transitionScriptChooseDialog").popup_centered_ratio();

func _on_transitionScriptChooseDialog_file_selected( scriptPath ):
	graph.createTransitionGraphAndFSMNodeAndConnect2(prevTransitionNameCreateRequest, newElementBtn.get_global_pos(), lastCreateRequestFromGraphNode, scriptPath);

func _on_FSMGraph_arrowDragFinishedAtEmptySpace( inFromGraphNode, inAtPos ):
	lastCreateRequestFromGraphNode = inFromGraphNode;
	if(inFromGraphNode.outputConnectionType == GraphNodeScript.TYPE_TRANSITION):
		showAddNewTransitionUI(inAtPos);
	elif(inFromGraphNode.outputConnectionType == GraphNodeScript.TYPE_STATE):
		showAddNewStateUI(inAtPos);
	
func _on_btnNewState_pressed():
	lastCreateRequestFromGraphNode = null;
	showAddNewStateUI(newElementBtn.get_global_pos());

func _on_btnHelp_pressed():
	if(get_node("HelpText").is_visible()):
		get_node("HelpText").hide();
	else:
		get_node("HelpText").show();


func _on_close_pressed():
	hide();

##################################################################################
#########     Methods fired because of events (usually via Groups interface)  ####
##################################################################################

##################################################################################
#########                         Public Methods                         #########
##################################################################################
func refresh():
	graph.refresh();

func save():
	graph.saveAdditionalData();
#	graph.toolSave2Dict()

######
### UI stuff
func showAddNewStateUI(inAtPos):
	newElementBtn.appear4StateAtPos(inAtPos)

func showAddNewTransitionUI(inAtPos):
	newElementBtn.appear4TransitionAtPos(inAtPos)

##################################################################################
#########                         Inner Methods                          #########
##################################################################################

##################################################################################
#########                         Inner Classes                          #########
##################################################################################
func _on_btnRefresh_pressed():
	if(!fsmRef.get_ref()):
		get_parent().hide();
		return;
	var fsm = fsmRef.get_ref();
#	get_node("initSetup").play("default");
	if(fsm!=null):
		graph.clearGraphNodes();
		graph.manualInit(fsm);

func _on_FSMGraphUI_resized():
	pass

func _on_FSMGraph_selectNodeRequest( inFsmNode ):
	emit_signal("selectNodeRequest", inFsmNode);






