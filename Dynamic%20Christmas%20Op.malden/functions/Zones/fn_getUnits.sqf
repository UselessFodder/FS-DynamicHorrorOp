//Pulls enemies from pools under an amount of value remaining
//param: 0- value pool to use, 1-location type (building, near, far) 2- number needed to spawn (default=random up to 8)
params["_valuePool","_spawnType", ["_numToSpawn", ceil(random 4)],["_doPatrol", true]];

//debug***
//diag_log format ["Starting getUnits with value pool %1, spawn type %2, num to spawn %3",_valuePool,_spawnType,_numToSpawn];

//precompile script to spawn units TO MOVE***
//DHO_fnc_spawnGroup = compile preprocessFile "functions\Zones\fn_spawnGroup.sqf";

private _totalValue = 0;
private _iterationsRemain = _numToSpawn;
//array of units to spawn
private _classnamesToSpawn = [];
//clamp to ensure the the while loop doesn't go forever
private _numTries = 5;

//debug***
//diag_log format ["Starting while loop with %1 iterations", _iterationsRemain];

while {_iterationsRemain != 0 && _valuePool > 0 && _numTries > 0} do {
	//get a random unit and check if under values left to spawn
	private _toSpawn = selectRandom EnemySpawnPool;
	
	if ((_toSpawn select 1) <= _valuePool) then {
		//add to classnames to spawn
		_classnamesToSpawn pushBack (_toSpawn select 0);
		//add up points
		_totalValue = _totalValue + (_toSpawn select 1);
		//remove from valuePool
		_valuePool = _valuePool - (_toSpawn select 1);
		
		//remove iterations remaining
		_iterationsRemain = _iterationsRemain - 1;
		
		//debug***
		//diag_log format ["Spawning %1 at %2 value,%3 total value, %4 value remains, %5 iterations remain",_toSpawn select 0, _toSpawn select 1, _totalValue, _valuePool, _iterationsRemain];
	};
	
	if (count _classnamesToSpawn < 1) then {
		//debug***
		//diag_log format ["Get Units: No classnames on iteration %1", _numTries];	
		//decrement tries
		_numTries = _numTries - 1;		
	};
	
	//delay for computer's sake
	sleep 0.1;
};

//debug***
//diag_log format ["Created %1 classnames to spawn: %2", count _classnamesToSpawn, _classnamesToSpawn];

//spawn enemies at location specified
if (count (groups east) < 144 && count _classnamesToSpawn > 0) then {
	try {
		private _grp = [count _classnamesToSpawn, _classnamesToSpawn, _spawnType] call DHO_fnc_spawnGroup;
		
		//make some groups patrol
		if(_doPatrol && ceil(random(10)) > 5) then {
			//1-5 patrol points
			private _numPoints = ceil(random(5));
			for "_i" from 0 to _numPoints do {
				if (_i < _numPoints) then {
					_grp addWaypoint [getPos leader _grp, NearRadius*0.5];
				} else {
					//if this is last point, make it a cycle at spawn point
					private _wp = _grp addWaypoint [getPos leader _grp, 0];
					_wp setWaypointType "CYCLE";
				};
			};
		};
	}catch {
		diag_log format ["Exception: %1",_exception];
		if (true) exitWith {};
	};
};
_totalValue;