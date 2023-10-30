//select which types of locations to find
private _capitals = true;
private _cities = true;
private _village = true;
private _nameLocal = true;
private _rockArea = true;
private _viewPoint = true;

//array of location names to exclude from searach
//private _dontSearch = ["Elektrozavodsk","Chernogorsk","Balota","Drakon","Factory","Airstrip"];
private _dontSearch = ["Airport"];

//add to array to search
private _searchTypes = [];
if (_capitals) then {
	_searchTypes pushBack "NameCityCapital";
};
if (_cities) then {
	_searchTypes pushBack "NameCity";
};
if (_village) then {
	_searchTypes pushBack "NameVillage";
};
if (_nameLocal) then {
	_searchTypes pushBack "NameLocal";
};
if (_rockArea) then {
	_searchTypes pushBack "rockArea";
};
if (_viewPoint) then {
	_searchTypes pushBack "ViewPoint";
};

//log for debug***
//diag_Log format ["Current area types to search = %1",_searchTypes];

//run until we have 10 possible locations
while {count OperationLocations < 10} do {

	//select a random location
	private _operationLoc = selectRandom(nearestLocations [[worldSize/2, worldSize/2,0],_searchTypes,worldSize/2]);

	//debug***
	//hint format ["%1",_operationLoc];

	//check if location is one of the excluded ones
	//if(!(text _operationLoc in _dontSearch)) then {
	
	//check if location far enough away from spawn
	if((getMarkerPos "mainBase") distance (locationPosition _operationLoc) > NearRadius * 2.5) then {
		//add op location to array for later use
		OperationLocations pushBack _operationLoc;
		//mark location for debug
		//_debugMarker = createMarker[format["%1",count OperationLocations], locationPosition _operationLoc];
		//_debugMarker setMarkerType "hd_dot";
		//_debugMarker setMarkerColor "ColorRed";
		//debug*** 
		//diag_log format ["Added %1 for %2", text _operationLoc, _operationLoc];
	};
};

//debug*** for all locations
diag_log format ["Final OperationLocations is %1 entries: %2",count OperationLocations, OperationLocations];

//select one location and paint it green
private _selectedLoc = selectRandom OperationLocations;
_debugMarker = createMarker["selectedLocation", locationPosition _selectedLoc];
_debugMarker setMarkerShape "ELLIPSE";
_debugMarker setMarkerSize [NearRadius,NearRadius];
_debugMarker setMarkerColor "ColorRed";
_debugMarker setMarkerAlpha 0.5;
_debugMarker setMarkerBrush "DIAGGRID";

//debug***
diag_log format ["Final Location is %1 at %2", text _selectedLoc, _selectedLoc];

//set final location global variable
FinalLocation = _selectedLoc;
publicVariable "FinalLocation";

//find all nearby buildings to location
_selectedLoc execVM "findNearbyStructures.sqf";

//generate safe near spawning locations on ground
_selectedLoc execVM "findNearbySpawns.sqf";

//generate safe far spawning locations on ground
_selectedLoc execVM "findFarSpawns.sqf";