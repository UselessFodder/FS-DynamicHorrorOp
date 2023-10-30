//if mod is loaded, add units and/or objects

//public spawning pools: EnemySpawnPool EnemySpawnBoss

//[classname,points]
private _toAddPool = 
[
	["dvk_tcf_B_soldier",2],
	["dvk_tcf_B_hpilot",2],
	["dvk_tcf_B_exp_f",3],
	["dvk_tcf_B_off",3],
	["dvk_tcf_B_sl",3],
	["dvk_tcf_B_medic",3],
	["dvk_tcf_sf_B_sl",3],
	["dvk_tcf_B_LAT",4],
	["dvk_tcf_B_AR",4],
	["dvk_tcf_sf_B_AR",4],
	["dvk_tcf_sf_B_medic",4],
	["dvk_tcf_sf_B_soldier",4]

];

//add into EnemySpawnPool
for "_i" from 0 to (count _toAddPool)-1 do {
	EnemySpawnPool pushBack (_toAddPool select _i);
};

//publicVariable "EnemySpawnPool";

/*
private toAddBoss = 
[
	["Skeleton_Wraith",1],
	["Vampire_Bloodknight",1],
	["Skeleton_Necromancer",3]

];

//add into EnemySpawnPool
for "_i" from 0 to (count toAddBoss)-1 do {
	EnemySpawnBoss pushBack (toAddBoss select _i);
};
*/