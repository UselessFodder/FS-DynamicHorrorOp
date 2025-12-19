//if mod is loaded, add units and/or objects

//public spawning pools: EnemySpawnPool EnemySpawnBoss

private _toAddDestroy = 
[
	"Land_Cyt_ChemicalContainer01", 
	"Land_Cyt_ChemicalContainer02", 
	"Land_Cyt_ChemicalContainer02_A", 
	"Land_Cyt_ChemicalContainer03", 
	"Land_Cyt_ChemicalContainer04", 
	"Land_Cyt_ChemicalContainer04C", 
	"Land_Cyt_ChemicalContainer04D", 
	"Land_Cyt_ChemicalContainer05A", 
	"Land_Cyt_ChemicalContainer05A_A", 
	"Land_Cyt_ChemicalContainer05B", 
	"Land_Cyt_ChemicalContainer05B_A", 
	"Land_Cyt_ChemicalContainer06A", 
	"Land_Cyt_ChemicalContainer06A_A", 
	"Land_Cyt_ChemicalContainer06B", 
	"Land_Cyt_ChemicalContainer06B_A", 
	"Land_Cyt_ChemicalContainer06C", 
	"Land_Cyt_ChemicalContainer06C_A", 
	"Land_Cyt_Warhead_Dirty", 
	"Land_Cyt_Warhead_Rust", 
	"Land_Cyt_Infuser_01_Catalyst_S", 
	"Land_Cyt_Infuser_02_Catalyst_S", 
	"Land_Cyt_ScientificDevice01", 
	"Land_Cyt_ScientificDevice04", 
	"Land_Cyt_Antenna"
];

for "_i" from 0 to (count _toAddDestroy)-1 do {
	DestroyItems pushBack (_toAddDestroy select _i);
};

private _toAddRetrieve = 
[
	"Land_Cyt_ChemicalContainer07A", 
	"Land_Cyt_ChemicalContainer07B", 
	"Land_Cyt_Network_Box", 
	"Land_Cyt_Sphere_Container"
];

for "_i" from 0 to (count _toAddRetrieve)-1 do {
	RetrieveItems pushBack (_toAddRetrieve select _i);
};