//spawn initial enemies from enemy pools and with enemy spawn values

//debug***
diag_log "Waiting for PoolsLoaded";

//wait until pools are loaded 
waitUntil {sleep 0.5; PoolsLoaded};

//debug***
diag_log "Now starting initSpawns";

//precompile script to spawn units TO MOVE***
FS_fnc_getUnits = compile preprocessFile "getUnits.sqf";

//determine pool values amounts
private _buildingValues = floor(EnemySpawnValues * 0.25);
private _nearValues = floor(EnemySpawnValues * 0.50);
private _farValues = floor(EnemySpawnValues * 0.25);
private _buildingSpawns = BuildingSpawns;
//clamp to ensure the the while loops don't go forever
private _numTryIterations = 5;
private _numTries = _numTryIterations;

//debug***
diag_log format ["Values: %1, %2, %3", _buildingValues,_nearValues,_farValues];

//check if there are building spawns
if (count BuildingSpawns <= 0) then {
	_buildingSpawns = NearSpawns;
	//debug***
	diag_log "Switching from building to near spawns due to no buildings";
};

//spawn enemies until out of value
while {_buildingValues > 0 && _numTries > 0} do {
	//debug***
	diag_log format ["Building: Attemping iteration %1", _numTries];
	
	//debug***
	//diag_log format ["Running building spawns at value %1", _buildingValues];
	//spawn and get subtract value
	_toSubtract = [_buildingValues,_buildingSpawns, 1,false] call FS_fnc_getUnits;
	//debug***
	//diag_log format ["Generated units at cost %1", _toSubtract];
	//decrement building values
	_buildingValues = _buildingValues - _toSubtract;
	
	if (_toSubtract < 1) then {
		//debug***
		diag_log format ["Building: No spawns on iteration %1", _numTries];
		//decrement tries
		_numTries = _numTries - 1;
	};	
	
	//delay for computer's sake
	sleep 0.1;
};

//debug***
diag_log "***  Building spawns complete, beginning near spawns";

_numTries = _numTryIterations;

//spawn enemies until out of value
while {_nearValues > 0 && _numTries > 0} do {
	//debug***
	diag_log format ["Near: Attemping iteration %1", _numTries];
	
	//spawn and get subtract value
	_toSubtract = [_nearValues,NearSpawns] call FS_fnc_getUnits;
	//decrement building values
	_nearValues = _nearValues - _toSubtract;
	
	if (_toSubtract < 1) then {
		//debug***
		diag_log format ["Near: No spawns on iteration %1", _numTries];
		//decrement tries
		_numTries = _numTries - 1;
	};
	
	//delay for computer's sake
	sleep 0.1;
};

//debug***
diag_log "***  Near spawns complete, beginning far spawns";

_numTries = _numTryIterations;

//spawn enemies until out of value
while {_farValues > 0 && _numTries > 0} do {
	//debug***
	diag_log format ["Far: Attemping iteration %1", _numTries];
	
	//spawn and get subtract value
	_toSubtract = [_farValues,FarSpawns] call FS_fnc_getUnits;
	//decrement building values
	_farValues = _farValues - _toSubtract;
	
	if (_toSubtract < 1) then {
		//debug***
		diag_log format ["Far: No spawns on iteration %1", _numTries];				
		//decrement tries
		_numTries = _numTries - 1;	
	};		
	
	//delay for computer's sake
	sleep 0.1;
};
//get all enemy groups to public variable
AllEnemyGroups = groups east;

//get all groups outside a distance from zone and save to public array and vice versa
NearEnemyGroups = [];
FarEnemyGroups = [];

//loop through all groups and check if distance from point is > near distance
for "_i" from 0 to (count AllEnemyGroups) -1 do {
	//check if group leader is within NearRadius of marker 
	//private _leader = leader (AllEnemyGroups select _i);
	if ((leader (AllEnemyGroups select _i) distance (getMarkerPos "selectedLocation")) <= NearRadius) then {
		//if it is, this is a near group
		NearEnemyGroups pushBack (AllEnemyGroups select _i);
	} else {
		//if not, it's a far group
		FarEnemyGroups pushBack (AllEnemyGroups select _i);
	}
};

//make publically available
publicVariable "AllEnemyGroups";
publicVariable "NearEnemyGroups";
publicVariable "FarEnemyGroups";

//get total number of units
TotalSpawned = count units east;
publicVariable "TotalSpawned";

//debug***
diag_log format ["***  All spawns complete! %1 units spawned ***", TotalSpawned];