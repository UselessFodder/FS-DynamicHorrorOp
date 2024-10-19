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
	
	//spawn enemies inside, out
	_spawnInit = [_locIndex] execVM "functions\Zones\fn_initSpawns.sqf";
	
	
	//waitUntil{sleep 1;scriptDone _spawnInit};
	waitUntil{sleep 1; count (units east inAreaArray (format ["selectedLocation%1",_locIndex])) > 5;};
	
	
	//generate tasks
	[_selectedLoc,_locIndex,_missionType] spawn DHO_fnc_createTask;
	
	//generate randomized spook events
	[_selectedLoc] call DHO_fnc_generateSpooks;