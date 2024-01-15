//Creates a task using BIS task framework based on MissionType global variable
params ["_selectedLoc","_locIndex","_missionType"];

//***DEBUG
diag_log format ["** CreateTask params: %1, %2, %3",_selectedLoc, _locIndex, _missionType];

//marker and logic object name for this location
_locationName = format["selectedLocation%1",_locIndex];

//***DEBUG
diag_log _locationName;

//get logic object to save vars to
_logicObject = missionNamespace getVariable _locationName;

//task name
_taskName = format ["task%1", _locIndex];

//***DEBUG
diag_log format ["* Taskname = %1",_taskName];

//allow spawning
sleep 5;

//if mission is clear area
switch (_missionType) do 
{
	case 0: {//purge mission
		//***DEBUG
		diag_log "Purge selected. Part 1";
	
	
		[west, _taskName, [
			format ["We've received information on strange happenings in %1. POG HQ has tasked us with going in and clearing the area before clean-up teams come in.", text _selectedLoc],
			format ["Purge %1 of Anomalies", text _selectedLoc], 
			_locationName], 
			getMarkerPos _locationName, 
			"AUTOASSIGNED"] call BIS_fnc_taskCreate;
		
		//***DEBUG
		diag_log format["Purge selected. Part 2, task object is in state %1", _taskName call BIS_fnc_taskState];
		
		//create trigger to check when area is cleared
		_taskTrigger = createTrigger ["EmptyDetector", getMarkerPos _locationName];
		_taskTrigger setTriggerArea [NearRadius, NearRadius, 0, false];
		_taskTrigger setTriggerActivation ["EAST", "NOT PRESENT", true];
		private _trigStatement1 = format ["count (units east inAreaArray '%1') == 0",_locationName];
		private _trigStatement2 = format ["LastLocation = getPos %1; ['%2', 'SUCCEEDED'] call BIS_fnc_taskSetState; CompletedLocations = CompletedLocations + 1; publicVariable 'CompletedLocations';",_logicObject,_taskName];		
		_taskTrigger setTriggerStatements [
			_trigStatement1, 
			_trigStatement2, 
			""
		];
		
		//***DEBUG
		diag_log format["Purge selected. Part 3, task object is in state %1", _taskName call BIS_fnc_taskState];
		
		//create briefing information
		//TODO***
		//add HQ calls
		//TODO***
	
	};
	case 1: { //find item missison
		//***DEBUG
		diag_log "Find item selected. Part 1";
	
		//select item from list
		private _retrieveItem = selectRandom RetrieveItems;
		
		//get spawn location, preferred buildings
		private _newPos = [locationPosition _selectedLoc, 0, NearRadius/3, 1] call BIS_fnc_findSafePos;
		
		//get building spawns from logic object
		_buildingSpawns = _logicObject getVariable "_buildingSpawns";
		
		if (count _buildingSpawns > 0) then {
			_newPos = selectRandom _buildingSpawns;
		};
		//if position is on ground, make 3d position
		if(count _newPos == 2) then {
			_newPos = [_newPos select 0, _newPos select 1, 0];
		};
		
		//spawn item in AO & glow effect
		_retrieveObject = _retrieveItem createVehicle _newPos;
		_retrieveObject enableSimulationGlobal false;
		//RetrieveObject setPos [getPos RetrieveObject select 0, getPos RetrieveObject select 1, (getPos RetrieveObject select 2)+0.3];
		_retrieveObject setPos [_newPos select 0, _newPos select 1, (_newPos select 2) + 0.1];
		"Chemlight_green" createVehicle getPos _retrieveObject;
		//_chemlight enableSimulationGlobal false;
		//publicVariable "RetrieveObject";
		
		//assign RetrieveObject to logic object
		_logicObject setVariable ["_retrieveObject", _retrieveObject];
		
		//***DEBUG
		diag_log "Find item selected. Part 2";
		
		//get the center of the item marker
		private _offsetPos = [_newPos, NearRadius/3, 1] call BIS_fnc_findSafePos;
		
		//define dynamic marker name
		_retrieveMarker = format["retrieveLocation%1", _locIndex];
		
		_areaMarker = createMarker["_retrieveMarker", _offsetPos];
		_areaMarker setMarkerShape "ELLIPSE";
		_areaMarker setMarkerSize [NearRadius/3,NearRadius/3];
		_areaMarker setMarkerColor "ColorBlue";
		_areaMarker setMarkerAlpha 0.5;
		_areaMarker setMarkerBrush "DIAGGRID";
		/*
		//DEBUG***
		_debugMarker = createMarker["task", _newPos];
		_debugMarker setMarkerType "hd_dot";
		_debugMarker setMarkerColor "ColorBlue";
		*/
		
		//object preview image
		private _itemPhoto = getText (configfile >> "CfgVehicles" >> typeOf _retrieveObject >> "editorPreview");
		_taskString = format ["%1",formatText [format ["<img image='%1'/>", _itemPhoto]]];
		
		//***DEBUG
		diag_log "Find item selected. Part 3";
		
		//create task
		[west, _taskName, [
			format ["Find the %1 near %2. We think it may contain vital intel on this anomoly. We've marked its last known position on your map in blue and you can see what it looks like below: %3",getText (configFile >> "cfgVehicles" >> typeOf _retrieveObject >> "displayName"),text _selectedLoc, _taskString], 
			format ["Recover the %1", getText (configFile >> "cfgVehicles" >> typeOf _retrieveObject >> "displayName")], 
			_locationName], 
			getMarkerPos _locationName, 
			"AUTOASSIGNED"] call BIS_fnc_taskCreate;
		
		//create action to pick up item
		fnc_grabObject = {
			params ["_retrieveObject"];
			_retrieveObject addaction ["** Pick Up **",
				{params ["_target"]; deleteVehicle _target;},
				nil, 1.5, true, true, "", "true",3]
		};
		publicVariable "fnc_grabObject";
		
		//add addaction to all players
		//[fnc_grabObject] remoteExec ["call",0,true];
		[_retrieveObject] remoteExec ["fnc_grabObject",0,true];
			
		//***DEBUG
		diag_log "Find item selected. Part 4";	
			
		//create a task trigger
		//create trigger to check when item no longer exists
		_taskTrigger = createTrigger ["EmptyDetector", getMarkerPos _locationName];
		//_taskTrigger setTriggerArea [NearRadius, NearRadius, 0, false];
		//_taskTrigger setTriggerActivation ["EAST", "NOT PRESENT", true];
		private _trigStatement1 = format ["isNull (%1 getVariable '_retrieveObject')",_logicObject];
		private _trigStatement2 = format ["LastLocation = getPos %1; ['%2', 'SUCCEEDED'] call BIS_fnc_taskSetState; CompletedLocations = CompletedLocations + 1; publicVariable 'CompletedLocations';",_logicObject,_taskName];
		
		_taskTrigger setTriggerStatements [
			_trigStatement1, 
			_trigStatement2,
			""
		];
		
		//***DEBUG
		diag_log format["Find item selected. Part 5, task object is in state %1", _taskName call BIS_fnc_taskState];
	};
	case 2: {//destroy object
		//select item from list
		private _destroyItem = selectRandom DestroyItems;
		
		//get spawn location near center
		private _newPos = [locationPosition _selectedLoc, 0, NearRadius/3, 1] call BIS_fnc_findSafePos;
		
		//spawn item in AO & glow effect
		_destroyObject = _destroyItem createVehicle _newPos;
		//DestroyObject setPos [getPos DestroyObject select 0, getPos DestroyObject select 1, getPos DestroyObject select 2];
		"Chemlight_green" createVehicle getPos _destroyObject;
		//publicVariable "DestroyObject";
		
		//assign DestoryObject to logic object
		_logicObject setVariable ["_destroyObject", _destroyObject];
		
		private _offsetPos = [_newPos, NearRadius/3, 1] call BIS_fnc_findSafePos;
		
		//define dynamic marker name
		_destroyMarker = format["destroyLocation%1", _locIndex];
		
		_areaMarker = createMarker[_destroyMarker, _offsetPos];
		_areaMarker setMarkerShape "ELLIPSE";
		_areaMarker setMarkerSize [NearRadius/3,NearRadius/3];
		_areaMarker setMarkerColor "ColorBlue";
		_areaMarker setMarkerAlpha 0.5;
		_areaMarker setMarkerBrush "DIAGGRID";
		/*
		//DEBUG***
		_debugMarker = createMarker["task", _newPos];
		_debugMarker setMarkerType "hd_dot";
		_debugMarker setMarkerColor "ColorBlue";
		*/
		
		//object preview image
		private _itemPhoto = getText (configfile >> "CfgVehicles" >> typeOf _destroyObject >> "editorPreview");
		_taskString = format ["%1",formatText [format ["<img image='%1'/>", _itemPhoto]]];
		
		//create task
		[west, _taskName, [
			format ["We must destroy the %1 near %2. It seems to be the source of this anomaly. We've marked its last known position on your map in blue and you can see what it looks like below: %3",getText (configFile >> "cfgVehicles" >> typeOf _destroyObject >> "displayName"),text _selectedLoc, _taskString], 
			format ["Destroy the %1", getText (configFile >> "cfgVehicles" >> typeOf _destroyObject >> "displayName")], 
			_locationName], 
			getMarkerPos _locationName, 
			"AUTOASSIGNED"] call BIS_fnc_taskCreate;
		
		//create action execute when destroyed
		fnc_blowObject = {
			params ["_destroyObject"];
			_loc = getPos _destroyObject; 
			_grp = createGroup civilian; 
			_fire = _grp createUnit ["ModuleEffectsFire_F", _loc, [], 0, "NONE"]; 
			_fire setVariable ["ColorRed",0.5,true];  
			_fire setVariable ["ColorGreen",0.5,true];  
			_fire setVariable ["ColorBlue",0.5,true];  
			_fire setVariable ["Timeout",0,true]; 
			_fire setVariable ["ParticleLifeTime",3,true]; 
			_fire setVariable ["ParticleDensity",30,true];  
			_fire setVariable ["ParticleSize",2,true];  
			_fire setVariable ["ParticleSpeed",1.5,true];  
			_fire setVariable ["EffectSize",2,true];  
			_fire setVariable ["ParticleOrientation",0,true];  
			_fire setVariable ["FireDamage",2,true]; 
			deleteVehicle _destroyObject;
		};
		
		//create a task trigger
		//create trigger to check when item no longer exists
		_taskTrigger = createTrigger ["EmptyDetector", getPos _destroyObject];
		_taskTrigger setTriggerArea [10, 10, 0, false];
		_taskTrigger setTriggerActivation ["EAST", "PRESENT", false];
		_taskTrigger setTriggerStatements [
			format ["({_x inArea thisTrigger} count allMissionObjects '#explosion' > 0) or {isNull (%1 getVariable '_destroyObject')}",_logicObject],
			format ["LastLocation = getPos %1; [(%1 getVariable '_destroyObject')] call fnc_blowObject;['%2', 'SUCCEEDED'] call BIS_fnc_taskSetState; CompletedLocations = CompletedLocations + 1; publicVariable 'CompletedLocations';",_logicObject, _taskName],
			""];
		
		{_x inArea thisTrigger} count allMissionObjects "#explosion" > 0

	};
};


//***TODO for multi-task refactor

/*
//create trigger to collapse far enemies to center when players arrive
_collapseTrigger = createTrigger ["EmptyDetector", getMarkerPos "selectedLocation"];
_collapseTrigger setTriggerArea [NearRadius/2, NearRadius/2, 0, false];
_collapseTrigger setTriggerActivation ["WEST","PRESENT",false];
_collapseTrigger setTriggerStatements ["this", "execVM 'farEnemiesCollapse.sqf'", ""];

//create trigger to force enemies to chase players after a certain threshold have been defeated
_chaseTrigger = createTrigger ["EmptyDetector", getMarkerPos "selectedLocation"];
_chaseTrigger setTriggerStatements ["count units east < (TotalSpawned * ChaseRatio)", "execVM 'allEnemiesChase.sqf'", ""];

//create trigger to generate exfil task
_finishTrigger = createTrigger ["EmptyDetector", getMarkerPos "selectedLocation"];
_finishTrigger setTriggerStatements ["'task1' call BIS_fnc_taskCompleted", "[west, 'taskFinal', ['Time to get the hell out of here...','EXFIL','selectedLocation'],getMarkerPos 'mainBase','AUTOASSIGNED'] call BIS_fnc_taskCreate;", ""];

//create trigger to complete task
_exfilTrigger = createTrigger ["EmptyDetector", getMarkerPos "selectedLocation"];
_exfilTrigger setTriggerArea [600, 600, 0, false];
_exfilTrigger setTriggerActivation ["WEST","NOT PRESENT",true];
_exfilTrigger setTriggerStatements [
	"this && ('task1' call BIS_fnc_taskCompleted)",
	"['taskFinal', 'SUCCEEDED'] call BIS_fnc_taskSetState;",
	""];

//create endGame trigger (MP safe)***
_endTrigger = createTrigger ["EmptyDetector", getMarkerPos "mainBase"];
_endTrigger setTriggerStatements [
	"'taskFinal' call BIS_fnc_taskCompleted",
	"[] remoteExec ['BIS_fnc_endMission', 0, true];", 
	""];
_endTrigger setTriggerTimeout [5, 5, 5,false];
*/