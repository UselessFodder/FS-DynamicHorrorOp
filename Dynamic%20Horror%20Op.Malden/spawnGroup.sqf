//0 = int, 1 = array strings, 2 = NearSpawns/BuildingSpawns/FarSpawns
// example [5,ZombieTypes,NearSpawns] execVM "spawnGroup.sqf";
params["_numToSpawn","_classNames","_spawnType"];

//debug***
//diag_log format ["Spawning new group of %1 units", _numToSpawn];

private _spawnPos = selectRandom _spawnType;

//group to hold new units
private _newGroup = createGroup east;
//temp unit to ensure side is set to east
private _tempUnit = _newGroup createUnit ["O_Survivor_F", _spawnPos, [], 5, "NONE"];


//loop to run equal to numToSpawn
for "_i" from 0 to (_numToSpawn - 1) do {
	private _newUnitType = _classNames select _i;
	//debug***
	//diag_log format ["Now spawning %1 unit %2 of %3",_newUnitType,_i+1,_numToSpawn];
	
	private _newUnit = _newGroup createUnit [_newUnitType, _spawnPos, [], 5, "NONE"];
	[_newUnit] joinSilent _newGroup;
	
	//delay for computer's sake
	sleep 0.1;
};

//delete temp unit
deleteVehicle _tempUnit;

_newGroup;