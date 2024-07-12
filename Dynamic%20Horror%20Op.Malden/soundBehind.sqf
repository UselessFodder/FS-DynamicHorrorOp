//get location
params ["_selectedLoc"];
	
	//get all players in zone
	private _playersInZone = allPlayers select {(_x distance locationPosition _selectedLoc) < (NearRadius * 1.5) && isTouchingGround _x};
	
	//check if there are any players at runtime. If not, exit script
	if (count _playersInZone == 0) exitWith { 
			diag_log format ["BehindSound: No players in %1. Exiting", _selectedLoc]; 
	};
	
	//select a random player in the zone
	private _player = selectRandom _playersInZone;
	//private _player = selectRandom allPlayers;//***DEBUG ***DELETE
	
	//select randomized sound
	_theSound = selectRandom[
		"zombie1.ogg", "zombie2.ogg", "zombie3.ogg", "gross1.ogg", 
		"brush1.ogg","brush1.ogg","brush1.ogg",
		"laugh1.ogg","laugh2.ogg","laugh3.ogg",
		"growl.ogg","growl.ogg","whisper1.ogg",
		"echo.ogg","echo.ogg","echo.ogg"];
	
	//get area directly behind player
	_dir = [_player] call compile preprocessFileLineNumbers "getBehindPlayer.sqf";

	//randomize direction to be anywhere sort of behind player
	_dir = _dir + random(180)-90;
	
	//play sound (mp safe)
	playSound3D [getMissionPath _theSound, _player, false,_player getPos [10,_dir],3]; 
	
	//debug***
	diag_log format ["BehindSound: Played sound %1 behind player %2.",_theSound,_player];