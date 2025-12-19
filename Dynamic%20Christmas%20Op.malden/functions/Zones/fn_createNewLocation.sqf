/*
	Description: This script creates new location objects in random locations to enable missions outside of just named towns.
		
	Use: This script is called by DHO_fnc_findLocation.sqf upon mission creation, but may have use to create new dynamic
		zones in the future.
	
	Called by: Within DHO_fnc_findLocation.sqf. Example:
		[] spawn DHO_fnc_createNewLocation;
		
	Calls: none
	Called on: Server only
	Parameters: 0: 
				1: 
				2: unused
				3: unused
	Return: new Location object
*/

//get a location not near any other locations
private _newPos = [nil, ["water"], {_this distance (nearestLocation[_this, ['NameCityCapital','NameCity','NameVillage','NameLocal','rockArea','ViewPoint']]) > (NearRadius/2) }] call BIS_fnc_randomPos;

private _nearestLoc = nearestLocation[[_newPos select 0, _newPos select 1], ['NameCityCapital','NameCity','NameVillage','NameLocal','rockArea','ViewPoint']];

//get name for logging
private _nearLocName = '';
if (text _nearestLoc == "") then {
	_nearLocName = "ROCK OR LOOKOUT";
} else {
	_nearLocName = text _nearestLoc;
};

diag_log format ['** Random location found at %1. Distance to nearest loc %2 is %3',_newPos, _nearLocName, _newPos distance _nearestLoc];

private _newLoc = createLocation ["FlatArea", _newPos, 50, 50];
_newLoc setText format ['Area near %1', _nearLocName];

//***DEBUG 
/*
_newLoc setText format ['Area near %1', _nearLocName];
_debugMarker = createMarker["TEST TEST", _newPos];
_debugMarker setMarkerShape "ELLIPSE";
_debugMarker setMarkerSize [100,100];
_debugMarker setMarkerColor "ColorRed";
_debugMarker setMarkerAlpha 0.5;
_debugMarker setMarkerBrush "DIAGGRID"; */

//return new area
_newLoc;