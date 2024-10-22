//Initializes spawns and missions for the passed in AO
params ["_selectedLoc","_locIndex"];

	//select mission type
	//0=clear area, 1=find objects, 2=destroy object, 3=kill boss, 4=rescue
	//MissionType = floor(random(4));
	_missionType = selectRandom[0,1,2];
	//DEBUG***
	//MissionType = 1;
	
	//select enemy types
	//0=all, 1=fantasy, 2=sci fi, 3=cryptid, 4=stalker/post-apoc, 5=undead
	//TODO***
	
	//wait until spawn locations are created
	//sleep 1;
	private _spawnsReady = false;
	while {!_spawnsReady} do {
		private _logicName = format["selectedLocation%1", _locIndex];
		_logicObject = missionNamespace getVariable _logicName;
		
		//diag_log format ["Logic object is %1", _logicObject];
		
		if (!isNull _logicObject && count (_logicObject getVariable "_nearSpawns") > 0  && count (_logicObject getVariable "_farSpawns") > 0) then {
			diag_log format ["+++ %1 spawns are ready", text (SelectedLocations select _locIndex)];
			_spawnsReady = true;
		} else {
			diag_log format ["--- %1 spawns not ready, sleeping 0.5 seconds", text (SelectedLocations select _locIndex)];
		};
		
		sleep 0.5;
	};
	/*
	private _logicName = format["selectedLocation%1", _locIndex];
	private _logicObject = missionNamespace getVariable _logicName;
	waitUntil {sleep 0.5; !isNull (_logicObject getVariable "_buildingSpawns") && !isNull (_logicObject getVariable "_nearSpawns") && !isNull (_logicObject getVariable "_farSpawns")};
	*/
	
	
	//spawn enemies inside, out
	_spawnInit = [_locIndex] execVM "functions\Zones\fn_initSpawns.sqf";
	
	
	//waitUntil{sleep 1;scriptDone _spawnInit};
	waitUntil{sleep 1; count (units east inAreaArray (format ["selectedLocation%1",_locIndex])) > 5;};
	
	
	//generate tasks
	[_selectedLoc,_locIndex,_missionType] spawn DHO_fnc_createTask;
	
	//generate randomized spook events
	[_selectedLoc] call DHO_fnc_generateSpooks;