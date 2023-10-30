//0=spawn map location
//Example: _selectedLoc execVM "findNearbySpawns.sqf";
params["_spawnLoc"];

//radius to search for spawn locations
private _searchRadius = NearRadius;

//number of spawn points to locate
private _numSpawns = 20;

//attempts this will make to find numSpawns
private _attempts = 500;
private _currentAttempt = 0;

//array to hold all spawns locally so we can test
private _nearSpawns = [];

//while loop to keep looking until numSpawns or attempts is reached
while {count _nearSpawns < _numSpawns && _currentAttempt < _attempts} do {
	private _currentSpawn = [locationPosition _spawnLoc, 0, _searchRadius, 1] call BIS_fnc_findSafePos;
	
	//ensure position is not at default []
	if (!isNil "_currentSpawn") then {
		//if not, push into array
		_nearSpawns pushBack _currentSpawn;
		//debug***
		//diag_log format ["New spawn found: %1", _currentSpawn];
	} else {
		//if it is, log for debug***
		//diag_log format ["Attempt %1 is a failure generate spawn", _currentAttempt];
	};

	//increment attempt
	_currentAttempt = _currentAttempt + 1;
};

//add visual markers for debug***
for "_i" from 0 to (count _nearSpawns)-1 do {
	/* DEBUG***
	_debugMarker = createMarker[format["Near %1",_i], _nearSpawns select _i];
	_debugMarker setMarkerType "hd_dot";
	_debugMarker setMarkerColor "ColorBlue";

	_newHelper = "VR_3DSelector_01_incomplete_F" createVehicle (_nearSpawns select _i);
	_newHelper setPos (_nearSpawns select _i);
	*/
	
	//add to near spawns to use later
	NearSpawns pushback (_nearSpawns select _i);
};