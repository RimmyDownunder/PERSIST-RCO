params ["_deleteChoice","_crateFillChoice"];

// fhcb_getEdenAngles is a function made by Ian Banks of Foxhound International. ( ianbanks@foxhound.international )
// A huge thanks to him for allowing its use within PERSIST. 

fhcb_getEdenAngles =
{
    private _direction = _this select 0;
    private _up = _this select 1;
    private _aside = _direction vectorCrossProduct _up;

    private ["_xRot", "_yRot", "_zRot"];

    if (abs (_up select 0) < 0.999999) then {
        _yRot = -asin (_up select 0);

        private _signCosY = if (cos _yRot < 0) then { -1 } else { 1 };

        _xRot = (_up select 1 * _signCosY) atan2 (_up select 2 * _signCosY);
        _zRot = (_direction select 0 * _signCosY) atan2 (_aside select 0 * _signCosY);
    } else {
        _zRot = 0;

        if (_up select 0 < 0) then {
            _yRot = 90;
            _xRot = (_aside select 1) atan2 (_aside select 2);
        } else {
            _yRot = -90;
            _xRot = (-(_aside select 1)) atan2 (-(_aside select 2));
        };
    };

    [_xRot, _yRot, _zRot]
};

if (isServer) then {

	if (isNil "_deleteChoice") then { _deleteChoice = 1; };
	if (isNil "_crateFillChoice") then { _crateFillChoice = 1; };

	private _unitSide = profileNamespace getVariable "rimmy_camp_var_recGroupLeaderSide";
	private _unitLocs = profileNamespace getVariable "rimmy_camp_var_recGroupLocation";
	private _unitVehs = profileNamespace getVariable "rimmy_camp_var_recGroupVehicle";
	private _unitTypes = profileNamespace getVariable "rimmy_camp_var_recGroupLeaderType";
	private _unitCallsign = profileNamespace getVariable "rimmy_camp_var_recGroupCallsign";
	private _unitNums = profileNamespace getVariable "rimmy_camp_var_recGroupNumbers";
	private _FOBMarker = profileNamespace getVariable "rimmy_camp_var_FOBMarkerForDelete";
	private _FOBPass = profileNamespace getVariable "rimmy_camp_var_recBuilding";
	private _FOBCentre = profileNamespace getVariable "rimmy_camp_var_recFOBAnchorLoc";
	private _fobDeleteBlocker = profileNamespace getVariable "rimmy_camp_var_recFOBDeleteBlocker";
	private _mineSpawner = profileNamespace getVariable "rimmy_camp_var_recMine";
	private _minefieldMarkerLocation = profileNamespace getVariable "rimmy_camp_var_recDAMMinefieldLocation";
	private _crateCargo = profileNamespace getVariable "rimmy_camp_var_recCrateCargo";
	private _crateBudget = profileNamespace getVariable "rimmy_camp_var_recCrateBudget";
	private _crateStats = profileNamespace getVariable "rimmy_camp_var_recCrateStats";
	private _crateSpawner = profileNamespace getVariable "rimmy_camp_var_recCrateLocation";
	private _mineListToDelete = profileNamespace getVariable "rimmy_camp_var_recMineListToDelete";
	
	private _unitCounter = count _unitLocs;
	
	// Group Markers
	
	all3DENEntities params ["_NONEEDobjects", "_NONEEDgroups", "_NONEEDtriggers", "_NONEEDsystems", "_NONEEDwaypoints", "_markersToSearchThrough", "_NONEEDlayers", "_NONEEDcomments"];
	private _minefieldMarkersToBeRemoved = [];
	{
	if ("PLANTEDMinefieldExclusionAreaMarker" in _x) then {
	_minefieldMarkersToBeRemoved pushBack _x;
	};
	if ("Side: WEST Vehicle:" in _x) then {
	_minefieldMarkersToBeRemoved pushBack _x;
	};
	if ("Side: EAST Vehicle:" in _x) then {
	_minefieldMarkersToBeRemoved pushBack _x;
	};
	if ("Side: GUER Vehicle:" in _x) then {
	_minefieldMarkersToBeRemoved pushBack _x;
	};
	if ("Side: any Vehicle:" in _x) then {
	_minefieldMarkersToBeRemoved pushBack _x;
	};
	} forEach _markersToSearchThrough;
	delete3DENEntities _minefieldMarkersToBeRemoved;
	
	for "_i" from 0 to (_unitCounter -1) do	{ 
	_groupMarker = format ["Side: %1 Vehicle: %2 Leader Type: %3 Callsign: %4 Group Size: %5", _unitSide select _i, _unitVehs select _i, _unitTypes select _i, _unitCallsign select _i, _unitNums select _i];
	_createdMarker = create3DENEntity  ["Marker", "hd_dot",_unitLocs select _i];
	_createdMarker set3DENAttribute ["text", _groupMarker];
	
	switch (_unitSide select _i) do {
    case WEST: { _createdMarker set3DENAttribute ["baseColor", "colorBLUFOR"]; };
    case EAST: { _createdMarker set3DENAttribute ["baseColor", "colorOPFOR"]; };
    case RESISTANCE: { _createdMarker set3DENAttribute ["baseColor", "colorIndependent"]; };
    case CIVILIAN: { _createdMarker set3DENAttribute ["baseColor", "colorCivilian"]; };
	case sideUNKNOWN: { 
	_markerDeleterArray = [];
	_markerDeleterArray pushBack _createdMarker; 
	delete3DENEntities _markerDeleterArray;
	};
    default {  };
	};
	};
	
	// FOB Marker + Objects
		
	if (_deleteChoice == 1) then {
	
	_deleteFOBFinder = [];
	_deleteFOBFinder2 = [];
	_deleteFOBFinder3 = [];
	
	{_deleteFOBFinder pushBackUnique (_x select 0);} forEach _FOBPass; 
	_deleteFOBFinder pushBack _fobDeleteBlocker;
	
	{
	_deleteFOBFinder2 = [];
	_deleteCentre = _x;
	{
	_deleteFOBFinder2 append ((getPosATL _deleteCentre) nearObjects [_x, 100]);
	{
	if ((_x nearObjects [_fobDeleteBlocker,100]) isEqualTo []) then 
	{
	_deleteFOBFinder3 pushBack _x;
	};	
	} forEach _deleteFOBFinder2;
	} forEach _deleteFOBFinder;
	} forEach allMissionObjects _FOBMarker;
	
	delete3DENEntities _deleteFOBFinder3;
		
	};
	
	{ 
	_createdFOBMarker = create3DENEntity  ["Marker", "hd_flag",_x];
	_createdFOBMarker set3DENAttribute ["text", "FOB Anchor"];
	_createdFOBMarker set3DENAttribute ["baseColor", "ColorBlue"];
	
	_createdFOBAreaMarker = create3DENEntity ["Trigger", "EmptyDetectorArea10x10",_x];
	_createdFOBAreaMarker set3DENAttribute ["size3", [100, 100, 50]];
	_createdFOBAreaMarker set3DENAttribute ["IsRectangle", 0];
	_createdFOBAreaMarker set3DENAttribute ["text", "FOB Anchor"];
	
	} forEach _FOBCentre;
	
	{ 
	_fobObject = create3DENEntity ["Object", (_x select 0),(_x select 1)];
	_3denAngle = [(_x select 2), (_x select 3)] call fhcb_getEdenAngles;
	
	_fobObject set3DENAttribute ["rotation",_3denAngle];
	} forEach _FOBPass;
	
	// Mines
	
	if (_deleteChoice == 1) then {
	_deleteMines = [];
	{	
	private _cutStringNum = _x find "_ammo";
	if (_cutStringNum == -1) then {_cutStringNum = _x find "_Range_Ammo"};
	if (_cutStringNum == -1) then {_cutStringNum = _x find "_Ammo"};
	
	_minePicked = _x select [0, _cutStringNum];
	_deleteMines pushBackUnique _minePicked;} forEach _mineListToDelete;
	{delete3DENEntities allMissionObjects _x;} forEach _deleteMines;
	};
	
	{
	_mineType = (_x select 0);
	_cutStringNum = _mineType find "_Range_Ammo";
	_minePicked = _mineType select [0, _cutStringNum];
	_mineAdjuster = (_x select 1);
	_mineAdjuster set [2, 0];
	_mine = create3DENEntity ["Object", _minePicked,_mineAdjuster];
	_3denAngle = [(_x select 2), (_x select 3)] call fhcb_getEdenAngles;
	private _3denMineInit = "if (isServer) then { ";
	{
	if (_x == west) then {_3denMineInit = _3denMineInit + "west revealMine this; "};
	if (_x == east) then {_3denMineInit = _3denMineInit + "east revealMine this; "};
	if (_x == resistance) then {_3denMineInit = _3denMineInit + "resistance revealMine this; "};
	} forEach (_x select 4);
	
	_3denMineInit = _3denMineInit + " };";
	_mine set3DENAttribute ["rotation",_3denAngle];
	_mine set3DENAttribute ["init",_3denMineInit];
	} forEach _mineSpawner;
	
	// DAM Minefield Load

	
	{	
	_x splitString (_x select [0,1]) params
	[
		"_markerMinefieldName", 
		"_markerMinefieldPos", 
		"_markerMinefieldType",
		"_markerMinefieldShape",
		"_markerMinefieldSize",
		"_markerMinefieldDir",
		"_markerMinefieldBrush",
		"_markerMinefieldColor",
		"_markerMinefieldAlpha",
		"_polyLineMinefieldArray",
		["_markerMinefieldText",""]
	];
	
	_markerMinefieldPosArray = parseSimpleArray _markerMinefieldPos;
	_markerMinefieldSizeArray = parseSimpleArray _markerMinefieldSize;
	_markerMinefieldAlphaNum = parseNumber _markerMinefieldAlpha;
	
	_createdDAMMinefieldMarker = create3DENEntity ["Marker", "", _markerMinefieldPosArray]; // default rectangular marker
	_createdDAMMinefieldMarker set3DENAttribute ["markerType", 1]; // 0 - rectangle; 1 - ellipse 
	_createdDAMMinefieldMarker set3DENAttribute ["size2", _markerMinefieldSizeArray];
	_createdDAMMinefieldMarker set3DENAttribute ["alpha", _markerMinefieldAlphaNum];
	_createdDAMMinefieldMarker set3DENAttribute ["baseColor","ColorYellow"];
	_createdDAMMinefieldMarker set3DENAttribute ["brush", "Solid"];
	_createdDAMMinefieldMarker set3DENAttribute ["markerName", _markerMinefieldName];
	
	
	
	} forEach _minefieldMarkerLocation;
	
	// Crates
	
	if (_deleteChoice == 1) then {
	
	_deleteCrates = [];
	_deleteCrates2 = [];
	{_deleteCrates pushBackUnique (_x select 0);} forEach _crateSpawner;
	{
	{
	if ((_x nearObjects [_fobDeleteBlocker,100]) isEqualTo []) then 
	{
	_deleteCrates2 pushBack _x;
	};	
	} forEach allMissionObjects _x;
	} forEach _deleteCrates;
	
	delete3DENEntities _deleteCrates2;
	};
	
	{
	_crateObject = create3DENEntity ["Object", (_x select 0),(_x select 1),true];
	_3denAngle = [(_x select 2), (_x select 3)] call fhcb_getEdenAngles;
	
	_crateObject set3DENAttribute ["rotation",_3denAngle];
	
	if (_crateFillChoice == 1) then {
	
	private _3denCrateInit = "if (isServer) then { ";
	_3denCrateInit = _3denCrateInit + "clearBackpackCargoGlobal this; ";
	_3denCrateInit = _3denCrateInit + "clearItemCargoGlobal this; ";
	_3denCrateInit = _3denCrateInit + "clearMagazineCargoGlobal this; ";
	_3denCrateInit = _3denCrateInit + "clearWeaponCargoGlobal this; ";
	
	{
	private _magazineInitAdd = format ['[this addMagazineCargoGlobal ["%1",1]]; ',_x];
	_3denCrateInit = _3denCrateInit + _magazineInitAdd;
	} forEach ((_crateCargo select _forEachIndex) select 0);
	
	{
	private _weaponInitAdd = format ['[this addWeaponCargoGlobal ["%1",1]]; ',_x];
	_3denCrateInit = _3denCrateInit + _weaponInitAdd;
	} forEach ((_crateCargo select _forEachIndex) select 1);
	
	{
	private _itemInitAdd = format ['[this addItemCargoGlobal ["%1",1]]; ',_x];
	_3denCrateInit = _3denCrateInit + _itemInitAdd;
	} forEach ((_crateCargo select _forEachIndex) select 2);
	
	private _containerCounter = -1;
	{
	if ((_x select 0) isKindOf "Bag_Base") then {
	private _backpackInitAdd = format ['[this addBackpackCargoGlobal ["%1",1]]; ',(_x select 0)];
	_3denCrateInit = _3denCrateInit + _backpackInitAdd;
	_containerCounter = _containerCounter + 1;
	};
	} forEach ((_crateCargo select _forEachIndex) select 3);
	
	private _currentCrateToAddContainers = _forEachIndex;
	
	if (_containerCounter >= 0) then {
		for "_i" from 0 to _containerCounter do {
			private _containerFullInitAdd = "";
			_containerFullInitAdd = _containerFullInitAdd + format ['clearItemCargoGlobal (((everyContainer this) select %1) select 1); ',_i];
			_containerFullInitAdd = _containerFullInitAdd + format ['clearMagazineCargoGlobal (((everyContainer this) select %1) select 1); ',_i];
			_containerFullInitAdd = _containerFullInitAdd + format ['clearWeaponCargoGlobal (((everyContainer this) select %1) select 1); ',_i];
			
			{
			private _backpackContentsMagazineInitAdd = format ['[(((everyContainer this) select %1) select 1) addMagazineCargoGlobal ["%2",1]]; ',_i,_x];
			_containerFullInitAdd = _containerFullInitAdd + _backpackContentsMagazineInitAdd;
			} forEach ((((_crateCargo select _currentCrateToAddContainers) select 3) select _i) select 1);
		
			{
			private _backpackContentsWeaponInitAdd = format ['[(((everyContainer this) select %1) select 1) addWeaponCargoGlobal ["%2",1]]; ',_i,_x];
			_containerFullInitAdd = _containerFullInitAdd + _backpackContentsWeaponInitAdd;
			} forEach ((((_crateCargo select _currentCrateToAddContainers) select 3) select _i) select 2);
			
			{
			private _backpackContentsItemInitAdd = format ['[(((everyContainer this) select %1) select 1) addItemCargoGlobal ["%2",1]]; ',_i,_x];
			_containerFullInitAdd = _containerFullInitAdd + _backpackContentsItemInitAdd;
			} forEach ((((_crateCargo select _currentCrateToAddContainers) select 3) select _i) select 3);
		
			_3denCrateInit = _3denCrateInit + _containerFullInitAdd;
		};
	};

	if ((_crateBudget select _forEachIndex) != -1) then {
	private _crateBudgetInitAdd = format ["[this,%1] spawn RCOP_fnc_RCOPdelaySupplyReload; ",(_crateBudget select _forEachIndex)];
	_3denCrateInit = _3denCrateInit + _crateBudgetInitAdd;
	};
	
	if ((_x select 0) isKindOf "AllVehicles") then {
	
	private _vehicleFuelInitAdd = format ["this setFuel %1; ",((_crateStats select _forEachIndex) select 0)];
	_3denCrateInit = _3denCrateInit + _vehicleFuelInitAdd;
	private _vehicleFuelStorageInitAdd = format ["[this, %1] call ace_refuel_fnc_setFuel; ",((_crateStats select _forEachIndex) select 1)];
	_3denCrateInit = _3denCrateInit + _vehicleFuelStorageInitAdd;
	
	if !(((_crateStats select _forEachIndex) select 2) isEqualTo []) then {
	_repairCounter = count (((_crateStats select _forEachIndex) select 2) select 0);	
	for "_i" from 0 to (_repairCounter-1) do
	{
	private _vehicleDamageInitAdd = format ['this setHitPointDamage ["%1",%2]; ',((((_crateStats select _forEachIndex) select 2) select 0) select _i),((((_crateStats select _forEachIndex) select 2) select 2) select _i)];
	_3denCrateInit = _3denCrateInit + _vehicleDamageInitAdd;
	};
	};

	private _vehicleTurrets = [];
	_vehicleTurrets = ((_crateStats select _forEachIndex) select 3);
	
	if !(_vehicleTurrets isEqualTo []) then {
	_3denCrateInit = _3denCrateInit + 'private _magazineRemover = magazinesAllTurrets this; {this removeMagazinesTurret [(_x select 0),(_x select 1)]} forEach _magazineRemover; ';
	
	_ammoCounter = count ((_crateStats select _forEachIndex) select 3);

	for "_i" from 0 to (_ammoCounter-1) do
	{
	private _vehicleTurretAmmoInitAdd = format ['this addMagazineTurret ["%1", %2, %3]; ',
	((((_crateStats select _forEachIndex) select 3) select _i) select 0),
	((((_crateStats select _forEachIndex) select 3) select _i) select 1),
	((((_crateStats select _forEachIndex) select 3) select _i) select 2)]; 
	_3denCrateInit = _3denCrateInit + _vehicleTurretAmmoInitAdd;
	};
	};

	private _vehicleSupplyCountInitAdd = format ["[this, %1] call ace_rearm_fnc_setSupplyCount; ",((_crateStats select _forEachIndex) select 4)];
	_3denCrateInit = _3denCrateInit + _vehicleSupplyCountInitAdd;
	
	{
	private _vehiclePylonLoadoutInitAdd = format ['this setPylonLoadout [%1,"%2",false,%3]; ',(_x select 0),(_x select 3),(_x select 2)];
	_3denCrateInit = _3denCrateInit + _vehiclePylonLoadoutInitAdd;
	private _vehicleAmmoPylonInitAdd = format ["this setAmmoOnPylon [%1,%2]; ",(_x select 0),(_x select 4)];	
	_3denCrateInit = _3denCrateInit + _vehicleAmmoPylonInitAdd;
	} forEach ((_crateStats select _forEachIndex) select 5);
	
	
	};
	_3denCrateInit = _3denCrateInit + " };";
	_crateObject set3DENAttribute ["init",_3denCrateInit];
	};
	}forEach _crateSpawner;
	
};