//if mod is loaded, add units and/or objects

//public spawning pools: EnemySpawnPool EnemySpawnBoss

//[classname,points]
private _toAddPool = 
[
	["Zombie_O_Crawler_Civ",1],
	["Zombie_O_Shambler_Civ",1],
	["Zombie_O_RA_Civ",1],
	["Zombie_O_RC_Civ",1],
	["Zombie_O_Walker_Civ",1],
	["Zombie_O_Crawler_Civ",1],
	["Zombie_O_Shambler_Civ",1],
	["Zombie_O_RA_Civ",1],
	["Zombie_O_RC_Civ",1],
	["Zombie_O_Walker_Civ",1],
	["Zombie_O_Crawler_FIA",1],
	["Zombie_O_Shambler_FIA",1],
	["Zombie_O_RA_FIA",1],
	["Zombie_O_RC_FIA",1],
	["Zombie_O_Shooter_FIA",1],
	["Zombie_O_Walker_FIA",1],
	["WBK_SpecialZombie_Corrupted_3",2],
	["Zombie_Special_OPFOR_Boomer",3],
	["Zombie_Special_OPFOR_Leaper_1",3],
	["Zombie_Special_OPFOR_Leaper_2",3],
	["Zombie_Special_OPFOR_Screamer",3]

];

//add into EnemySpawnPool
for "_i" from 0 to (count _toAddPool)-1 do {
	EnemySpawnPool pushBack (_toAddPool select _i);
};

private _toAddBoss = 
[
	["WBK_SpecialZombie_Smasher_3",5]

];

//add into EnemySpawnPool
for "_i" from 0 to (count _toAddBoss)-1 do {
	EnemySpawnBoss pushBack (_toAddBoss select _i);
};