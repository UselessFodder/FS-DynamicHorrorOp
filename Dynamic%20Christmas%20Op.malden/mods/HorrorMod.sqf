//if mod is loaded, add units and/or objects

//public spawning pools: EnemySpawnPool EnemySpawnBoss

private _toAddDestroy = 
[
	"Coffin_closed", 
	"BathTub_Bloody"
];

for "_i" from 0 to (count _toAddDestroy)-1 do {
	DestroyItems pushBack (_toAddDestroy select _i);
};

private _toAddRetrieve = 
[
	"Horror_Book"
];

for "_i" from 0 to (count _toAddRetrieve)-1 do {
	RetrieveItems pushBack (_toAddRetrieve select _i);
};