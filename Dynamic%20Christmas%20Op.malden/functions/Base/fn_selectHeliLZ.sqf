//Opens map and creates new waypoint for helicopter to transport to
//Credit goes to Erwin23p on BIS forums for the source of this code: https://forums.bohemia.net/forums/topic/237559-open-map-and-set-waypoint/?do=findComment&comment=3454296

//must be run only on MissionCommander client
openMap true; 
 
hint "Select helicopter landing zone on map."; 
 
onMapSingleClick 
{  //Inside here code to execute when clicked on the map 
	_heloWaypoint = createMarker ["LandingPosition", _pos]; 
	_heloWaypoint setMarkerText "Heli LZ";
	_heloWaypoint setMarkerShape "ICON"; 
	_heloWaypoint setMarkerType "hd_pickup"; 
	"LandingPosition" setMarkerPos _pos; 
	onMapSingleClick ""; 
	hint "New LZ selected!";
};

//FOR SAVE *** 
/*
this addAction ["Select LZ", "functions\Base\selectHeliLZ.sqf", nil, 1.5, true, true, "", "_this == MissionCommander", 10, false];
this addAction ["** Begin Insertion", "functions\Base\heliInsert.sqf", nil, 1.5, true, true, "", "_this == MissionCommander", 10, false];

*/