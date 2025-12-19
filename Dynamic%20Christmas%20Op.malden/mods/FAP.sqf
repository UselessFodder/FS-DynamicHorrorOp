//if mod is loaded, add units and/or objects

//public spawning pools: EnemySpawnPool EnemySpawnBoss

//[classname,points]
private _toAddPool = 
[
	["reptile_soldier",2],
	["zetaborn_commander",3],
	["zetaborn_crew",2],
	["zetaborn_engineer",2],
	["zetaborn_healer",2],
	["zetaborn_soldier",2],
	["zetaborn_soldier_heavy",3],
	["zetaborn_soldier_at",4],
	["zetaborn_soldier_at2",3]
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