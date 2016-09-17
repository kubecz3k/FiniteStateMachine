extends Node;

var logicRoot;
var fsm;

func stateInit(inParam1=null,inParam2=null,inParam3=null,inParam4=null, inParam5=null): pass
func enter(fromState=null): pass
func update(deltaTime, param1=null,param2=null,param3=null,param4=null): pass
func exit(toState=null): pass

func computeNextState():
	return self.get_name()

