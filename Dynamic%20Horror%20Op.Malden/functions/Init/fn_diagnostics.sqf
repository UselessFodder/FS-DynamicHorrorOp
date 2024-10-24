//logs the current FPS and numbers of units to help determine performance
//***DEBUG
private _sleepTime = 15;


while {true} do {
	private _myFPS = diag_fps;
	private _numUnits = count allUnits;
	private _numActiveUnits = 0;
	private _numInactiveUnits = 0;

	{
		if (dynamicSimulationEnabled _x) then {
			_numInactiveUnits = _numInactiveUnits + 1;
		} else {
			_numActiveUnits = _numActiveUnits + 1;
		};
	} forEach allGroups;

	diag_log format ["*** POLLING: FPS: %1, AllUnits: %2, ActiveGrps: %3, InactiveGrps %4", _myFPS, _numUnits, _numActiveUnits, _numInactiveUnits];

	sleep _sleepTime;
};