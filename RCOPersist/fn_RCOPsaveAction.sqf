_module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};

rimmy_camp_saveAction_unitSync = [];
{
   if !(_x isKindOf "Logic") then {
	rimmy_camp_saveAction_unitSync pushBack _x;
	};
} foreach (synchronizedObjects _module);

_FOBMarker = _module getVariable "RCOP_FOBMarker";
_FOBObjectsPREARRAY = _module getVariable "RCOP_FOBObjects";
_cratesToSavePREARRAY = _module getVariable "RCOP_VehicleCratesToSave";
_permittedMinesPREARRAY = _module getVariable "RCOP_permittedMines";
_fobDeleteBlocker = _module getVariable "RCOP_deleteBlocker";
_oldSlot = _module getVariable "RCOP_OldSlot";
_permittedObjects = [];
_cratesToSave = [];
_permittedMines = [];

if (isnil "rimmy_camp_endOfRoundInfo") then {rimmy_camp_endOfRoundInfo = ["This PERSIST session is coming to a close."];}; 
publicVariable "rimmy_camp_endOfRoundInfo";
rimmy_camp_var_endOfRoundInfoStore = compile preprocessFile "RCOP\RCOPersist\fn_RCOPendOfRoundInfoStore.sqf";

if (_FOBObjectsPREARRAY isEqualTo "") then {_permittedObjects = ["Land_BagFence_Long_F","Land_BagBunker_Small_F","Land_Plank_01_4m_F","Land_PortableCabinet_01_closed_black_F"]} 
else {_permittedObjects = parseSimpleArray _FOBObjectsPREARRAY;};
if (_cratesToSavePREARRAY isEqualTo "") then {_cratesToSave = ["B_supplyCrate_F","B_Truck_01_box_F"]} 
else {_cratesToSave = parseSimpleArray _cratesToSavePREARRAY;};
if (_permittedMinesPREARRAY isEqualTo "") then {_permittedMines = ["ATMine_Range_Ammo","APERSMine_Range_Ammo"]} 
else {_permittedMines = parseSimpleArray _permittedMinesPREARRAY;};
if (_FOBMarker == "") then {_FOBMarker = "Land_PortableCabinet_01_closed_black_F"}; 

sleep 2;

_connectorCount = count synchronizedObjects _module;

if (_connectorCount != 0) then {

{
    switch (typeOf _x) do {

    case "RCOP_DefineSavedFOBs": {
	waitUntil {sleep 1; !isNil {_x getVariable "rimmy_camp_var_DefineSavedFOBsVar"}};
	_permittedObjects = _x getVariable "rimmy_camp_var_DefineSavedFOBsVar";
	};      
	case "RCOP_DefineSavedCrates": {
	waitUntil {sleep 1; !isNil {_x getVariable "rimmy_camp_var_DefineSavedCratesVar"}};
	_cratesToSave = _x getVariable "rimmy_camp_var_DefineSavedCratesVar";
	};
	default {};

	};

} forEach (synchronizedObjects _module);

};

rimmy_camp_var_permittedFOBObjects = [];
rimmy_camp_var_cratesToSave = [];
rimmy_camp_var_permittedMines = [];

rimmy_camp_var_FOBMarker = _FOBMarker;
rimmy_camp_var_permittedFOBObjects = _permittedObjects;
rimmy_camp_var_cratesToSave = _cratesToSave;
rimmy_camp_var_permittedMines = _permittedMines;
rimmy_camp_var_fobDeleteBlocker = _fobDeleteBlocker;
publicVariable "rimmy_camp_var_FOBMarker";
publicVariable "rimmy_camp_var_permittedFOBObjects";
publicVariable "rimmy_camp_var_cratesToSave";
publicVariable "rimmy_camp_var_permittedMines";
publicVariable "rimmy_camp_saveAction_unitSync";
publicVariable "rimmy_camp_var_fobDeleteBlocker";

{
RCOPsaveACEAction = ["RCOPsaveACEAction", "Save Mission with PERSIST", "", {
[[_oldSlot],"RCOP\RCOPersist\RCOPsaving.sqf"] remoteExec ["execVM",0];
}, {true}] call ace_interact_menu_fnc_createAction;

{[_x, 0, ["ACE_MainActions"], RCOPsaveACEAction] call ace_interact_menu_fnc_addActionToObject;} forEach rimmy_camp_saveAction_unitSync;

RCOPinfoACEAction = ["RCOPinfoACEAction", "Display End of Mission Info", "", {
"RCOP\RCOPersist\RCOPendOfRoundInfo.sqf" remoteExec ["execVM",0];
}, {true}] call ace_interact_menu_fnc_createAction;

{[_x, 0, ["ACE_MainActions"], RCOPinfoACEAction] call ace_interact_menu_fnc_addActionToObject;} forEach rimmy_camp_saveAction_unitSync;

} remoteExec ["call", 0, true];

sleep 1;

deleteVehicle _module;