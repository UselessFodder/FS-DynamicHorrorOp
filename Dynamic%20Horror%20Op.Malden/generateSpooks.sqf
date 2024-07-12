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

while{true} do {
	//wait time to use
	private _waitTime = ((random(600) + 900) * _waitMultiplier);
	
	//check if any players are in the area
	//private _playersNear = {_x distance locationPosition _selectedLoc) < (NearRadius * 1.5} count allPlayers;
	if({(_x distance locationPosition _selectedLoc) < (NearRadius * 1.5)} count allPlayers > 0) then {
		
		//if so, generate a spook event from the list outlined below
		private _spookType = selectRandom[0,0,0,0,0,0,0,0,1,2];
		
		switch _spookType do {
			case 0: { [_selectedLoc] execVM "soundBehind.sqf"; };
			case 1: { [_selectedLoc] execVM "enemyBehind.sqf"; };
			case 2: { [_selectedLoc] execVM "enemyInfront.sqf"; };
			default { [_selectedLoc] execVM "soundBehind.sqf"; };
		};
		
	} else {
		//if no sound plays, lessen time to check to 3-5 min
		_waitTime = random(120) + 180;

	};

	sleep _waitTime;
};

/*
		//select randomized sound
		_theSound = selectRandom[
			"zombie1.ogg", "zombie2.ogg", "zombie3.ogg", "gross1.ogg", 
			"brush1.ogg","brush1.ogg","brush1.ogg",
			"laugh1.ogg","laugh2.ogg","laugh3.ogg",
			"growl.ogg","growl.ogg","whisper1.ogg",
			"echo.ogg","echo.ogg","echo.ogg"];
		
		//get area directly behind player
		_dir = getDir _player;
		if (_dir < 180) then {
		_dir = _dir +180;
		}else {
		_dir = _dir-180;
		};  
		
		//select a random player
	_player = selectRandom allPlayers;
	
	//check if player is inside spook zone and on the ground
	if((_player distance locationPosition _selectedLoc) < (NearRadius * 1.5) && isTouchingGround _player) then {
		
		//randomize direction to be anywhere sort of behind player
		_dir = _dir + random(180)-90;
		
		//play sound (mp safe)
		playSound3D [getMissionPath _theSound, _player, false,_player getPos [10,_dir],3]; 
		
		//debug***
		diag_log format ["BehindSound: Played sound %1 from player %2. Sleeping for %3 sec",_theSound,_player,_waitTime];

		//debug***
		diag_log format ["BehindSound: Player %1 is not in spook zone, skipping sound for %2.",_player,_waitTime];
*/