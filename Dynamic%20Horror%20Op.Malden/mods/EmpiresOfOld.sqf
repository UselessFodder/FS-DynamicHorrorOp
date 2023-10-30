//if mod is loaded, add units and/or objects

//public spawning pools: EnemySpawnPool EnemySpawnBoss

//[classname,points]
private _toAddPool = 
[
	["EoO_Fant_Skeleton_Unit_1",1],
	["EoO_Fant_Skeleton_Unit_2",1],
	["Skeleton_Thrall",1],
	["Skeleton_Thrall_Armored",1],
	["EoO_Fant_Skeleton_Unit_1",1],
	["EoO_Fant_Skeleton_Unit_2",1],
	["Skeleton_Thrall",1],
	["Skeleton_Thrall_Armored",1],
	["EoO_Fant_Skeleton_Unit_1",1],
	["EoO_Fant_Skeleton_Unit_2",1],
	["Skeleton_Thrall",1],
	["Skeleton_Thrall_Armored",1],
	["EoO_Fant_Skeleton_Unit_3",3],
	["Skeleton_Bomber",3],
	["Skeleton_GraveGuard",3],
	["Skeleton_GraveGuard_GreatWeapon",3],
	["Skeleton_Wraith",8],
	["Vampire_Bloodknight",8],
	["Skeleton_Necromancer",8]

];

//add into EnemySpawnPool
for "_i" from 0 to (count _toAddPool)-1 do {
	EnemySpawnPool pushBack (_toAddPool select _i);
};

private _toAddBoss = 
[
	["Skeleton_Wraith",1],
	["Vampire_Bloodknight",1],
	["Skeleton_Necromancer",3]

];

//add into EnemySpawnPool
for "_i" from 0 to (count _toAddBoss)-1 do {
	EnemySpawnBoss pushBack (_toAddBoss select _i);
};

DestroyItems pushBack ["TBannerSyl"];