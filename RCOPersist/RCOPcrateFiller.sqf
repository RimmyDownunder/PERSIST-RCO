params ["_budgetChoice","_vehicleLoadChoice","_playerLoadoutChoice","_medicalLoadChoice","_hungerLoadChoice","_markerLoadChoice","_JIPChoice"];

if (isNil "_budgetChoice") then { _budgetChoice = 1; };
if (isNil "_vehicleLoadChoice") then { _vehicleLoadChoice = 1; };
if (isNil "_playerLoadoutChoice") then { _playerLoadoutChoice = 0; };
if (isNil "_medicalLoadChoice") then { _medicalLoadChoice = 0; };
if (isNil "_hungerLoadChoice") then { _hungerLoadChoice = 0; };
if (isNil "_markerLoadChoice") then { _markerLoadChoice = 0; };
if (isNil "_JIPChoice") then { _JIPChoice = false; };

detailedLoadInfoPassComplete = 0;

if ((vehicleVarName player) == "persist1") then {
crateCargoPass = [];
crateSpawnerPass = [];
crateBudgetPass = [];
crateStatsPass = [];
rimmySlotLoadout = [];
rimmySlotMedical = [];
rimmySlotHunger = [];
crateCargoPass = profileNamespace getVariable "rimmy_camp_var_recCrateCargo";	
crateSpawnerPass = profileNamespace getVariable "rimmy_camp_var_recCrateLocation";
crateBudgetPass = profileNamespace getVariable "rimmy_camp_var_recCrateBudget";
crateStatsPass = profileNamespace getVariable "rimmy_camp_var_recCrateStats";
rimmySlotLoadout = profileNamespace getVariable "rimmy_camp_var_slotLoadout"; 
rimmySlotMedical = profileNamespace getVariable "rimmy_camp_var_slotMedical"; 
rimmySlotHunger = profileNamespace getVariable "rimmy_camp_var_slotHunger";
rimmySlotMarkers = profileNamespace getVariable "rimmy_camp_var_slotMarkers"; 

publicVariable "crateCargoPass";
publicVariable "crateSpawnerPass";
publicVariable "crateBudgetPass";
publicVariable "crateStatsPass";
publicVariable "rimmySlotLoadout";
publicVariable "rimmySlotMedical";
publicVariable "rimmySlotHunger";
publicVariable "rimmySlotMarkers";
detailedLoadInfoPassComplete = 1;
publicVariable "detailedLoadInfoPassComplete";
};

waitUntil {sleep 1; detailedLoadInfoPassComplete == 1};

if (isServer) then {
	
	_crateCargo = crateCargoPass;
	_crateSpawner = crateSpawnerPass;
	_crateBudget = crateBudgetPass;
	_crateStats = crateStatsPass;

	{
	_crateToFill = nearestObject [(_x select 1), (_x select 0)];
	
	clearBackpackCargoGlobal _crateToFill;
	clearItemCargoGlobal _crateToFill;
	clearMagazineCargoGlobal _crateToFill;
	clearWeaponCargoGlobal _crateToFill;
	
	{_crateToFill addMagazineCargoGlobal [_x,1];} forEach ((_crateCargo select _forEachIndex) select 0);
	{_crateToFill addWeaponCargoGlobal [_x,1];} forEach ((_crateCargo select _forEachIndex) select 1);
	{_crateToFill addItemCargoGlobal [_x,1];} forEach ((_crateCargo select _forEachIndex) select 2);
	
	{
	if ((_x select 0) isKindOf "Bag_Base") then {
	_crateToFill addBackpackCargoGlobal [(_x select 0),1];
	};
	} forEach ((_crateCargo select _forEachIndex) select 3);
	
	_containerSelector = _forEachIndex;
	
	{
	_containerToFill = _x select 1;
	clearItemCargoGlobal _containerToFill;
	clearMagazineCargoGlobal _containerToFill;
	clearWeaponCargoGlobal _containerToFill;
	{_containerToFill addMagazineCargoGlobal [_x,1];} forEach ((((_crateCargo select _containerSelector) select 3) select _forEachIndex) select 1);
	{_containerToFill addWeaponCargoGlobal [_x,1];} forEach ((((_crateCargo select _containerSelector) select 3) select _forEachIndex) select 2);
	{_containerToFill addItemCargoGlobal [_x,1];} forEach ((((_crateCargo select _containerSelector) select 3) select _forEachIndex) select 3);
	} forEach (everyContainer _crateToFill);
	
	if (_budgetChoice == 1 && (_crateBudget select _forEachIndex) != -1) then {
	_crateToFill setVariable ["rimmy_camp_var_fortifyBudget", (_crateBudget select _forEachIndex), true];
	};

	if (_vehicleLoadChoice == 1) then {
	if ((typeOf _crateToFill) isKindOf "AllVehicles") then {
	
	_crateToFill setFuel ((_crateStats select _forEachIndex) select 0);
	[_crateToFill, ((_crateStats select _forEachIndex) select 1)] call ace_refuel_fnc_setFuel;
	
	if !(((_crateStats select _forEachIndex) select 2) isEqualTo []) then {
	_repairCounter = count (((_crateStats select _forEachIndex) select 2) select 0);
	
	for "_i" from 0 to (_repairCounter-1) do
	{
	_crateToFill setHitPointDamage [((((_crateStats select _forEachIndex) select 2) select 0) select _i), 
	((((_crateStats select _forEachIndex) select 2) select 2) select _i)];
	};
	
	};

	_vehicleTurrets = [];
	_vehicleTurrets = ((_crateStats select _forEachIndex) select 3);
	
	if !(_vehicleTurrets isEqualTo []) then {
	_magazineRemover = magazinesAllTurrets _crateToFill;
	_vehicleToEmpty = _crateToFill;
	
	{
	_vehicleToEmpty removeMagazinesTurret [(_x select 0),(_x select 1)]
	} forEach _magazineRemover;
	
	_ammoCounter = count ((_crateStats select _forEachIndex) select 3);

	for "_i" from 0 to (_ammoCounter-1) do
	{
	_crateToFill addMagazineTurret [
	((((_crateStats select _forEachIndex) select 3) select _i) select 0), 
	((((_crateStats select _forEachIndex) select 3) select _i) select 1), 
	((((_crateStats select _forEachIndex) select 3) select _i) select 2)
	]; 
	};
	};

	[_crateToFill, ((_crateStats select _forEachIndex) select 4)] call ace_rearm_fnc_setSupplyCount;
	
	};
	};
	
	}forEach _crateSpawner;
	
	
	"PERSIST Detailed Server Load Complete." remoteExec ["hint",0];
};

[[_playerLoadoutChoice,_medicalLoadChoice,_hungerLoadChoice,_markerLoadChoice,rimmySlotLoadout,rimmySlotMedical,rimmySlotHunger,rimmySlotMarkers],"RCOP\RCOPersist\RCOPplayerLoadout.sqf"] remoteExec ["execVM",0,_JIPChoice];