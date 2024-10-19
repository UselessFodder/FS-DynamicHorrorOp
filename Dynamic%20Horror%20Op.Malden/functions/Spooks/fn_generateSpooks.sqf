/*
	This script generates 'spook' events within the horror zones.
	It is executed when an area is initiated via initLocations.sqf
	Params: [Zone location object]
	Example execution: [_selectedLoc] execVM "generateSpooks.sqf";
*/

//get location
params ["_selectedLoc"];

//check if mission vibe is spook. If so, set waitMultiplier to 0.5
private _waitMultiplier = 1;
if (MissionType == 0) then {
	_waitMultiplier = 0.5;
};

//spook events are generated from the list outlined below
private _spookList = [0,0,0,0,0,0,0,0,1,2];
//private _spookList = []; //***DEBUG

//add in mod specific spooks
//STALKER-like TTS Emissions
if (isClass(configfile >> "CfgPatches" >> "tts_emission")) then {
	_spookList append [3,3];
};

//***DEBUG
diag_log format ["List of spooks to choose from this session: %1", _spookList];


while{true} do {
	//wait time to use
	private _waitTime = ((random(600) + 900) * _waitMultiplier);
	
	//***DEBUG
	//private _waitTime = 30;
	
	//check if any players are in the area
	if({(_x distance locationPosition _selectedLoc) < (NearRadius * 1.5)} count allPlayers > 0) then {
		
		private _spookType = selectRandom _spookList;
		
		switch _spookType do {
			case 0: { [_selectedLoc] spawn DHO_fnc_soundBehind; }; //Create creepy sound nearby
			case 1: { [_selectedLoc] spawn DHO_fnc_enemyBehind; }; //Spawn rear jumpscare
			case 2: { [_selectedLoc] spawn DHO_fnc_enemyInfront; }; //Spawn front jumpscare
			case 3: { [] spawn tts_emission_fnc_startEmission; }; //STALKER TTS emission
			default { [_selectedLoc] spawn DHO_fnc_soundBehind; };
		};
		
	} else {
		//if no spook happens, lessen time to check to 3-5 min
		_waitTime = random(120) + 180;
		diag_log format ["** No players in %1, waiting %2 seconds to check again",_selectedLoc,_waitTime];

	};

	sleep _waitTime;
};