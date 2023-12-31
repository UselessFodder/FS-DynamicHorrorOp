//if mod is loaded, add units and/or objects

//public spawning pools: EnemySpawnPool EnemySpawnBoss

//[classname,points]
private _toAddPool = 
[
	"RyanZombieCrawler1Opfor", 
	"RyanZombieCrawler2Opfor", 
	"RyanZombieCrawler3Opfor", 
	"RyanZombieCrawler4Opfor", 
	"RyanZombieCrawler5Opfor", 
	"RyanZombieCrawler6Opfor", 
	"RyanZombieCrawler7Opfor", 
	"RyanZombieCrawler8Opfor", 
	"RyanZombieCrawler9Opfor", 
	"RyanZombieCrawler10Opfor", 
	"RyanZombieCrawler11Opfor", 
	"RyanZombieCrawler12Opfor", 
	"RyanZombieCrawler13Opfor", 
	"RyanZombieCrawler14Opfor", 
	"RyanZombieB_Soldier_02_fOpfor", 
	"RyanZombieB_Soldier_02_f_1_1Opfor", 
	"RyanZombieB_Soldier_03_fOpfor", 
	"RyanZombieB_Soldier_03_f_1_1Opfor", 
	"RyanZombieB_Soldier_04_fOpfor", 
	"RyanZombieB_Soldier_lite_FOpfor", 
	"RyanZombieB_Soldier_lite_F_1Opfor", 
	"RyanZombieB_Soldier_02_f_1Opfor", 
	"RyanZombieC_man_1mediumOpfor", 
	"RyanZombieC_man_polo_1_FmediumOpfor", 
	"RyanZombieC_man_polo_2_FmediumOpfor", 
	"RyanZombieC_man_polo_4_FmediumOpfor", 
	"RyanZombieC_man_polo_5_FmediumOpfor", 
	"RyanZombieC_man_polo_6_FmediumOpfor", 
	"RyanZombieC_man_p_fugitive_FmediumOpfor", 
	"RyanZombieC_man_w_worker_FmediumOpfor", 
	"RyanZombieC_scientist_FmediumOpfor", 
	"RyanZombie16mediumOpfor", 
	"RyanZombie20mediumOpfor", 
	"RyanZombie24mediumOpfor", 
	"RyanZombie28mediumOpfor", 
	"RyanZombie32mediumOpfor", 
	"RyanZombieB_Soldier_02_fmediumOpfor", 
	"RyanZombieB_Soldier_02_f_1_1mediumOpfor", 
	"RyanZombieB_Soldier_03_fmediumOpfor", 
	"RyanZombieB_Soldier_03_f_1_1mediumOpfor", 
	"RyanZombieB_Soldier_04_fmediumOpfor", 
	"RyanZombieB_Soldier_lite_FmediumOpfor", 
	"RyanZombieB_Soldier_lite_F_1mediumOpfor", 
	"RyanZombieB_Soldier_02_f_1mediumOpfor", 
	"RyanZombie31Opfor", 
	"RyanZombie27Opfor", 
	"RyanZombie23Opfor", 
	"RyanZombieC_man_polo_4_FOpfor", 
	"RyanZombieC_man_polo_5_FOpfor", 
	"RyanZombieC_man_polo_6_FOpfor", 
	"RyanZombieC_man_p_fugitive_FOpfor", 
	"RyanZombieC_man_w_worker_FOpfor", 
	"RyanZombieC_man_1slowOpfor", 
	"RyanZombieC_man_polo_1_FslowOpfor", 
	"RyanZombieC_man_polo_2_FslowOpfor", 
	"RyanZombieC_man_polo_4_FslowOpfor", 
	"RyanZombieC_man_polo_5_FslowOpfor", 
	"RyanZombieC_man_polo_6_FslowOpfor", 
	"RyanZombieC_man_p_fugitive_FslowOpfor", 
	"RyanZombieC_man_w_worker_FslowOpfor", 
	"RyanZombieC_scientist_FslowOpfor", 
	"RyanZombieC_man_hunter_1_FslowOpfor", 
	"RyanZombieC_man_pilot_FslowOpfor", 
	"RyanZombieC_journalist_FslowOpfor", 
	"RyanZombieC_OrestesslowOpfor", 
	"RyanZombieC_NikosslowOpfor", 
	"RyanZombie15slowOpfor", 
	"RyanZombie16slowOpfor", 
	"RyanZombie17slowOpfor", 
	"RyanZombie18slowOpfor", 
	"RyanZombie19slowOpfor", 
	"RyanZombie20slowOpfor", 
	"RyanZombie21slowOpfor", 
	"RyanZombie22slowOpfor", 
	"RyanZombie23slowOpfor", 
	"RyanZombie24slowOpfor", 
	"RyanZombie25slowOpfor", 
	"RyanZombie26slowOpfor", 
	"RyanZombie27slowOpfor", 
	"RyanZombie28slowOpfor", 
	"RyanZombie29slowOpfor", 
	"RyanZombie30slowOpfor", 
	"RyanZombie31slowOpfor", 
	"RyanZombie32slowOpfor", 
	"RyanZombieB_Soldier_02_fslowOpfor", 
	"RyanZombieB_Soldier_02_f_1_1slowOpfor", 
	"RyanZombieB_Soldier_03_fslowOpfor", 
	"RyanZombieB_Soldier_03_f_1_1slowOpfor", 
	"RyanZombieB_Soldier_04_fslowOpfor", 
	"RyanZombieB_Soldier_lite_FslowOpfor", 
	"RyanZombieB_Soldier_lite_F_1slowOpfor", 
	"RyanZombieB_Soldier_02_f_1slowOpfor", 
	"RyanZombieSpider1Opfor", 
	"RyanZombieSpider2Opfor", 
	"RyanZombieSpider3Opfor", 
	"RyanZombieSpider4Opfor", 
	"RyanZombieSpider5Opfor", 
	"RyanZombieSpider6Opfor", 
	"RyanZombieSpider7Opfor", 
	"RyanZombieSpider8Opfor", 
	"RyanZombieC_man_1walkerOpfor", 
	"RyanZombieC_man_polo_1_FwalkerOpfor", 
	"RyanZombieC_man_polo_2_FwalkerOpfor", 
	"RyanZombieC_man_polo_4_FwalkerOpfor", 
	"RyanZombieC_man_polo_5_FwalkerOpfor", 
	"RyanZombieC_man_polo_6_FwalkerOpfor", 
	"RyanZombieC_man_p_fugitive_FwalkerOpfor", 
	"RyanZombieC_man_w_worker_FwalkerOpfor", 
	"RyanZombieC_scientist_FwalkerOpfor", 
	"RyanZombieC_man_hunter_1_FwalkerOpfor", 
	"RyanZombieC_man_pilot_FwalkerOpfor", 
	"RyanZombieC_journalist_FwalkerOpfor", 
	"RyanZombieC_OresteswalkerOpfor", 
	"RyanZombieC_NikoswalkerOpfor", 
	"RyanZombie15walkerOpfor", 
	"RyanZombie16walkerOpfor", 
	"RyanZombie17walkerOpfor", 
	"RyanZombie18walkerOpfor", 
	"RyanZombie19walkerOpfor", 
	"RyanZombie20walkerOpfor", 
	"RyanZombie21walkerOpfor", 
	"RyanZombie22walkerOpfor", 
	"RyanZombie23walkerOpfor", 
	"RyanZombie24walkerOpfor", 
	"RyanZombie25walkerOpfor", 
	"RyanZombie26walkerOpfor", 
	"RyanZombie27walkerOpfor", 
	"RyanZombie28walkerOpfor", 
	"RyanZombie29walkerOpfor", 
	"RyanZombie30walkerOpfor", 
	"RyanZombie31walkerOpfor", 
	"RyanZombie32walkerOpfor", 
	"RyanZombieB_Soldier_02_fwalkerOpfor", 
	"RyanZombieB_Soldier_02_f_1_1walkerOpfor", 
	"RyanZombieB_Soldier_03_fwalkerOpfor", 
	"RyanZombieB_Soldier_03_f_1_1walkerOpfor", 
	"RyanZombieB_Soldier_04_fwalkerOpfor", 
	"RyanZombieB_Soldier_lite_FwalkerOpfor", 
	"RyanZombieB_Soldier_lite_F_1walkerOpfor", 
	"RyanZombieB_Soldier_02_f_1walkerOpfor"
];

//add into EnemySpawnPool
for "_i" from 0 to (count _toAddPool)-1 do {
	EnemySpawnPool pushBack ([_toAddPool select _i,2]);
};

private _toAddBoss = 
[
	["RyanZombieboss1Opfor",1],
	["RyanZombieboss2Opfor",1],
	["RyanZombieboss3Opfor",1],
	["RyanZombieboss4Opfor",1],
	["RyanZombieboss5Opfor",1],
	["RyanZombieboss6Opfor",1],
	["RyanZombieboss7Opfor",1],
	["RyanZombieboss8Opfor",1],
	["RyanZombieboss9Opfor",1],
	["RyanZombieboss10Opfor",1],	
	["RyanZombieboss11Opfor",1],
	["RyanZombieboss12Opfor",1],
	["RyanZombieboss13Opfor",1],
	["RyanZombieboss14Opfor",1]

];


//add into EnemySpawnPool
for "_i" from 0 to (count _toAddBoss)-1 do {
	EnemySpawnBoss pushBack (_toAddBoss select _i);
};
