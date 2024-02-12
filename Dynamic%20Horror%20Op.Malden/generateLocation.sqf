//creates a new location and addes it to SelectedLocations master list
execVM "findLocation.sqf";

sleep 1;

_lastLoc = (count SelectedLocations) - 1;
[SelectedLocations select _lastLoc,_lastLoc] execVM "initLocation.sqf";