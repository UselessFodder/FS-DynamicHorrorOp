//if mod is loaded, add units and/or objects

//public spawning pools: EnemySpawnPool EnemySpawnBoss

//[classname,points]
private _toAddPool = 
[
	["dev_o_zombie_p_beggar_F_euro",1],
	["dev_o_zombie_casual_i",1],
	["dev_o_zombie_casual_5_v2_F_afro",1],
	["dev_o_zombie_smart_casual_2_F_tanoan",1],
	["dev_o_zombie_sport_1_F_euro",1],
	["dev_o_zombie_polo_2_F_afro",1],
	["dev_o_zombie_ConstructionWorker_01_Blue_F",1],
	["dev_o_zombie_engineer_i",1],
	["dev_o_zombie_p_fugitive_F_euro",1],
	["dev_o_zombie_Journalist_01_War_F",1],
	["dev_o_zombie_scientist_i",1],
	["dev_o_zombie_scientist2_i",1],
	["dev_o_zombie_scientist3_i",1],
	["dev_parasite_o",1],
	["dev_form939_o",2],
	["dev_hivemind_o",3],
	["dev_asymhuman_stage2_o",3],
	["dev_asymhuman_stage2_i",3],
	["dev_toxmut_o",8]	
];

//add into EnemySpawnPool
for "_i" from 0 to (count _toAddPool)-1 do {
	EnemySpawnPool pushBack (_toAddPool select _i);
};

private _toAddBoss = 
[
	["dev_toxmut_o",2],
	["dev_asymhuman_o",3]

];

//add into EnemySpawnPool
for "_i" from 0 to (count _toAddBoss)-1 do {
	EnemySpawnBoss pushBack (_toAddBoss select _i);
};

private _toAddDestroy = 
[
	"dev_hivemind_prop10", 
	"dev_hivemind_prop11", 
	"dev_hivemind_prop2", 
	"dev_hivemind_prop9"
];

for "_i" from 0 to (count _toAddDestroy)-1 do {
	DestroyItems pushBack (_toAddDestroy select _i);
};