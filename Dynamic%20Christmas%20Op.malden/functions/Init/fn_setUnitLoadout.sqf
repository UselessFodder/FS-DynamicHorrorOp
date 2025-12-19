/*
	Description: This script saves the calling player's loadout, then takes the loadout from a targeted unit and 
		applies it the calling player so they can modify the loadout in the arsenal. Finally, when the arsenal is
		closed, the modified loadout is applied to the targeted unit and the player's loadout is restored.
		
	Use: This script is called by an addAction applied to the friendly AI units at mission start
	
	Called by: An addAction defined on the targetUnit i.e. 
		_actionID = this addAction [
			"Modify Loadout", {
				[_this_select 0, _this select 1, _this select 2, _this select 3]] remoteExec ['DHO_fnc_setUnitLoadout', _this select 1]
			}
		]; 
		
	Calls: none
	Called on: Calling player locally
	Parameters: 0: targetted unit
				1: calling player (local)
				2: unused
				3: unused
	Return: none
*/

params ["_currentUnit", "_currentPlayer", "_actionId", "_arguments"];

//save loadout and target unit to player for reference within the eventhandler
_currentPlayer setVariable ["_tempLoadout", getUnitLoadout _currentPlayer];
_currentPlayer setVariable ["_tempUnit", _currentUnit];

//add EH to apply changes made in arsenal
[missionNamespace,"arsenalClosed", {
	_currentUnit = player getVariable ["_tempUnit", []];
	_tempLoadout = player getVariable ["_tempLoadout", []];
	_currentUnit setUnitLoadout (getUnitLoadout player);
    player setUnitLoadout _tempLoadout; 
	
	//remove this EH
	[missionNamespace,"arsenalClosed", _thisScriptedEventHandler] call BIS_fnc_removeScriptedEventHandler;
}] call BIS_fnc_addScriptedEventHandler;

//after EH is applied, change to target unit's loadout and open arsenal
_currentPlayer setUnitLoadout (getUnitLoadout _currentUnit);
["Open", [true]] call BIS_fnc_arsenal;

