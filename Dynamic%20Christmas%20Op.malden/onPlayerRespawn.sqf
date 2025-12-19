/*
	Remove any default equipment and set arsenal items on respawn
*/

private _loadout = player getVariable ["savedLoadout", []];

// Check if there is a saved loadout
if (!(_loadout isEqualTo [])) then {
	// Restore the unit's loadout when they respawn
	player setUnitLoadout _loadout;
};

_deadBody = _this select 1;

//if body is in the base, then delete it
if (_deadBody distance getMarkerPos "mainBase" < 50) then{
	deleteVehicle _deadBody;
};
