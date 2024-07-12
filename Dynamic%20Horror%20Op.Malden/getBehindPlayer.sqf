/*
	This script gets the direction directly behind the unit object passed in.
	Params: [unit object]
	Example execution: _dir = _unit call compile preprocessFileLineNumbers "getBehindPlayer.sqf";;
*/

params["_unit"];

//get area directly behind unit
_dir = getDir _unit;
if (_dir < 180) then {
_dir = _dir +180;
}else {
_dir = _dir-180;
};

_dir 