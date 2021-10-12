params ["_oldSlot"];
if (isNil "_oldSlot") then { _oldSlot = true; };

RCOPsaveComplete = 0;

hint "Starting PERSIST save.";

if (isPlayer player) then {
	_markerData = [];
	_markerData = call RCOP_fnc_RCOPsavingMarkers;

	player setVariable ["rimmy_camp_var_markerPass",_markerData,true];
	};

hint "Your map data has been saved.";

sleep 3;

if (isServer) then {

	{if (count units _x == 0) then {deleteGroup _x}} forEach allGroups;
	
	_recGroupLeaderSide = [];
	_recGroupLocation = [];
	_recGroupVehicle = [];
	_recGroupLeader = [];
	_recGroupLeaderType = [];
	_recGroupCallsign = [];
	_recGroupNumbers = [];
	_recContainerArray = [];
	_fobAnchorLoc = [];
	_list = [];
	_finalPass = [];
	_finalMinePass = [];
	_finalCrateCargo = [];
	_finalCratePass = [];
	_finalCrateStats = [];	
	_vehicleDamage = [];
	_vehicleTurrets = [];
	_crateBudget = [];
	_FOBMarker = rimmy_camp_var_FOBMarker;
	_permittedObjects = rimmy_camp_var_permittedFOBObjects;
	_cratesToSave = rimmy_camp_var_cratesToSave;
	_permittedMines = rimmy_camp_var_permittedMines;
	fobDeleteBlockerGlobal = rimmy_camp_var_fobDeleteBlocker;
	
	if (_FOBMarker == "") then {_FOBMarker = "Land_PortableCabinet_01_closed_black_F";};
	if (_permittedObjects isEqualTo []) then {_permittedObjects= ["Land_BagFence_Long_F","Land_BagBunker_Small_F","Land_Plank_01_4m_F","Land_PortableCabinet_01_closed_black_F"];};
	if (_cratesToSave isEqualTo []) then {_cratesToSave = ["B_supplyCrate_F","B_Truck_01_box_F"];};
	if (_permittedMines isEqualTo []) then {_permittedMines = ["ATMine_Range_Ammo","APERSMine_Range_Ammo"];};

	FOBMarkerGlobal = _FOBMarker;
	finalPassGlobal = [];
	FOBAnchorLocGlobal = [];
	finalMinePassGlobal = [];
	recGroupLeaderSideGlobal = [];
	recGroupLocationGlobal = [];
	recGroupVehicleGlobal = [];
	recGroupLeaderTypeGlobal = [];
	recGroupCallsignGlobal = [];
	recGroupNumbersGlobal = [];
	finalCrateCargoGlobal = [];
	finalCratePassGlobal = [];
	finalCrateBudgetGlobal = [];
	finalCrateStatsGlobal = [];
	
	{
	{ 
	_x setVariable ["rimmy_camp_var_checkIfAlreadySaved", 0, true];
	} forEach allMissionObjects _x; 
	} forEach _permittedObjects; 
	 
	{	
	
	_list = nearestObjects [getPosATL _x, _permittedObjects, 100]; 
	
	{ 
	if ((_x getVariable "rimmy_camp_var_checkIfAlreadySaved") != 1) then {
	_midBuildType = typeOf _x;
	_midBuildLoc = getPosATL _x; 
	_midBuildDir = vectorDir _x; 
	_midBuildUp = vectorUp _x;  
	_x setVariable ["rimmy_camp_var_checkIfAlreadySaved", 1, true];
	_finalPass pushBack [_midBuildType,_midBuildLoc,_midBuildDir,_midBuildUp]; 
	};
	} forEach _list; 
  
	finalPassGlobal = _finalPass;
	
	_FOBAnchorOrg = getPosATL _x;
	_FOBAnchorLoc pushBack _FOBAnchorOrg;
	FOBAnchorLocGlobal = _FOBAnchorLoc;
	
	} forEach allMissionObjects _FOBMarker;

	{
	_mineType = typeOf _x;
	if (_mineType in _permittedMines) then {
	_mineLoc = getPosATL _x; 
	_mineDir = vectorDir _x; 
	_mineUp = vectorUp _x;  
	_finalMinePass pushBack [_mineType,_mineLoc,_mineDir,_mineUp]; 
	
	finalMinePassGlobal = _finalMinePass;
	
	};
	} forEach allMines;
	
	{ 
	_groupLeaderSide = side leader _x;
	_recGroupLeaderSide pushBack _groupLeaderSide;
	recGroupLeaderSideGlobal = _recGroupLeaderSide;
	
	_groupLocation = getPosATL leader _x;
	_recGroupLocation pushBack _groupLocation;
	recGroupLocationGlobal = _recGroupLocation;
	
	_groupVehicle = typeOf vehicle leader _x;
	_recGroupVehicle pushBack _groupVehicle;
	recGroupVehicleGlobal = _recGroupVehicle;
	
	_groupLeaderType = typeOf leader _x;
	_recGroupLeaderType pushBack _groupLeaderType;
	recGroupLeaderTypeGlobal = _recGroupLeaderType;
	
	_groupCallsign = groupId _x;
	_recGroupCallsign pushBack _groupCallsign;
	recGroupCallsignGlobal = _recGroupCallsign;
	
	_groupNumbers = count units _x;
	_recGroupNumbers pushBack _groupNumbers;
	recGroupNumbersGlobal = _recGroupNumbers;
	} forEach allGroups;
	
	{
	{
	_crateType = typeOf _x;
	_crateLoc = getPosATL _x; 
	_crateDir = vectorDir _x; 
	_crateUp = vectorUp _x;  
	_finalCratePass pushBackUnique [_crateType,_crateLoc,_crateDir,_crateUp]; 
	finalCratePassGlobal = _finalCratePass;
	} forEach allMissionObjects _x;
	} forEach _cratesToSave;

	{
	_crateRecorder = nearestObject [(_x select 1), (_x select 0)];
	
	_magazineInCrate = MagazineCargo _crateRecorder;
	_weaponInCrate = WeaponCargo _crateRecorder; 
	_itemInCrate = ItemCargo _crateRecorder;
	
	_containerFinder = [];
	_finalContainerCargo = [];
	_containerFinder = everyContainer _crateRecorder;
	
	{
	_containerType = (_x select 0);
	_magazineInContainer = MagazineCargo (_x select 1);
	_weaponInContainer = WeaponCargo (_x select 1); 
	_itemInContainer = ItemCargo (_x select 1); 
	_finalContainerCargo pushBack [_containerType,_magazineInContainer,_weaponInContainer,_itemInContainer]; 
	} forEach _containerFinder;
	
	_finalCrateCargo pushBack [_magazineInCrate,_weaponInCrate,_itemInCrate, _finalContainerCargo]; 
	finalCrateCargoGlobal = _finalCrateCargo;
	
	if !(isNil {_crateRecorder getVariable "rimmy_camp_var_fortifyBudget"}) then {
	_crateBudget = _crateRecorder getVariable "rimmy_camp_var_fortifyBudget";
	finalCrateBudgetGlobal pushBack _crateBudget;
	} else {
	_crateBudget = -1;
	finalCrateBudgetGlobal pushBack _crateBudget;
	};
	
	_vehicleFuel = 0;
	_vehicleTurrets = [];
	
	if ((typeOf _crateRecorder) isKindOf "AllVehicles") then {
	_vehicleFuel = fuel _crateRecorder;
	_vehicleFuelCargo = _crateRecorder call ace_refuel_fnc_getFuel;
	_vehicleDamage = getAllHitPointsDamage _crateRecorder;
	_vehicleTurrets = magazinesAllTurrets _crateRecorder;	
	_vehicleAmmoCargo = _crateRecorder call ace_rearm_fnc_getSupplyCount;
	_finalCrateStats pushBack [_vehicleFuel,_vehicleFuelCargo,_vehicleDamage,_vehicleTurrets,_vehicleAmmoCargo]; 
	finalCrateStatsGlobal = _finalCrateStats;
	} else {
	_vehicleFuel = -1;
	_vehicleFuelCargo = -1;
	_vehicleAmmoCargo = -1;
	_finalCrateStats pushBack [_vehicleFuel,_vehicleFuelCargo,_vehicleDamage,_vehicleTurrets,_vehicleAmmoCargo];
	finalCrateStatsGlobal = _finalCrateStats;
	};	
	} forEach finalCratePassGlobal;

	recSavedSlotLoadout = createHashMap;
	recSavedSlotMedical = createHashMap;
	recSavedSlotHunger = createHashMap;
	recSavedSlotMarkers = createHashMap;
	
	{
	if (vehicleVarName _x != "") then {
	recSavedSlotLoadout set [vehicleVarName _x, getUnitloadout _x];
	
	if(!(isnil "ace_medical_fnc_serializeState")) then
	{
	// Function available!
	_recSavedSlotMedicalJSON = [_x] call ace_medical_fnc_serializeState;
	recSavedSlotMedical set [vehicleVarName _x, _recSavedSlotMedicalJSON];
	};
	
	_hungerNilTester = nil;
	_hungerNilTester = _x getvariable "acex_field_rations_hunger";
	if(!(isnil "_hungerNilTester")) then
	{
	// Get current thirst and hunger
	_recRationPass = [];
	_recVarThirst = _x getVariable ["acex_field_rations_thirst", 0];
	_recVarHunger = _x getVariable ["acex_field_rations_hunger", 0];
	_recRationPass pushBack _recVarThirst;
	_recRationPass pushBack _recVarHunger;	
	recSavedSlotHunger set [vehicleVarName _x, _recRationPass];
	};
	
	_slotMarkerGet = _x getVariable "rimmy_camp_var_markerPass";
	recSavedSlotMarkers set [vehicleVarName _x, _slotMarkerGet];
	};
	}forEach allPlayers;
	
	_previousSlots = profileNamespace getVariable "rimmy_camp_var_slotLoadout";
	
	if ((!isNil "_previousSlots") && _oldSlot) then {
	{
	if (!(_x in recSavedSlotLoadout)) then {
	recSavedSlotLoadout set [_x, _y];
	};
	}forEach _previousSlots;
	};


	publicVariable "FOBMarkerGlobal";
	publicVariable "finalPassGlobal";
	publicVariable "FOBAnchorLocGlobal";
	publicVariable "finalMinePassGlobal";
	publicVariable "recGroupLeaderSideGlobal";
	publicVariable "recGroupLocationGlobal";
	publicVariable "recGroupVehicleGlobal";
	publicVariable "recGroupLeaderTypeGlobal";
	publicVariable "recGroupCallsignGlobal";
	publicVariable "recGroupNumbersGlobal";
	publicVariable "finalCrateCargoGlobal";
	publicVariable "finalCratePassGlobal";
	publicVariable "finalCrateBudgetGlobal";
	publicVariable "finalCrateStatsGlobal";
	publicVariable "fobDeleteBlockerGlobal";
	publicVariable "recSavedSlotLoadout";
	publicVariable "recSavedSlotHunger";
	publicVariable "recSavedSlotMedical";
	publicVariable "recSavedSlotMarkers";

	sleep 2;

	RCOPsaveComplete = 1;
	publicVariable "RCOPsaveComplete";

};
	
waitUntil {sleep 1; RCOPsaveComplete == 1};

profileNamespace setVariable ["rimmy_camp_var_FOBMarkerForDelete", FOBMarkerGlobal];
profileNamespace setVariable ["rimmy_camp_var_recBuilding", finalPassGlobal];
profileNamespace setVariable ["rimmy_camp_var_recFOBAnchorLoc", FOBAnchorLocGlobal];
profileNamespace setVariable ["rimmy_camp_var_recMine", finalMinePassGlobal];
profileNamespace setVariable ["rimmy_camp_var_recGroupLeaderSide", recGroupLeaderSideGlobal];
profileNamespace setVariable ["rimmy_camp_var_recGroupLocation", recGroupLocationGlobal];
profileNamespace setVariable ["rimmy_camp_var_recGroupVehicle", recGroupVehicleGlobal];
profileNamespace setVariable ["rimmy_camp_var_recGroupLeaderType", recGroupLeaderTypeGlobal];
profileNamespace setVariable ["rimmy_camp_var_recGroupCallsign", recGroupCallsignGlobal];
profileNamespace setVariable ["rimmy_camp_var_recGroupNumbers", recGroupNumbersGlobal];
profileNamespace setVariable ["rimmy_camp_var_recCrateCargo", finalCrateCargoGlobal]; 
profileNamespace setVariable ["rimmy_camp_var_recCrateLocation", finalCratePassGlobal]; 
profileNamespace setVariable ["rimmy_camp_var_recCrateBudget", finalCrateBudgetGlobal]; 
profileNamespace setVariable ["rimmy_camp_var_recCrateStats", finalCrateStatsGlobal]; 
profileNamespace setVariable ["rimmy_camp_var_recFOBDeleteBlocker", fobDeleteBlockerGlobal]; 
profileNamespace setVariable ["rimmy_camp_var_slotLoadout", recSavedSlotLoadout];
profileNamespace setVariable ["rimmy_camp_var_slotHunger", recSavedSlotHunger]; 
profileNamespace setVariable ["rimmy_camp_var_slotMedical", recSavedSlotMedical]; 
profileNamespace setVariable ["rimmy_camp_var_slotMarkers", recSavedSlotMarkers]; 

_savedPlayerLoadout = getUnitLoadout player;
profileNamespace setVariable ["rimmy_camp_var_playerLoadout", _savedPlayerLoadout]; 

//if(!(isnil "ace_medical_fnc_serializeState")) then
//{
// Function available!
//_recPlayerSavedSlotMedicalJSON = [player] call ace_medical_fnc_serializeState;
//profileNamespace setVariable ["rimmy_camp_var_playerMedical", _recPlayerSavedSlotMedicalJSON]; 
//};

_hungerNilTesterPlayer = player getvariable "acex_field_rations_hunger";
if(!(isnil "_hungerNilTesterPlayer")) then
{
// Get current thirst and hunger
_recPlayerRationPass = [];
_recPlayerVarThirst = player getVariable ["acex_field_rations_thirst", 0];
_recPlayerVarHunger = player getVariable ["acex_field_rations_hunger", 0];
_recPlayerRationPass pushBack _recPlayerVarThirst;
_recPlayerRationPass pushBack _recPlayerVarHunger;	
profileNamespace setVariable ["rimmy_camp_var_playerHunger", _recPlayerRationPass]; 
};

hint "FOBs, Mines, Vehicles, Player Loadouts and Group Locations saved successfully.";