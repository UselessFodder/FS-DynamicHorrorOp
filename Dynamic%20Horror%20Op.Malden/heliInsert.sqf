//send helicopter to insertion location defined by param marker name, then wait until players unload to take off and RTB
//***TODO un-hard define this marker
//params["_marker"];

private _marker = "LandingPosition";

//check to ensure marker is already set
if(getMarkerPos "LandingPosition" isEqualTo [0,0,0]) then {
	"You must select an LZ first!" remoteExec["hint",MissionCommander];

} else {
	//send to lz
	_wp1 = heliGroup addWaypoint [getMarkerPos _marker, -1];
	//set to transport unload and safe
	_wp1 setWaypointType "TR UNLOAD";
	_wp1 setWaypointBehaviour "CARELESS";
	//ensure heli waits until its unloaded with DEBUG***
	_wp1 setWaypointStatements ["count (crew transportHeli) < 3", "diag_log 'Players dropped off by heli'; MissionCommander synchronizeObjectsAdd [supportRequester];"];


	//create move waypoint back to base
	_wp2 = heliGroup addWaypoint [getMarkerPos "mainBase", -1];
	_wp2 setWaypointStatements ["true", "transportHeli land 'LAND'"];

};