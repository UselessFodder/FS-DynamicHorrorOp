//finds and destroys all locally created light objects near point
params ["_loc"];

private _allLights = nearestObjects [_loc, ["#lightpoint", "#lightreflector"], 10];

//***debug
//diag_log format ["All lights to destroy found within 10m of %1: %2", _loc, _allLights];

//{deleteVehicle _x} forEach nearestObjects [_loc, ["#lightpoint", "#lightreflector"], 10];
{deleteVehicle _x} forEach _allLights;