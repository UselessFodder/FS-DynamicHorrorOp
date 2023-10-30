//if mod is loaded, add units and/or objects

//public spawning pools: EnemySpawnPool EnemySpawnBoss

//[classname,points]
private _toAddPool = 
[
	["zombie_bolter",1],
	["zombie_runner",1],
	["zombie_runner",1],
	["zombie_runner",1],
	["zombie_walker",1],
	["zombie_walker",1],
	["zombie_walker",1],
	["zombie_walker",1],
	["zombie_walker",1]
];

//add into EnemySpawnPool
for "_i" from 0 to (count _toAddPool)-1 do {
	EnemySpawnPool pushBack (_toAddPool select _i);
};

/*
private _toAddBoss = 
[
	["DSA_Wendigo",1],
	["DSA_Hatman",1],
	["DSA_Shadowman",1],
	["DSA_Snatcher",2],
	["DSA_Mindflayer",2]

];


//add into EnemySpawnPool
for "_i" from 0 to (count _toAddBoss)-1 do {
	EnemySpawnBoss pushBack (_toAddBoss select _i);
};
/*