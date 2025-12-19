//if mod is loaded, add units and/or objects

//public spawning pools: EnemySpawnPool EnemySpawnBoss

//[classname,points]
private _toAddPool = 
[
	["DSA_Vampire",2],
	["DSA_Abomination",3],
	["DSA_Wendigo",4],
	["DSA_Hatman",4],
	["DSA_Shadowman",4],
	["DSA_Snatcher",5],
	["DSA_Mindflayer",5]
];

//add into EnemySpawnPool
for "_i" from 0 to (count _toAddPool)-1 do {
	EnemySpawnPool pushBack (_toAddPool select _i);
};

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