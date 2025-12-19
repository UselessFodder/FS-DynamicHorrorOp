//script to cause all enemies spawned outside zone to collapse towards center
//loop through all enemy groups and send them towards center point
params ["_locationName","_selectedLoc"];

diag_log format ["***Variables are _locationName:%1, _selectedLoc: %2",_locationName,_selectedLoc];
diag_log "";

_logicObject = missionNamespace getVariable _locationName;
//_logicObject = _locationName;
_farEnemyGroups = _logicObject getVariable "_farEnemyGroups";

for "_i" from 0 to (count _farEnemyGroups)-1 do {
	private _group = _farEnemyGroups select _i;
	
	//delete all current waypoints
	{ deleteWaypoint _x } forEachReversed waypoints _group;
	
	//add waypoint to random position near middle
	//private _newPos = [locationPosition _spawnLoc, 0, NearRadius/4, 1] call BIS_fnc_findSafePos;
	_group addWaypoint [_selectedLoc, NearRadius/4];
};