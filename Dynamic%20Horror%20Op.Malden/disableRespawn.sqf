//disables respawn positions and allows spectator cam
//Spectator Credit: boriz @ BIS forums: https://forums.bohemia.net/forums/topic/172462-how-to-temporarily-enabledisable-player-respawn-with-a-script/

//delete all repawn points
deleteVehicle respawnPoint1;
deleteVehicle respawnPoint2;

//add event handler to players
{
	_x addEventHandler ["Killed", {
		params ["_unit", "_killer"];
		//["Initialize", [_unit, [], true, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;
		RscSpectator_allowFreeCam = true; // Free cam
		RscSpectator_allowedGroups = [BIS_grpBlue];
		["Initialize", [_unit, [], true]] call BIS_fnc_EGSpectator;
	/*
		// Register layer once
		_spectatorLayer = ["specator_layer"] call BIS_fnc_rscLayer; 

		// Disable post processing effects for spectator (Fatigue blur and such)
		BIS_fnc_feedback_allowPP = false;
		// Some variables that control spectator options
		RscSpectator_allowFreeCam = true; // Free cam
		RscSpectator_hints = [true,true,true]; // Shows the controls as hint
		// Start spectator
		_spectatorLayer cutRsc ["RscSpectator", "PLAIN"]; 
		//[] call bis_fnc_respawnspectator;
	*/
	}];
} forEach allPlayers;

