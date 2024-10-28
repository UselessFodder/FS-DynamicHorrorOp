//script to cause all enemies to chase players
//loop through all nearby enemy groups and send them towards players every 2 minutes

params["_selectedLoc"];

_logicObject = missionNamespace getVariable _selectedLoc;
_nearEnemyGroups = _logicObject getVariable "_nearEnemyGroups";
_farEnemyGroups = _logicObject getVariable "_farEnemyGroups";
_allEnemyGroups = _nearEnemyGroups + _farEnemyGroups;

while{(count _allEnemyGroups) > 0} do {
	//for "_i" from 0 to (count _allEnemyGroups)-1 do {
	for [{ private _i = 0 }, { _i < count _allEnemyGroups}, { _i = _i + 1 }] do {
		private _group = _allEnemyGroups select _i;
		
		if (isNull _group) then {
			_allEnemyGroups deleteAt _i;
		} else {
			//delete all current waypoints
			{ deleteWaypoint _x } forEachReversed waypoints _group;
			
			//add waypoint towards random player in zone
			private _isInZone = false;
			private _loopLimit = 20;
			private _player = selectRandom allPlayers;
			
			//loop until player in zone is found
			while {!_isInZone && _loopLimit > 0} do {
				if (_player distance (getMarkerPos _selectedLoc) <= NearRadius) then {
					_group addWaypoint [getPos _player, -1];
					_isInZone = true;
				} else {
					_player = selectRandom allPlayers;
					_loopLimit = _loopLimit - 1;
				};
			};
		};
	};
	
	sleep 10;
};