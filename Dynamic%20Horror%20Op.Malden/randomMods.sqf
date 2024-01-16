//selects and loads a random assortment of mods

private _loadedMods = [];

DevourerKings = isClass(configFile >> "cfgPatches" >> "dev_mutant_common");
if (DevourerKings) then {
	_loadedMods pushBack 1;
};

Diwakos = False;

Drongos = isClass(configFile >> "cfgPatches" >> "DSA_Spooks"); //DSA_Spooks
if (Drongos) then {
	_loadedMods pushBack 2;
};

SPEZombies = False;

Webknights = isClass(configFile >> "cfgPatches" >> "WBK_ZombieCreatures");
if (Webknights) then {
	_loadedMods pushBack 3;
};

RyansZD = isClass(configFile >> "cfgPatches" >> "Ryanzombies"); //Ryanzombies
if (RyansZD) then {
	_loadedMods pushBack 4;
};

EmpiresOfOld = isClass(configFile >> "cfgPatches" >> "Empires_Of_Old_Mod");
if (EmpiresOfOld) then {
	_loadedMods pushBack 5;
};

NWTS = False;

Ravage = isClass(configFile >> "cfgPatches" >> "rvg_zeds"); //rvg_zeds
if (Ravage) then {
	_loadedMods pushBack 6;
};

SCPFoundation = False;

TheCorporation = isClass(configFile >> "cfgPatches" >> "DVK_tcf_B_C");
if (TheCorporation) then {
	_loadedMods pushBack 7;
};

WHSkeletons = False;

Alien = isClass(configFile >> "cfgPatches" >> "max_alien"); //max_alien
if (Alien) then {
	_loadedMods pushBack 8;
};

Werewolf = isClass(configFile >> "cfgPatches" >> "Max_WW"); //Max_WW
if (Werewolf) then {
	_loadedMods pushBack 9;
};

FAP = isClass(configFile >> "cfgPatches" >> "zetaborn"); //zetaborn
if (FAP) then {
	_loadedMods pushBack 10;
};

sleep 1;

//log***
diag_log format ["Randomized enemy pools initialized. Possible modlists: %1",_loadedMods];

//select a random number of mods from list
private _numMods = selectRandom [1,2,2,3,3];

//variable to hold the mods to pass to enemy loading script
_selectedMods = [];

//if there are only that many mods loaded, then just pass list
if (count _loadedMods <= _numMods) then {
	//log***
	diag_log format ["Selected the following %1 mods: %2",count _loadedMods,_loadedMods];

	[_loadedMods] execVM "checkSpecifiedMods.sqf";
} else {
	//if not build selection with for loop
	for [{ _i = 0 }, { _i < _numMods }, { _i = _i + 1 }] do {
		private _currentSelect = selectRandom _loadedMods;
		_selectedMods pushBack _currentSelect;
		_loadedMods - [_currentSelect];
	};
	
	//log***
	diag_log format ["Selected the following %1 mods: %2",_numMods,_selectedMods];
	
	//load enemy script
	[_selectedMods] execVM "checkSpecifiedMods.sqf";
	
};