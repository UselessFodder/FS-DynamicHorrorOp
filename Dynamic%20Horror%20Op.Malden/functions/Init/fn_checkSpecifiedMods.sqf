//checks if the following mods are loaded for use in the map
//*** Unit Mods
params["_modArray"];

//***debug***
diag_log format ["Passed in _modArray = %1", _modArray];

//check if certain mods are specified
if (1 in _modArray) then {
	DevourerKings = isClass(configFile >> "cfgPatches" >> "dev_mutant_common");
	if (DevourerKings) then {
		execVM "mods\DevourerKings.sqf";
		//debug***
		diag_log "DevourerKings loaded...";
	} else {
		//if mod not loaded, note in log as error
		diag_log "** ERROR: Mod DevourerKings not loaded!**";
	};
};

Diwakos = False;

if (2 in _modArray) then {
	Drongos = isClass(configFile >> "cfgPatches" >> "DSA_Spooks"); //DSA_Spooks
	if (Drongos) then {
		execVM "mods\Drongos.sqf";
		//debug***
		diag_log "Drongos loaded...";
	 }else {
		//if mod not loaded, note in log as error
		diag_log "** ERROR: Mod Drongos not loaded!**";
	};
};

if (3 in _modArray) then {
	Webknights = isClass(configFile >> "cfgPatches" >> "WBK_ZombieCreatures");
	if (Webknights) then {
		execVM "mods\Webknights.sqf";
		//debug***
		diag_log "Webknights loaded...";
	}else {
		//if mod not loaded, note in log as error
		diag_log "** ERROR: Mod Webknights not loaded!**";
	};
};

if (4 in _modArray) then {
	RyansZD = isClass(configFile >> "cfgPatches" >> "Ryanzombies"); //Ryanzombies
	if (RyansZD) then {
		execVM "mods\RyansZD.sqf";
		//debug***
		diag_log "RyansZD loaded...";
	}else {
		//if mod not loaded, note in log as error
		diag_log "** ERROR: Mod RyansZD not loaded!**";
	};
};

if (5 in _modArray) then {
	EmpiresOfOld = isClass(configFile >> "cfgPatches" >> "Empires_Of_Old_Mod");
	if (EmpiresOfOld) then {
		execVM "mods\EmpiresOfOld.sqf";
		//debug***
		diag_log "Empires of Old loaded...";
	}else {
		//if mod not loaded, note in log as error
		diag_log "** ERROR: Mod EmpiresOfOld not loaded!**";
	};
};

if (6 in _modArray) then {
	Ravage = isClass(configFile >> "cfgPatches" >> "rvg_zeds"); //rvg_zeds
	if (Ravage) then {
		execVM "mods\Ravage.sqf";
		//debug***
		diag_log "Ravage loaded...";
	}else {
		//if mod not loaded, note in log as error
		diag_log "** ERROR: Mod Ravage not loaded!**";
	};
};

if (7 in _modArray) then {
	TheCorporation = isClass(configFile >> "cfgPatches" >> "DVK_tcf_B_C");
	if (TheCorporation) then {
		execVM "mods\TheCorporation.sqf";
		//debug***
		diag_log "The Corporation loaded...";
	}else {
		//if mod not loaded, note in log as error
		diag_log "** ERROR: Mod TheCorporation not loaded!**";
	};
};

if (8 in _modArray) then {
	Alien = isClass(configFile >> "cfgPatches" >> "max_alien"); //max_alien
	if (Alien) then {
		execVM "mods\Alien.sqf";
		//debug***
		diag_log "Alien loaded...";
	}else {
		//if mod not loaded, note in log as error
		diag_log "** ERROR: Mod Max_Alien not loaded!**";
	};
};

if (9 in _modArray) then {
	Werewolf = isClass(configFile >> "cfgPatches" >> "Max_WW"); //Max_WW
	if (Werewolf) then {
		execVM "mods\Werewolf.sqf";
		//debug***
		diag_log "Werewolf loaded...";
	}else {
		//if mod not loaded, note in log as error
		diag_log "** ERROR: Mod Max_Warewolf not loaded!**";
	};
};

if (10 in _modArray) then {
	FAP = isClass(configFile >> "cfgPatches" >> "zetaborn"); //zetaborn
	if (FAP) then {
		execVM "mods\Zetaborn.sqf";
		//debug***
		diag_log "Zetaborn Alienz loaded...";
	}else {
		//if mod not loaded, note in log as error
		diag_log "** ERROR: Mod Foes and Allies Aliens not loaded!**";
	};
};

SPEZombies = False;

NWTS = False;

SCPFoundation = False;

WHSkeletons = False;


//*** Object Mods
HorrorMod = isClass(configFile >> "cfgPatches" >> "Horror_Props_pat");//Horror_Props_pat
if (HorrorMod) then {
	execVM "mods\HorrorMod.sqf";
	//debug***
	diag_log "HorrorMod loaded...";
};

AliasNightFX = False;
//BG21 = False;
RootsAnomaliesZeus = False;
Cytech = isClass(configFile >> "cfgPatches" >> "Cytech_Scientific_Devices"); //Cytech_Scientific_Devices
if (Cytech) then {
	execVM "mods\Cytech.sqf";
	//debug***
	diag_log "Cytech loaded...";
};

AtmosphericMusic = False;

sleep 1;
//when done, notify spawners pools are available
PoolsLoaded = true;
publicVariable "PoolsLoaded";

//log***
diag_log format ["All EnemyPools loaded. Current pools: %1, \n %2",EnemySpawnPool, EnemySpawnBoss];