//spawn initial enemies from enemy pools and with enemy spawn values
params ["_locIndex"];

//debug***
diag_log format ["%1: Waiting for PoolsLoaded", text (SelectedLocations select _locIndex)];

//wait until pools are loaded 
waitUntil {sleep 0.5; PoolsLoaded};

//debug***
diag_log format ["%1: Now starting initSpawns", text (SelectedLocations select _locIndex)];

//precompile script to spawn units TO MOVE***
//FS_fnc_getUnits = compile preprocessFile "getUnits.sqf";

//determine if Drongo's is loaded and init module if so
_isDrongos = false;
if (isClass(configFile >> "cfgPatches" >> "DSA_Spooks")) then {
	//set for later use
	_isDrongos = true;
	
	diag_log "*** Drongo's loaded, creating DSA_Core module";
	
	//create module to force to East side
	private _moduleGrp = createGroup sideLogic;
	"DSA_Core" createUnit [
		getMarkerPos "mainBase",
		_moduleGrp,
		"
		this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true];
		this setVariable ['DSA_Debug', 'FALSE', true];
		this setVariable ['DSA_DetailedDebug', 'FALSE', true];
		this setVariable ['DSA_ReportDamage', 'TRUE', true];
		this setVariable ['DSA_RandomDelay', 1, true];
		this setVariable ['DSA_ArmourProtection', 100, true];
		this setVariable ['DSA_AttackDowned', 'TRUE', true];
		this setVariable ['DSA_ACEdamage', 'TRUE', true];
		this setVariable ['DSA_AnomalySleep', 5, true];
		this setVariable ['DSA_AnomalyRange', 7, true];
		this setVariable ['DSA_AddRating', 'FALSE', true];
		this setVariable ['DSA_DeathFX', 'TRUE', true];
		this setVariable ['DSA_ActiveIdolChance', 25, true];
		this setVariable ['DSA_AllowWater', 'FALSE', true];
		this setVariable ['DSA_Side', 'east', true];
		this setVariable ['DSA_DMPAO', 'TRUE', true];
		"
	];
};

//determine pool values amounts
private _buildingValues = floor(EnemySpawnValues * 0.25);
private _nearValues = floor(EnemySpawnValues * 0.50);
private _farValues = floor(EnemySpawnValues * 0.25);
//private _buildingSpawns = BuildingSpawns;
//clamp to ensure the the while loops don't go forever
private _numTryIterations = 5;
private _numTries = _numTryIterations;

//debug***
//diag_log format ["Values: %1, %2, %3", _buildingValues,_nearValues,_farValues];

//get logic object holding our spawns and remove spawn variables
_logicName = format["selectedLocation%1", _locIndex];
_logicObject = missionNamespace getVariable _logicName;
_buildingSpawns = _logicObject getVariable "_buildingSpawns";
_nearSpawns = _logicObject getVariable "_nearSpawns";
_farSpawns = _logicObject getVariable "_farSpawns";

//check if there are building spawns
if (count _buildingSpawns <= 0) then {
	_buildingSpawns = _nearSpawns;
	//debug***
	diag_log format ["%1: Switching from building to near spawns due to no buildings", text (SelectedLocations select _locIndex)];
};

//spawn enemies until out of value
while {_buildingValues > 0 && _numTries > 0} do {
	//debug***
	//diag_log format ["Building: Attemping iteration %1", _numTries];
	
	//debug***
	//diag_log format ["Running building spawns at value %1", _buildingValues];
	//spawn and get subtract value
	_toSubtract = [_buildingValues,_buildingSpawns, 1,false] call DHO_fnc_getUnits;
	//debug***
	//diag_log format ["Generated units at cost %1", _toSubtract];
	//decrement building values
	_buildingValues = _buildingValues - _toSubtract;
	
	if (_toSubtract < 1) then {
		//debug***
		//diag_log format ["Building: No spawns on iteration %1", _numTries];
		//decrement tries
		_numTries = _numTries - 1;
	};	
	
	//delay for computer's sake
	sleep 0.1;
};

//debug***
diag_log format ["***  %1: Building spawns complete, beginning near spawns", text (SelectedLocations select _locIndex)];

_numTries = _numTryIterations;

//spawn enemies until out of value
while {_nearValues > 0 && _numTries > 0} do {
	//debug***
	//diag_log format ["Near: Attemping iteration %1", _numTries];
	
	//spawn and get subtract value
	_toSubtract = [_nearValues,_nearSpawns] call DHO_fnc_getUnits;
	//decrement building values
	_nearValues = _nearValues - _toSubtract;
	
	if (_toSubtract < 1) then {
		//debug***
		//diag_log format ["Near: No spawns on iteration %1", _numTries];
		//decrement tries
		_numTries = _numTries - 1;
	};
	
	//delay for computer's sake
	sleep 0.1;
};

//debug***
diag_log format ["*** %1: Near spawns complete, beginning far spawns", text (SelectedLocations select _locIndex)];

_numTries = _numTryIterations;

//spawn enemies until out of value
while {_farValues > 0 && _numTries > 0} do {
	//debug***
	//diag_log format ["Far: Attemping iteration %1", _numTries];
	
	//spawn and get subtract value
	_toSubtract = [_farValues,_farSpawns] call DHO_fnc_getUnits;
	//decrement building values
	_farValues = _farValues - _toSubtract;
	
	if (_toSubtract < 1) then {
		//debug***
		//diag_log format ["Far: No spawns on iteration %1", _numTries];				
		//decrement tries
		_numTries = _numTries - 1;	
	};		
	
	//delay for computer's sake
	sleep 0.1;
};
//get all enemy groups to public variable
AllEnemyGroups = groups east;

//get all groups outside a distance from zone and save to public array and vice versa
_nearEnemyGroups = [];
_farEnemyGroups = [];

//loop through all groups and check if distance from point is > near distance
for "_i" from 0 to (count AllEnemyGroups) -1 do {
	//check if group leader is within NearRadius of marker 
	//private _leader = leader (AllEnemyGroups select _i);
	private _leader = leader (AllEnemyGroups select _i);
	private _distance = _leader distance (getMarkerPos _logicName);
	if (_distance <= NearRadius) then {
		//if it is, this is a near group
		_nearEnemyGroups pushBack (AllEnemyGroups select _i);
	} else {
		//if between near distance and max spawn distance of 750, its a far group for this spawn
		if (((_distance) >= NearRadius) && (_distance <= 750)) then {
			_farEnemyGroups pushBack (AllEnemyGroups select _i);
		};
	};
};

//make publically available
publicVariable "AllEnemyGroups";
//publicVariable "NearEnemyGroups";
//publicVariable "FarEnemyGroups";

//***DEBUG
//diag_log format ["** _nearEnemyGroups = %1", _nearEnemyGroups];
//diag_log format ["** _farEnemyGroups = %1", _farEnemyGroups];

_logicObject setVariable ["_nearEnemyGroups", _nearEnemyGroups];
_logicObject setVariable ["_farEnemyGroups", _farEnemyGroups];

//get total number of units
TotalSpawned = count units east;
publicVariable "TotalSpawned";

//debug***
diag_log format ["*** %1: All spawns complete! %2 units spawned across all zones ***", text (SelectedLocations select _locIndex),TotalSpawned];

//check if group is in anything other than EAST and, if so, put in new group
//diag_log "** Checking new group are all EAST";
{
	if ((side _x)==SIDEENEMY) then {
		//diag_log format ["* Unit %1 is in incorrect side %2. Moving to new EAST group", typeOf _x, side _x];
		[_x] joinSilent createGroup [EAST,true];
	};
}forEach allUnits;

//check if drongos is loaded and exclude from enemy list if so
// Credit for code: Drongo himself via DM (thanks bro)
if (_isDrongos) then {
	diag_log "*** Drongo's loaded, added all enemies to friendly for modded units";
	{
		if((side _x)==EAST)then{_x setVariable["dsaExclude",TRUE,TRUE]};
	}forEach allUnits;
	
}; //end if-then

//check if DevourerKings is loaded and exclude from enemy list 
// Credit for code: Devourerking23 himself via DM (thanks bro)
if (isClass(configFile >> "cfgPatches" >> "dev_mutant_common")) then {
	diag_log "*** Devourerking's loaded, added all enemies to friendly for modded units";
	{
		//diag_log format ["* Checking this unit for isMutant: %1", typeOf _x];
		if((side _x)==EAST || (side _x)==SIDEENEMY)then{
			//diag_log format ["** This unit is in side %1. Setting isMutant", side _x];
			_x setVariable ["isMutant", true, true];
		};
	}forEach allUnits;
}; //end if-then