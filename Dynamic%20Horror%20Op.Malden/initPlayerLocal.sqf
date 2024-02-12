// Add the event handler for the arsenal closing
[missionNamespace,"arsenalClosed", {
    // Save the unit's loadout when the arsenal is closed
    player setVariable ["savedLoadout", getUnitLoadout player];
}] call BIS_fnc_addScriptedEventHandler;

//check if ace is loaded
if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
	["ace_arsenal_displayClosed", {
		// Save the unit's loadout when the arsenal is closed
		player setVariable ["savedLoadout", getUnitLoadout player];
	}] call CBA_fnc_addEventHandler;
};