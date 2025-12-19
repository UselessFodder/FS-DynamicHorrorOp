/*

	Description: This script creates a trigger around the mainBase that detects if any enemy units get within
		a parameter distance and destroys them with an explosion if they do
		
	Use: This script is called by init.sqf 
	
	Called by: init.sqf
	Calls: none
	Called on: Server only
	Parameters: 0: radius of trigger
				1: update interval for the trigger
	Return: none

*/

params ["_radius","_interval"];

//create trigger
_spawnProtection = createTrigger ["EmptyDetector", getMarkerPos "mainBase"];
_spawnProtection setTriggerArea [_radius, _radius, 0, false];
_spawnProtection setTriggerActivation ["EAST", "PRESENT", true];
_spawnProtection setTriggerInterval _interval;
private _trigStatement = "{ _bomb = 'APERSTripMine_Wire_Ammo' createVehicle (getPos _x); _bomb setdamage 1; _x setdamage 1;} forEach thisList;";
_spawnProtection setTriggerStatements [
	"this", 
	_trigStatement, 
	""
];


/*
{
bomb = "APERSTripMine_Wire_Ammo" createVehicle (getPos _x);   
bomb setdamage 1; 
_x setdamage 1;
} forEach thisList;
*/