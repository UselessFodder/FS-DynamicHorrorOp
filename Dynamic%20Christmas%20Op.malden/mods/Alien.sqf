//if mod is loaded, add units and/or objects

//public spawning pools: EnemySpawnPool EnemySpawnBoss


//[classname,points]
private _toAddPool = 
[
	["Max_xeno",2],
	["Max_Predalien",3],
	["Max_xeno_queen",6]
];

//add into EnemySpawnPool
for "_i" from 0 to (count _toAddPool)-1 do {
	EnemySpawnPool pushBack (_toAddPool select _i);
};

private _toAddBoss = 
[
	["Max_xeno_queen",2]
];

//add into EnemySpawnPool
for "_i" from 0 to (count _toAddBoss)-1 do {
	EnemySpawnBoss pushBack (_toAddBoss select _i);
};

private _toAddDestroy = 
[
	"Max_Alien_egg"
];

for "_i" from 0 to (count _toAddDestroy)-1 do {
	DestroyItems pushBack (_toAddDestroy select _i);
};