//if mod is loaded, add units and/or objects

//public spawning pools: EnemySpawnPool EnemySpawnBoss

//[classname,points]
private _toAddPool = 
[
	["Max_WW1",6],
	["Max_WW",6],
	["Max_WW2",6]
];

//add into EnemySpawnPool
for "_i" from 0 to (count _toAddPool)-1 do {
	EnemySpawnPool pushBack (_toAddPool select _i);
};

private _toAddBoss = 
[
	["Max_WW1",2],
	["Max_WW",2],
	["Max_WW2",2]
];

//add into EnemySpawnPool
for "_i" from 0 to (count _toAddBoss)-1 do {
	EnemySpawnBoss pushBack (_toAddBoss select _i);
};