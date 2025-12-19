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
private _theSound = selectRandom[
	"sounds\zombie1.ogg", "sounds\zombie2.ogg", "sounds\zombie3.ogg", "sounds\gross1.ogg", 
	"sounds\brush1.ogg","sounds\brush1.ogg","sounds\brush1.ogg",
	"sounds\laugh1.ogg","sounds\laugh2.ogg","sounds\laugh3.ogg",
	"sounds\growl.ogg","sounds\growl.ogg","sounds\whisper1.ogg",
	"sounds\echo.ogg","sounds\echo.ogg","sounds\echo.ogg",
	"sounds\whisper2.ogg","sounds\whisper3.ogg","sounds\horn2.ogg",
	"sounds\ghost1.ogg","sounds\ghost2.ogg","sounds\ghost3.ogg"];

//get area directly behind player
private _dir = [_player] call DHO_fnc_getBehindPlayer;

//randomize direction to be anywhere sort of behind player
private _dir = _dir + random(180)-90;

//play sound (mp safe)
playSound3D [getMissionPath _theSound, _player, false,_player getPos [10,_dir],3]; 

//debug***
diag_log format ["BehindSound: Played sound %1 behind player %2.",_theSound,_player];