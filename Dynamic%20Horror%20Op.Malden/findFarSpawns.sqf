//0=spawn map location, 1=index of location within SelectedLocations
//Example: [_selectedLoc,_locIndex] execVM "findNearbySpawns.sqf";
params["_spawnLoc","_locIndex"];

//radius to search for spawn locations
private _minRadius = NearRadius - 100;
private _searchRadius = 600;

//number of spawn points to locate
private _numSpawns = 40;

//attempts this will make to find numSpawns
private _attempts = 500;
private _currentAttempt = 0;

//array to hold all spawns locally so we can test
private _farSpawns = [];

//while loop to keep looking until numSpawns or attempts is reached
while {count _farSpawns < _numSpawns && _currentAttempt < _attempts} do {
	private _currentSpawn = [locationPosition _spawnLoc, _minRadius, _searchRadius, 1] call BIS_fnc_findSafePos;
	
	//ensure position is not at default []
	if (!isNil "_currentSpawn") then {
		//if not, push into array
		_farSpawns pushBack _currentSpawn;
		//debug***
		//diag_log format ["New far spawn found: %1", _currentSpawn];
	} else {
		//if it is, log for debug***
		//diag_log format ["Far attempt %1 is a failure generate spawn", _currentAttempt];
	};

	//increment attempt
	_currentAttempt = _currentAttempt + 1;
};

/*
//add visual markers for debug***
for "_i" from 0 to (count _farSpawns)-1 do {
	/*
	_debugMarker = createMarker[format["Far %1",_i], _farSpawns select _i];
	_debugMarker setMarkerType "hd_dot";
	_debugMarker setMarkerColor "ColorRed";

	_newHelper = "VR_3DSelector_01_default_F" createVehicle (_farSpawns select _i);
	_newHelper setPos (_farSpawns select _i);
	
	//add to near spawns to use later
	FarSpawns pushback (_farSpawns select _i);
}; */

//attach array to location logic
_logicName = format ["selectedLocation%1", _locIndex];
_logicObject = missionNamespace getVariable _logicName;
_logicObject setVariable ["_farSpawns", _farSpawns];