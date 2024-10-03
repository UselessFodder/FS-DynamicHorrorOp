//0=spawn map location, 1=index of location within SelectedLocations
//Example: [_selectedLoc,_locIndex] execVM "functions\Zones\fn_findNearbyStructures.sqf";
//Example: [_selectedLoc,_locIndex] call DHO_fnc_findNearbyStructures.sqf;
params["_selectedLoc","_locIndex"];

//initialize array to hold spawn locs
_buildingSpawns = [];

//radius to search for structures
private _searchRadius = NearRadius;

//structure types to exclude TODO**
private _excludeStructres = [];

//get array of all buildings near location
_nearStructures = nearestObjects[locationPosition _selectedLoc,["house"],_searchRadius];

//add all structures to new array if they possess building positions (i.e. not a fence)
private _nearBuildings = [];

for "_i" from 0 to (count _nearStructures)-1 do {
	//check number of building pos
	//_structurePos = [];
	_structurePos = (_nearStructures select _i) buildingPos -1;
	//check if count is 0
	if (count _structurePos > 0) then {
	//if ([_nearStructures select _i] call BIS_fnc_isBuildingEnterable) then {
	//if (!((_nearStructures select _i) buildingExit 0 isEqualTo [0,0,0])) then { 
		//debug***
		//diag_log format ["Number Pos location: %1", _structurePos];
		//if so, push into _nearBuildings
		_nearBuildings pushback (_nearStructures select _i);
	};//else, discard
};

//debug***
//diag_log format ["Found %1 buildings near location: %2", count _nearBuildings, _nearBuildings];

//add markers for debug***
for [{_i = 0},{_i < count _nearBuildings},{_i = _i+1}] do {
	/*
	_debugMarker = createMarker[format["Bldg %1",_i], getPos (_nearBuildings select _i)];
	_debugMarker setMarkerType "hd_dot";
	_debugMarker setMarkerColor "ColorBlack";
	*/
	
	private _testPos = (_nearBuildings select _i) buildingPos -1;
	
	//add visual markers for debug***
	for "_e" from 0 to (count _testPos)-1 do {
		/*
		_newHelper = "VR_3DSelector_01_default_F" createVehicle (_testPos select _e);
		_newHelper setPos (_testPos select _e);
		*/
		
		//add to near spawns to use later
		_buildingSpawns pushback (_testPos select _e);
	};
};


//attach array to location logic
_logicName = format ["selectedLocation%1", _locIndex];
_logicObject = missionNamespace getVariable _logicName;
_logicObject setVariable ["_buildingSpawns", _buildingSpawns];


