//0 = NearSpawns/BuildingSpawns/FarSpawns
// example [NearSpawns] execVM "functions\Zones\fn_spawnBoss.sqf";
// example [,NearSpawns] call DHO_fnc_spawnBoss;
params["_spawnLocs"];

//debug***
//diag_log format ["Spawning new group of %1 units", _numToSpawn];

private _spawnPos = selectRandom _spawnLocs;

//group to hold new units
private _newGroup = createGroup east;
_newGroup enableDynamicSimulation true;

//temp unit to ensure side is set to east
private _tempUnit = _newGroup createUnit ["O_Survivor_F", _spawnPos, [], 5, "NONE"];

//check player count to ensure boss is not too powerful
DifficultyParam = ["DifficultyParam", 2] call BIS_fnc_getParamValue;
private _difficultyModifier = 0;

switch (DifficultyParam) do {
	case 0:{
		_difficultyModifier = -1;
	};
	case 1:{
		_difficultyModifier = 0;
	};
	case 2:{
		_difficultyModifier = 1;
	};
	case 3:{
		_difficultyModifier = 2;
	};
};	

_maxBossLevel = ceil(count allPlayers / 4) + _difficultyModifier;

//ensure max level is at least 1
if (_maxBossLevel < 1) then {
	_maxBossLevel = 1;
};

//get list of boss units that meet level requirement
_filteredBossTypes = [];

while {(count _filteredBossTypes < 1) && (_maxBossLevel > 0)} do {
	{
		if (_x select 1 == _maxBossLevel) then {
			_filteredBossTypes pushBack _x;
		};
	} forEach EnemySpawnBoss;

	//if no bosses are available at the given level, check other levels
	if (count _filteredBossTypes < 1) then {
		_maxBossLevel = _maxBossLevel - 1;
	};
};

//if still no boss type was available, then exit with an error
if (count _filteredBossTypes < 1) then {
	exitWith{diag_log format ["*** ERROR: Boss Spawn unable to find any units at %1 Boss level or below!", ceil(count allPlayers / 4) + _difficultyModifier];};
};

//select the boss unit from all boss units defined by mods
_newUnitType = selectRandom _filteredBossTypes select 0;

//finally, spawn boss unit
diag_log format ["Boss unit %1 spawning at %2",_newUnitType,_spawnPos];
	
private _newUnit = _newGroup createUnit [_newUnitType, _spawnPos, [], 5, "NONE"];
[_newUnit] joinSilent _newGroup;

//delete temp unit
deleteVehicle _tempUnit;

_newGroup;