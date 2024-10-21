//checks if the following mods are loaded for use in the map
//*** Unit Mods
DevourerKings = isClass(configFile >> "cfgPatches" >> "dev_mutant_common");
if (DevourerKings) then {
	execVM "mods\DevourerKings.sqf";
	//debug***
	diag_log "DevourerKings loaded...";
};

Diwakos = False;

Drongos = isClass(configFile >> "cfgPatches" >> "DSA_Spooks"); //DSA_Spooks
if (Drongos) then {
	execVM "mods\Drongos.sqf";
	//debug***
	diag_log "Drongos loaded...";
};

SPEZombies = False;

FAP = isClass(configFile >> "cfgPatches" >> "zetaborn"); //zetaborn & FAP
if (FAP) then {
	execVM "mods\Zetaborn.sqf";
	//debug***
	diag_log "Zetaborn Alienz loaded...";
};

Werewolf = isClass(configFile >> "cfgPatches" >> "Max_WW"); //Max_WW
if (Werewolf) then {
	execVM "mods\Werewolf.sqf";
	//debug***
	diag_log "Werewolf loaded...";
};

Alien = isClass(configFile >> "cfgPatches" >> "max_alien"); //max_alien
if (Alien) then {
	execVM "mods\Alien.sqf";
	//debug***
	diag_log "Alien loaded...";
};

NWTS = False;

Ravage = isClass(configFile >> "cfgPatches" >> "rvg_zeds"); //rvg_zeds
if (Ravage) then {
	execVM "mods\Ravage.sqf";
	//debug***
	diag_log "Ravage loaded...";
};

SCPFoundation = False;

TheCorporation = isClass(configFile >> "cfgPatches" >> "DVK_tcf_B_C");
if (TheCorporation) then {
	execVM "mods\TheCorporation.sqf";
	//debug***
	diag_log "The Corporation loaded...";
};

EmpiresOfOld = isClass(configFile >> "cfgPatches" >> "Empires_Of_Old_Mod");
if (EmpiresOfOld) then {
	execVM "mods\EmpiresOfOld.sqf";
	//debug***
	diag_log "Empires of Old loaded...";
};

WHSkeletons = False;

Webknights = isClass(configFile >> "cfgPatches" >> "WBK_ZombieCreatures");
if (Webknights) then {
	execVM "mods\Webknights.sqf";
	//debug***
	diag_log "Webknights loaded...";
};

RyansZD = isClass(configFile >> "cfgPatches" >> "Ryanzombies"); //Ryanzombies
if (RyansZD) then {
	execVM "mods\RyansZD.sqf";
	//debug***
	diag_log "RyansZD loaded...";
};


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

TTSEmissions = isClass(configfile >> "CfgPatches" >> "tts_emission"); //TTSEmissions STALKER Emissions
if (TTSEmissions) then {
	execVM "mods\TTSEmissions.sqf";
	//debug***
	diag_log "TTSEmissions loaded...";
};

sleep 1;
//when done, notify spawners pools are available
PoolsLoaded = true;
publicVariable "PoolsLoaded";

//log***
diag_log format ["All EnemyPools loaded. Current pools: %1, \n %2",EnemySpawnPool, EnemySpawnBoss];