//script to cause all enemies spawned outside zone to collapse towards center
//loop through all enemy groups and send them towards center point
for "_i" from 0 to (count FarEnemyGroups)-1 do {
	private _group = FarEnemyGroups select _i;
	
	//delete all current waypoints
	{ deleteWaypoint _x } forEachReversed waypoints _group;
	
	//add waypoint to random position near middle
	//private _newPos = [locationPosition _spawnLoc, 0, NearRadius/4, 1] call BIS_fnc_findSafePos;
	_group addWaypoint [locationPosition FinalLocation, NearRadius/4];
};