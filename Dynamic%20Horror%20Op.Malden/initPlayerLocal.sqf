// Add the event handler for the arsenal closing
[missionNamespace,"arsenalClosed", {
    // Save the unit's loadout when the arsenal is closed
    player setVariable ["savedLoadout", getUnitLoadout player];
}] call BIS_fnc_addScriptedEventHandler;

["ace_arsenal_displayClosed", {
    // Save the unit's loadout when the arsenal is closed
    player setVariable ["savedLoadout", getUnitLoadout player];
}] call CBA_fnc_addEventHandler;
