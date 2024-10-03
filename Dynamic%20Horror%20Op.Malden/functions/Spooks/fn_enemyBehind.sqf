//get location
params ["_selectedLoc"];
	
	//get all players in zone
	private _playersInZone = allPlayers select {(_x distance locationPosition _selectedLoc) < (NearRadius * 1.5) && isTouchingGround _x};
	
	//check if there are any players at runtime. If not, exit script
	if (count _playersInZone == 0) exitWith {
		diag_log format ["EnemyBehind: No players in %1. Exiting", _selectedLoc];
	};
	
	//select a random player in the zone
	private _player = selectRandom _playersInZone;
	//private _player = selectRandom allPlayers;//***DEBUG ***DELETE
	
	//select randomized sound
	private _theSound = selectRandom[
		"sounds\pianojumpscare.ogg","sounds\jump.ogg"];	
	
	//get area directly behind player
	private _dir = _player call compile preprocessFileLineNumbers "getBehindPlayer.sqf";
	private _spawnLoc = _player getPos [10,_dir];
	
	//randomize direction to be anywhere sort of behind player
	//_dir = _dir + random(180)-90;
	
	//play sound (mp safe)
	playSound3D [getMissionPath _theSound, _player, false, _spawnLoc,3]; 
	
	//select a random unit type and spawn them
	[2,[_spawnLoc], 1,false] call FS_fnc_getUnits;
	
	//create unit directly behind player
	//private _grp = [count _classnamesToSpawn, _classnamesToSpawn, _spawnType] call FS_fnc_spawnGroup;
	
	//debug***
	diag_log format ["EnemyBehind: Created %1 behind player %2.",_theSound,_player];