extends "res://addons/net.kivano.fsm/content/FSMState.gd";
################################### R E A D M E ##################################
# For more informations check script attached to FSM node
#
#

##################################################################################
#####  Variables (Constants, Export Variables, Node Vars, Normal variables)  #####
######################### var myvar setget myvar_set,myvar_get ###################
#if you are using 'Transitions Hardcoded inside States' you will usually want to cache next state
var nextStateID; 

##################################################################################
#########                       Getters and Setters                      #########
##################################################################################
#you will want to use those
func getFSM(): return fsm; #defined in parent class
func getLogicRoot(): return logicRoot; #defined in parent class 

##################################################################################
#########                    Implemented from ancestor                   #########
##################################################################################
#you can transmit parameters if fsm is initialized manually
func stateInit(inParam1=null,inParam2=null,inParam3=null,inParam4=null, inParam5=null): 
	pass

#when entering state, usually you will want to reset internal state here somehow
func enter(fromStateID=null):
	nextStateID = get_name();

#when updating state, paramx can be used only if updating fsm manually
func update(deltaTime, param1=null, param2=null, param3=null, param4=null):
	pass

#when exiting state
func exit(toState=null):
	pass

# If fsm.transitionsHardcodedInStates is true, then this is right place to implement
# transition logic. Simply return next state id, and fsm will automatically change state.
func computeNextState():
	return nextStateID;

##################################################################################
#########                       Connected Signals                        #########
##################################################################################

##################################################################################
#########     Methods fired because of events (usually via Groups interface)  ####
##################################################################################

##################################################################################
#########                         Public Methods                         #########
##################################################################################

##################################################################################
#########                         Inner Methods                          #########
##################################################################################

##################################################################################
#########                         Inner Classes                          #########
##################################################################################
