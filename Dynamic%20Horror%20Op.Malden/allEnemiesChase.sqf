//script to cause all enemies to chase players
//loop through all enemy groups and send them towards players every 2 minutes

while{(count groups east) > 0} do {
	for "_i" from 0 to (count groups east)-1 do {
		private _group = groups east select _i;
		
		//delete all current waypoints
		{ deleteWaypoint _x } forEachReversed waypoints _group;
		
		//add waypoint towards random player in zone
		private _isInZone = false;
		private _loopLimit = 20;
		private _player = selectRandom allPlayers;
		
		//loop until player in zone is found
		while {!_isInZone && _loopLimit > 0} do {
			if (_player distance (getMarkerPos "selectedLocation") <= NearRadius) then {
				_group addWaypoint [getPos _player, -1];
				_isInZone = true;
			} else {
				_player = selectRandom allPlayers;
				_loopLimit = _loopLimit - 1;
			};
		};
	};
	
	sleep 10;
};