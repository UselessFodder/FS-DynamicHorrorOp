//creates a new location and addes it to SelectedLocations master list
call DHO_fnc_findLocation;

sleep 1;

_lastLoc = (count SelectedLocations) - 1;
[SelectedLocations select _lastLoc,_lastLoc] call DHO_fnc_initLocation;