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

	_unitSide = profileNamespace getVariable "rimmy_camp_var_recGroupLeaderSide";
	_unitLocs = profileNamespace getVariable "rimmy_camp_var_recGroupLocation";
	_unitVehs = profileNamespace getVariable "rimmy_camp_var_recGroupVehicle";
	_unitTypes = profileNamespace getVariable "rimmy_camp_var_recGroupLeaderType";
	_unitCallsign = profileNamespace getVariable "rimmy_camp_var_recGroupCallsign";
	_unitNums = profileNamespace getVariable "rimmy_camp_var_recGroupNumbers";
	_FOBMarker = profileNamespace getVariable "rimmy_camp_var_FOBMarkerForDelete";
	_FOBPass = profileNamespace getVariable "rimmy_camp_var_recBuilding";
	_FOBCentre = profileNamespace getVariable "rimmy_camp_var_recFOBAnchorLoc";
	_fobDeleteBlocker = profileNamespace getVariable "rimmy_camp_var_recFOBDeleteBlocker";
	_mineSpawner = profileNamespace getVariable "rimmy_camp_var_recMine";
	_crateCargo = profileNamespace getVariable "rimmy_camp_var_recCrateCargo";
	_crateSpawner = profileNamespace getVariable "rimmy_camp_var_recCrateLocation";
	
	_unitCounter = count _unitLocs;
	
	// Group Markers
	
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
	_mineType = (_x select 0); 
	_cutStringNum = _mineType find "_Range_Ammo"; 
	_minePicked = _mineType select [0, _cutStringNum];
	_deleteMines pushBackUnique _minePicked;} forEach _mineSpawner;
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
	
	_mine set3DENAttribute ["rotation",_3denAngle];
	} forEach _mineSpawner;
	
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
	
	clearBackpackCargoGlobal _crateObject;
	clearItemCargoGlobal _crateObject;
	clearMagazineCargoGlobal _crateObject;
	clearWeaponCargoGlobal _crateObject;
	
	{_crateObject addMagazineCargoGlobal [_x,1];} forEach ((_crateCargo select _forEachIndex) select 0);
	{_crateObject addItemCargoGlobal [_x,1];} forEach ((_crateCargo select _forEachIndex) select 1);
	{_crateObject addWeaponCargoGlobal [_x,1];} forEach ((_crateCargo select _forEachIndex) select 2);
	
	};
	
	}forEach _crateSpawner;
	
};