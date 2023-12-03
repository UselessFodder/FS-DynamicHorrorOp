if (isServer) then {
	//set global variables
	OperationLocations = [];
	FinalLocation = "";
	NearSpawns = [];
	BuildingSpawns = [];
	FarSpawns = [];
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
		DifficultyParam = 2;
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
	execVM "initRetrieveItems.sqf";
	//generate possible items to Destroy in missiontype 2
	execVM "initDestroyItems.sqf";
	
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
			execVM "checkMods.sqf";
		} else {
			//if theme is selected, load correct mods for theme
			//1: DevourerKings,2: Drongos,3: Webknights,4: Ryan's Zombies,
			//5: Empires of Old,6: Ravage,7: The Corporation,8: Max ALIEN,
			//9: Max Werewolf,10: Foes and Allies Aliens
			
			//0:Everything, 1:Random, 2:Fantasy, 3:Undead, 4:Sci Fi, 5:Anomalous
			
			switch (MissionTheme) do {
				case 1: { execVM "randomMods.sqf" };
				case 2: { [[5,9]] execVM "checkSpecifiedMods.sqf" };
				case 3: { [[1,3,4,5,6]] execVM "checkSpecifiedMods.sqf" };
				case 4: { [[7,8,10]] execVM "checkSpecifiedMods.sqf" };
				case 5: { [[1,2,7]] execVM "checkSpecifiedMods.sqf" };
				
			};//end switch
		};
	} else {
		[[PrefEnemy1,PrefEnemy2,PrefEnemy3]] execVM "checkSpecifiedMods.sqf";
	};

	//generate location
	execVM "findLocation.sqf";
	
	//select mission type
	//0=clear area, 1=find objects, 2=destroy object, 3=kill boss, 4=rescue
	//MissionType = floor(random(4));
	MissionType = selectRandom[0,1,2];
	//DEBUG***
	//MissionType = 1;
	
	//select enemy types
	//0=all, 1=fantasy, 2=sci fi, 3=cryptid, 4=stalker/post-apoc, 5=undead
	//TODO***
	
	//spawn enemies inside, out
	_spawnInit = execVM "initSpawns.sqf";
	
	
	//waitUntil{sleep 1;scriptDone _spawnInit};
	waitUntil{sleep 1; count (units east inAreaArray "selectedLocation") > 5;};
	
	
	//generate tasks
	execVM "createTask.sqf";
	
	//generate randomized spook noises
	execVM "soundBehind.sqf";
	
	//if single player, delete group 2
	if(!isMultiplayer) then {
		{
			deleteVehicle _x;
		} forEach units group2;
	};
	
	//add all units to ZeusObjects - UNNEEDED DUE TO 3DEN ENHANCED
	//execVM "addToZeus.sqf";




};