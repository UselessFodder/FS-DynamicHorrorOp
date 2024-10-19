//if mod is loaded, set up TTS Emissions settings

//emissions parameters
tts_emission_playerEffect = selectRandom[0,1]; // Kill or knockout unsheltered players
tts_emission_aiEffect = 1; // Knockout unsheltered
tts_emission_vehicleEffect = 4; // None
tts_emission_aircraftEffect = 0; // Lightning bolt
tts_emission_sirenType = selectRandom[0,0,1,1,2]; // Random between Classic, dramatic, and none
tts_emission_useSirenObject = false;
tts_emission_protectionEquipment = []; // Nothing can protect you outside of shelter
tts_emission_shelterTypes = ["Building", "Car", "Tank", "Air", "Ship"];
tts_emission_waveSpeed = 125;
tts_emission_approachDirection = selectRandom["N","E","S","W"]; // Can be 'N', 'E', 'S' or 'W'
tts_emission_showEmissionOnMap = true;
tts_emission_disableRain = false;

//add all enemy unit types to immune units
private _immuneUnits = "";

{
	_immuneUnits = _immuneUnits + "," + (_x select 0);
} forEach EnemySpawnPool;


{
	_immuneUnits = _immuneUnits + "," + (_x select 0);
} forEach EnemySpawnBoss;

//remove leading ,
_immuneUnits = _immuneUnits select [1, count _immuneUnits];

//***debug
diag_log format ["These unit types are now immune to Emissions: %1",_immuneUnits];

tts_emission_immuneUnits = [_immuneUnits]; // All units from enemy pools are now immune

//***DEBUG
//[] spawn tts_emission_fnc_startEmission;

