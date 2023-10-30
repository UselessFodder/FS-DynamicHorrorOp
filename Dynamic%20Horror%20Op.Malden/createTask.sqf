//Creates a task using BIS task framework based on MissionType global variable

//allow spawning
sleep 5;

//if mission is clear area
switch (MissionType) do 
{
	case 0: {//purge mission
	
		[west, "task1", [
			format ["We've received information on strange happenings in %1. POG HQ has tasked us with going in and clearing the area before clean-up teams come in.", text FinalLocation],
			format ["Purge %1 of Anomalies", text FinalLocation], 
			"selectedLocation"], 
			getMarkerPos "selectedLocation", 
			"AUTOASSIGNED"] call BIS_fnc_taskCreate;
		
		//create trigger to check when area is cleared
		_taskTrigger = createTrigger ["EmptyDetector", getMarkerPos "selectedLocation"];
		_taskTrigger setTriggerArea [NearRadius, NearRadius, 0, false];
		_taskTrigger setTriggerActivation ["EAST", "NOT PRESENT", true];
		_taskTrigger setTriggerStatements ["count (units east inAreaArray 'selectedLocation') == 0", "['task1', 'SUCCEEDED'] call BIS_fnc_taskSetState;", ""];
		
		//create briefing information
		//TODO***
		//add HQ calls
		//TODO***
	
	};
	case 1: { //find item missison
		//select item from list
		private _retrieveItem = selectRandom RetrieveItems;
		
		//get spawn location, preferred buildings
		private _newPos = [locationPosition FinalLocation, 0, NearRadius/3, 1] call BIS_fnc_findSafePos;
		if (count BuildingSpawns > 0) then {
			_newPos = selectRandom BuildingSpawns;
		};
		//if position is on ground, make 3d position
		if(count _newPos == 2) then {
			_newPos = [_newPos select 0, _newPos select 1, 0];
		};
		
		//spawn item in AO & glow effect
		RetrieveObject = _retrieveItem createVehicle _newPos;
		RetrieveObject enableSimulationGlobal false;
		//RetrieveObject setPos [getPos RetrieveObject select 0, getPos RetrieveObject select 1, (getPos RetrieveObject select 2)+0.3];
		RetrieveObject setPos [_newPos select 0, _newPos select 1, (_newPos select 2) + 0.1];
		"Chemlight_green" createVehicle getPos RetrieveObject;
		//_chemlight enableSimulationGlobal false;
		publicVariable "RetrieveObject";
		
		private _offsetPos = [_newPos, NearRadius/3, 1] call BIS_fnc_findSafePos;
		_areaMarker = createMarker["retrieveLocation", _offsetPos];
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
		private _itemPhoto = getText (configfile >> "CfgVehicles" >> typeOf RetrieveObject >> "editorPreview");
		_taskString = format ["%1",formatText [format ["<img image='%1'/>", _itemPhoto]]];
		
		//create task
		[west, "task1", [
			format ["Find the %1 near %2. We think it may contain vital intel on this anomoly. We've marked its last known position on your map in blue and you can see what it looks like below: %3",getText (configFile >> "cfgVehicles" >> typeOf RetrieveObject >> "displayName"),text FinalLocation, _taskString], 
			format ["Recover the %1", getText (configFile >> "cfgVehicles" >> typeOf RetrieveObject >> "displayName")], 
			"selectedLocation"], 
			getMarkerPos "selectedLocation", 
			"AUTOASSIGNED"] call BIS_fnc_taskCreate;
		
		//create action to pick up item
		fnc_grabObject = {
			RetrieveObject addaction ["** Pick Up **",
				{params ["_target"]; deleteVehicle _target;},
				nil, 1.5, true, true, "", "true",3]
		};
		publicVariable "fnc_grabObject";
		
		//add addaction to all players
		//[fnc_grabObject] remoteExec ["call",0,true];
		remoteExec ["fnc_grabObject",0,true];
			
		//create a task trigger
		//create trigger to check when item no longer exists
		_taskTrigger = createTrigger ["EmptyDetector", getMarkerPos "selectedLocation"];
		//_taskTrigger setTriggerArea [NearRadius, NearRadius, 0, false];
		//_taskTrigger setTriggerActivation ["EAST", "NOT PRESENT", true];
		_taskTrigger setTriggerStatements ["isNull RetrieveObject", "['task1', 'SUCCEEDED'] call BIS_fnc_taskSetState;", ""];
	};
	case 2: {//destroy object
		//select item from list
		private _destroyItem = selectRandom DestroyItems;
		
		//get spawn location near center
		private _newPos = [locationPosition FinalLocation, 0, NearRadius/3, 1] call BIS_fnc_findSafePos;
		
		//spawn item in AO & glow effect
		DestroyObject = _destroyItem createVehicle _newPos;
		//DestroyObject setPos [getPos DestroyObject select 0, getPos DestroyObject select 1, getPos DestroyObject select 2];
		"Chemlight_green" createVehicle getPos DestroyObject;
		//publicVariable "DestroyObject";
		
		private _offsetPos = [_newPos, NearRadius/3, 1] call BIS_fnc_findSafePos;
		_areaMarker = createMarker["destroyLocation", _offsetPos];
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
		private _itemPhoto = getText (configfile >> "CfgVehicles" >> typeOf DestroyObject >> "editorPreview");
		_taskString = format ["%1",formatText [format ["<img image='%1'/>", _itemPhoto]]];
		
		//create task
		[west, "task1", [
			format ["We must destroy the %1 near %2. It seems to be the source of this anomaly. We've marked its last known position on your map in blue and you can see what it looks like below: %3",getText (configFile >> "cfgVehicles" >> typeOf DestroyObject >> "displayName"),text FinalLocation, _taskString], 
			format ["Destroy the %1", getText (configFile >> "cfgVehicles" >> typeOf DestroyObject >> "displayName")], 
			"selectedLocation"], 
			getMarkerPos "selectedLocation", 
			"AUTOASSIGNED"] call BIS_fnc_taskCreate;
		
		//create action execute when destroyed
		fnc_blowObject = {
			_loc = getPos DestroyObject; 
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
			deleteVehicle DestroyObject;
		};
		
		//create a task trigger
		//create trigger to check when item no longer exists
		_taskTrigger = createTrigger ["EmptyDetector", getPos DestroyObject];
		_taskTrigger setTriggerArea [10, 10, 0, false];
		_taskTrigger setTriggerActivation ["EAST", "PRESENT", false];
		_taskTrigger setTriggerStatements [
			"{_x inArea thisTrigger} count allMissionObjects '#explosion' > 0",
			"call fnc_blowObject;['task1', 'SUCCEEDED'] call BIS_fnc_taskSetState;",
			""];
		
		{_x inArea thisTrigger} count allMissionObjects "#explosion" > 0

	};
};

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