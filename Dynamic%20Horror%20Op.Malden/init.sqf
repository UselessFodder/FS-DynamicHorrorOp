if (isServer) then {
	//set global variables
	SelectedLocations = [];
	LastLocation = [0,0,0];
	CompletedLocations = 0;
	//NearSpawns = [];
	//BuildingSpawns = [];
	//FarSpawns = [];
	EnemySpawnPool = [];
	EnemySpawnBoss = [];
	PoolsLoaded = false;
	ZeusObjects = [];
	//default values to spawn enemies
	EnemySpawnValues = 60;
	//defines % enemy units remain to start chasing players
	ChaseRatio = 0.5;
	//defines area that is "near" to objective
	NearRadius = 200;
	
	//check for multiplayer params
	if(isMultiplayer) then {
		DifficultyParam = ["DifficultyParam", 2] call BIS_fnc_getParamValue;
		NumLocationParam = ["NumLocations", 1] call BIS_fnc_getParamValue;
		RespawnParam = ["RespawnParam", 0] call BIS_fnc_getParamValue;
		MissionType = ["MissionType", 1] call BIS_fnc_getParamValue;
		MissionTheme = ["MissionTheme", 0] call BIS_fnc_getParamValue;
		PrefEnemy1 = ["PrefEnemy1", 0] call BIS_fnc_getParamValue;
		PrefEnemy2 = ["PrefEnemy2", 0] call BIS_fnc_getParamValue;
		PrefEnemy3 = ["PrefEnemy3", 0] call BIS_fnc_getParamValue;
		
		if (RespawnParam == 1) then {//TODO***
		//	execVM "disableRespawn.sqf";
		};
	} else {
		//default single player values
		DifficultyParam = 2;
		NumLocationParam = selectRandom [1,1,2,2,3];
		RespawnParam = 0;
		MissionType = 1;
		MissionTheme = 1;
		PrefEnemy1 = 0;
		PrefEnemy2 = 0;
		PrefEnemy3 = 0;
	};
	
	//value to modify spawn #s for difficulty
	private _difficultyModifier = 1;
	switch (DifficultyParam) do {
		case 0:{
			_difficultyModifier = 0.5;
		};
		case 1:{
			_difficultyModifier = 0.75;
		};
		case 2:{
			_difficultyModifier = 1;
		};
		case 3:{
			_difficultyModifier = 1.5;
		};
	};	
	
	//number of locations to spawn based on params
	if (NumLocationParam == 5) then {
		NumLocations = selectRandom [1,2,3];
	} else {
		NumLocations = NumLocationParam;
	};

	//assign MissionCommander
	if(isNull leader group1) then {
		MissionCommander = leader group2;
	} else {
		MissionCommander = leader group1;
	};
	
	publicVariable "MissionCommander";
	
	
	RetrieveItems = [];
	DestroyItems = [];
	//generate possible items to Retrieve in missiontype 1
	call DHO_fnc_initRetrieveItems;
	//generate possible items to Destroy in missiontype 2
	call DHO_fnc_initDestroyItems;
	
	//if more players, increase NearRadius
	if(count allPlayers > 4) then {
		NearRadius = 200 + 10*((count allPlayers)-4);
		diag_log format ["NearRadius changed to %1 due to %2 players",NearRadius,count allPlayers];
	};
	
	//if there are more than 4 players, increase spawn values
	if (count allPlayers > 4) then {
		EnemySpawnValues = (count allPlayers) * 15;
	};
	
	//account for difficulty
	EnemySpawnValues = ceil(EnemySpawnValues * _difficultyModifier);
	
	//modify for mission vibe
	if(MissionType == 0) then {
		EnemySpawnValues = EnemySpawnValues * 0.75;
	};
	
	//check for param selections
	if (PrefEnemy1 == 0 && PrefEnemy2 == 0 && PrefEnemy3 == 0) then {
		//check if theme is selected
		if (MissionTheme == 0) then {
			//check for which mods are loaded
			call DHO_fnc_checkMods;
		} else {
			//if theme is selected, load correct mods for theme
			//1: DevourerKings,2: Drongos,3: Webknights,4: Ryan's Zombies,
			//5: Empires of Old,6: Ravage,7: The Corporation,8: Max ALIEN,
			//9: Max Werewolf,10: Foes and Allies Aliens
			
			//0:Everything, 1:Random, 2:Fantasy, 3:Undead, 4:Sci Fi, 5:Anomalous
			
			switch (MissionTheme) do {
				case 1: { call DHO_fnc_randomMods };
				case 2: { [[5,9]] call DHO_fnc_checkSpecifiedMods };
				case 3: { [[1,3,4,5,6]] call DHO_fnc_checkSpecifiedMods };
				case 4: { [[7,8,10]] call DHO_fnc_checkSpecifiedMods };
				case 5: { [[1,2,7]] call DHO_fnc_checkSpecifiedMods };
				
			};//end switch
		};
	} else {
		[[PrefEnemy1,PrefEnemy2,PrefEnemy3]] call DHO_fnc_checkSpecifiedMods;
	};
	
	for [{ private _i = 0 }, { _i < NumLocations }, { _i = _i + 1 }] do {
		//generate location
		[] spawn DHO_fnc_findLocation;
	};
	
	waitUntil {count SelectedLocations == NumLocations};
	
	//initialize all locations
	{
		[_x,_forEachIndex] spawn DHO_fnc_initLocation;
	} forEach SelectedLocations;
	
	//if single player, delete group 2
	if(!isMultiplayer) then {
		{
			deleteVehicle _x;
		} forEach units group2;
	};
	
	
	diag_log "**** Init Complete ****";
	
	//add actions to insert helicopter
	transportHeli addAction ["* Select LZ", "functions\Base\fn_selectHeliLZ.sqf", nil, 1.5, true, true, "", "_this == missionCommander && !(isEngineOn _target)", 10, false];
	transportHeli addAction ["** Begin Insertion", "functions\Base\fn_heliInsert.sqf", nil, 1.5, true, true, "", "_this == missionCommander && !(isEngineOn _target)", 10, false];
	
	//add all units to ZeusObjects - UNNEEDED DUE TO 3DEN ENHANCED
	//execVM "addToZeus.sqf";

	fnc_finalTask = {
	
		//create trigger to complete task
		_exfilTrigger = createTrigger ["EmptyDetector", LastLocation];
		_exfilTrigger setTriggerArea [600, 600, 0, false];
		_exfilTrigger setTriggerActivation ["WEST","NOT PRESENT",true];
		_exfilTrigger setTriggerStatements [
			"this && (CompletedLocations == count SelectedLocations)",
			"['taskFinal', 'SUCCEEDED'] call BIS_fnc_taskSetState;",
			""
		];

		//create endGame trigger (MP safe)***
		_endTrigger = createTrigger ["EmptyDetector", getMarkerPos "mainBase"];
		_endTrigger setTriggerStatements [
			"'taskFinal' call BIS_fnc_taskCompleted",
			"[] remoteExec ['BIS_fnc_endMission', 0, true];", 
			""
		];
		_endTrigger setTriggerTimeout [5, 5, 5,false];
	
	};


	//create trigger to generate exfil task
	_finishTrigger = createTrigger ["EmptyDetector", getMarkerPos "mainBase"];
	_finishTrigger setTriggerStatements [
		"CompletedLocations == count SelectedLocations",
		"[west, 'taskFinal', ['Time to get the hell out of here...','EXFIL',LastLocation],LastLocation,'AUTOASSIGNED'] call BIS_fnc_taskCreate; call fnc_finalTask;",
		""
	];

	

};