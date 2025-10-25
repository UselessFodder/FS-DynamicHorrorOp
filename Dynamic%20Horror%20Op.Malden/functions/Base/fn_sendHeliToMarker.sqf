params["_marker"];

//send to lz
_wp1 = heliGroup addWaypoint [getMarkerPos _marker, -1];
//set to transport unload and safe
_wp1 setWaypointType "TR UNLOAD";
_wp1 setWaypointBehaviour "CARELESS";
//ensure heli waits until its unloaded with DEBUG***
_wp1 setWaypointStatements ["count (crew transportHeli) < 3", "diag_log 'Players dropped off by heli'; MissionCommander synchronizeObjectsAdd [supportRequester];"];


//create move waypoint back to base
_wp2 = heliGroup addWaypoint [getMarkerPos "mainBase", -1];
//_wp2 setWaypointStatements ["true", "doStop transportHeli; transportHeli landAt [getMarkerPos 'mainBase', 'LAND'];"];
_wp2 setWaypointStatements ["true", "doStop transportHeli; transportHeli land 'LAND';"];

fn_replaceCrew = {
	params["_heli"];
	
	{
		if (!isPlayer _x) then {
			deleteVehicle _x;
		};
	} forEach crew _heli;
	
	private _tempGroup = createGroup [west, true];
	
	private _tempUnit = _tempGroup createUnit ["B_Helipilot_F", getMarkerPos "mainBase",[], 0, "NONE"];
	_tempUnit moveInDriver _heli;
	private _tempUnit2 = _tempGroup createUnit ["B_Helipilot_F", getMarkerPos "mainBase",[], 0, "NONE"];
	_tempUnit2 moveInTurret [_heli, [0]];
	//_tempUnit2 moveInAny _heli;

	missionNamespace setVariable ["heliGroup", _tempGroup];
	
};


//clear previous land command
 _wp3 = heliGroup addWaypoint [getMarkerPos "mainBase", -1];
_wp3 setWaypointStatements ["true", "doStop transportHeli; transportHeli land 'NONE'; transportHeli engineOn false; [transportHeli] call fn_replaceCrew;"];
//_wp3 setWaypointStatements ["true", "doStop transportHeli; transportHeli landAt [getMarkerPos 'mainBase', 'NONE']"];
_wp3 setWaypointTimeout [30, 30, 30];