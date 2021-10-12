_module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};

waitUntil {sleep 1; !isNil "rimmy_camp_var_FOBMarker"};

rimmy_camp_var_fortifyFOBCentre = rimmy_camp_var_FOBMarker;

rimmy_camp_var_fortifyStation = [];
rimmy_camp_var_fortifyVehicleBig = [];
rimmy_camp_var_fortifyVehicleSmall = [];
rimmy_camp_var_fortifyObjectBig = [];
rimmy_camp_var_fortifyObjectSmall = [];

if !((_module getVariable "RCOF_Station") isEqualTo "") then {rimmy_camp_var_fortifyStation = parseSimpleArray (_module getVariable "RCOF_Station");};
if !((_module getVariable "RCOF_VehicleBig") isEqualTo "") then {rimmy_camp_var_fortifyVehicleBig = parseSimpleArray (_module getVariable "RCOF_VehicleBig");};
if !((_module getVariable "RCOF_VehicleSmall") isEqualTo "") then {rimmy_camp_var_fortifyVehicleSmall = parseSimpleArray (_module getVariable "RCOF_VehicleSmall");};
if !((_module getVariable "RCOF_ObjectBig") isEqualTo "") then {rimmy_camp_var_fortifyObjectBig = parseSimpleArray (_module getVariable "RCOF_ObjectBig");};
if !((_module getVariable "RCOF_ObjectSmall") isEqualTo "") then {rimmy_camp_var_fortifyObjectSmall = parseSimpleArray (_module getVariable "RCOF_ObjectSmall");};

rimmy_camp_var_fortifyVehicleBigMax = _module getVariable "RCOF_VehicleBigMax";
rimmy_camp_var_fortifyVehicleSmallMax = _module getVariable "RCOF_VehicleSmallMax";
rimmy_camp_var_fortifyObjectBigMax = _module getVariable "RCOF_ObjectBigMax";
rimmy_camp_var_fortifyObjectSmallMax = _module getVariable "RCOF_ObjectSmallMax";
rimmy_camp_var_fortifyBuildRange = _module getVariable "RCOF_BuildRange";
rimmy_camp_var_missionObjectAllow = _module getVariable "RCOF_AllowDelete";

if (rimmy_camp_var_fortifyVehicleBigMax == 0) then {rimmy_camp_var_fortifyVehicleBigMax = 1000;};
if (rimmy_camp_var_fortifyVehicleSmallMax == 0) then {rimmy_camp_var_fortifyVehicleSmallMax = 250;};
if (rimmy_camp_var_fortifyObjectBigMax == 0) then {rimmy_camp_var_fortifyObjectBigMax = 500;};
if (rimmy_camp_var_fortifyObjectSmallMax == 0) then {rimmy_camp_var_fortifyObjectSmallMax = 250;};
if (rimmy_camp_var_fortifyBuildRange == 0) then {rimmy_camp_var_fortifyBuildRange = 50;};

publicVariable "rimmy_camp_var_fortifyFOBCentre";
publicVariable "rimmy_camp_var_fortifyStation";
publicVariable "rimmy_camp_var_fortifyVehicleBig";
publicVariable "rimmy_camp_var_fortifyVehicleSmall";
publicVariable "rimmy_camp_var_fortifyObjectBig";
publicVariable "rimmy_camp_var_fortifyObjectSmall";
publicVariable "rimmy_camp_var_fortifyVehicleBigMax";
publicVariable "rimmy_camp_var_fortifyVehicleSmallMax";
publicVariable "rimmy_camp_var_fortifyObjectBigMax";
publicVariable "rimmy_camp_var_fortifyObjectSmallMax";
publicVariable "rimmy_camp_var_fortifyBuildRange";

_desertPreArray = _module getVariable "RCOF_DesertArray";
_woodlandPreArray = _module getVariable "RCOF_WoodlandArray";
_largePreArray = _module getVariable "RCOF_LargeArray";
_campPreArray = _module getVariable "RCOF_CampArray";
_custom1PreArray = _module getVariable "RCOF_Custom1Array";
_custom2PreArray = _module getVariable "RCOF_Custom2Array";

rimmy_camp_var_fortifyDesertArray = [];
rimmy_camp_var_fortifyWoodlandArray = [];
rimmy_camp_var_fortifyLargeArray = [];
rimmy_camp_var_fortifyCampArray = [];
rimmy_camp_var_fortifyCustom1Array = [];
rimmy_camp_var_fortifyCustom2Array = [];

if (_desertPreArray != "") then {rimmy_camp_var_fortifyDesertArray = parseSimpleArray _desertPreArray;} else {rimmy_camp_var_fortifyDesertArray = [["Land_BagFence_Long_F", 10],["Land_BagBunker_Small_F", 50],["Land_Plank_01_4m_F", 10],["Land_PortableCabinet_01_closed_black_F", 5]];};
if (_woodlandPreArray != "") then {rimmy_camp_var_fortifyWoodlandArray = parseSimpleArray _woodlandPreArray;};
if (_largePreArray != "") then {rimmy_camp_var_fortifyLargeArray = parseSimpleArray _largePreArray;};
if (_campPreArray != "") then {rimmy_camp_var_fortifyCampArray = parseSimpleArray _campPreArray;};
if (_custom1PreArray != "") then {rimmy_camp_var_fortifyCustom1Array = parseSimpleArray _custom1PreArray;};
if (_custom2PreArray != "") then {rimmy_camp_var_fortifyCustom2Array = parseSimpleArray _custom2PreArray;};

rimmy_camp_var_fortifyDesertArrayKey = [];
rimmy_camp_var_fortifyDesertArrayValue = [];
rimmy_camp_var_fortifyWoodlandArrayKey = [];
rimmy_camp_var_fortifyWoodlandArrayValue = [];
rimmy_camp_var_fortifyLargeArrayKey = [];
rimmy_camp_var_fortifyLargeArrayValue = [];
rimmy_camp_var_fortifyCampArrayKey = [];
rimmy_camp_var_fortifyCampArrayValue = [];
rimmy_camp_var_fortifyCustom1ArrayKey = [];
rimmy_camp_var_fortifyCustom1ArrayValue = [];
rimmy_camp_var_fortifyCustom2ArrayKey = [];
rimmy_camp_var_fortifyCustom2ArrayValue = [];

for "_i" from 0 to ((count rimmy_camp_var_fortifyDesertArray)-1) do {
rimmy_camp_var_fortifyDesertArrayKey pushBack ((rimmy_camp_var_fortifyDesertArray select _i) select 0);
rimmy_camp_var_fortifyDesertArrayValue pushBack ((rimmy_camp_var_fortifyDesertArray select _i) select 1);
};

if !(rimmy_camp_var_fortifyWoodlandArray isEqualTo []) then {
for "_i" from 0 to ((count rimmy_camp_var_fortifyWoodlandArray)-1) do {
rimmy_camp_var_fortifyWoodlandArrayKey pushBack ((rimmy_camp_var_fortifyWoodlandArray select _i) select 0);
rimmy_camp_var_fortifyWoodlandArrayValue pushBack ((rimmy_camp_var_fortifyWoodlandArray select _i) select 1);
};
};

if !(rimmy_camp_var_fortifyLargeArray isEqualTo []) then {
for "_i" from 0 to ((count rimmy_camp_var_fortifyLargeArray)-1) do {
rimmy_camp_var_fortifyLargeArrayKey pushBack ((rimmy_camp_var_fortifyLargeArray select _i) select 0);
rimmy_camp_var_fortifyLargeArrayValue pushBack ((rimmy_camp_var_fortifyLargeArray select _i) select 1);
};
};

if !(rimmy_camp_var_fortifyCampArray isEqualTo []) then {
for "_i" from 0 to ((count rimmy_camp_var_fortifyCampArray)-1) do {
rimmy_camp_var_fortifyCampArrayKey pushBack ((rimmy_camp_var_fortifyCampArray select _i) select 0);
rimmy_camp_var_fortifyCampArrayValue pushBack ((rimmy_camp_var_fortifyCampArray select _i) select 1);
};
};

if !(rimmy_camp_var_fortifyCustom1Array isEqualTo []) then {
for "_i" from 0 to ((count rimmy_camp_var_fortifyCustom1Array)-1) do {
rimmy_camp_var_fortifyCustom1ArrayKey pushBack ((rimmy_camp_var_fortifyCustom1Array select _i) select 0);
rimmy_camp_var_fortifyCustom1ArrayValue pushBack ((rimmy_camp_var_fortifyCustom1Array select _i) select 1);
};
};

if !(rimmy_camp_var_fortifyCustom2Array isEqualTo []) then {
for "_i" from 0 to ((count rimmy_camp_var_fortifyCustom2Array)-1) do {
rimmy_camp_var_fortifyCustom2ArrayKey pushBack ((rimmy_camp_var_fortifyCustom2Array select _i) select 0);
rimmy_camp_var_fortifyCustom2ArrayValue pushBack ((rimmy_camp_var_fortifyCustom2Array select _i) select 1);
};
};

rimmy_camp_var_fortifySide = call compile (_module getVariable "RCOF_FortifySide");

publicVariable "rimmy_camp_var_fortifyDesertArrayKey";
publicVariable "rimmy_camp_var_fortifyDesertArrayValue";
publicVariable "rimmy_camp_var_fortifyWoodlandArrayKey";
publicVariable "rimmy_camp_var_fortifyWoodlandArrayValue";
publicVariable "rimmy_camp_var_fortifyLargeArrayKey";
publicVariable "rimmy_camp_var_fortifyLargeArrayValue";
publicVariable "rimmy_camp_var_fortifyCampArrayKey";
publicVariable "rimmy_camp_var_fortifyCampArrayValue";
publicVariable "rimmy_camp_var_fortifyCustom1ArrayKey";
publicVariable "rimmy_camp_var_fortifyCustom1ArrayValue";
publicVariable "rimmy_camp_var_fortifyCustom2ArrayKey";
publicVariable "rimmy_camp_var_fortifyCustom2ArrayValue";

rimmy_camp_var_missionObjectChecker = [];
rimmy_camp_var_missionObjectChecker insert [-1, rimmy_camp_var_fortifyDesertArrayKey, true];
rimmy_camp_var_missionObjectChecker insert [-1, rimmy_camp_var_fortifyWoodlandArrayKey, true];
rimmy_camp_var_missionObjectChecker insert [-1, rimmy_camp_var_fortifyLargeArrayKey, true];
rimmy_camp_var_missionObjectChecker insert [-1, rimmy_camp_var_fortifyCampArrayKey, true];
rimmy_camp_var_missionObjectChecker insert [-1, rimmy_camp_var_fortifyCustom1ArrayKey, true];
rimmy_camp_var_missionObjectChecker insert [-1, rimmy_camp_var_fortifyCustom2ArrayKey, true];

publicVariable "rimmy_camp_var_missionObjectChecker";
publicVariable "rimmy_camp_var_missionObjectAllow";

// init done

[rimmy_camp_var_fortifySide, -1, rimmy_camp_var_fortifyDesertArray] call acex_fortify_fnc_registerObjects;

currentFortifyList = "Desert";
publicVariable "currentFortifyList";

	rimmy_camp_var_fortifyAllowers = [];

["acex_fortify_objectPlaced", {
	params ["_unit", "_side", "_object"];

	_objectLoc = getPos _object;
	
	_closest = objNull;
	_closestdist = 100000;
	_objectCost = 0;
	{
	if (_x distance _objectLoc < _closestdist) then {
	_closest = _x;
	_closestdist = _x distance _objectLoc;
	};
	} forEach rimmy_camp_var_fortifyAllowers;

	_supplyCounter = _closest getVariable "rimmy_camp_var_fortifyBudget";
	
	_objectCost = (typeOf _object) call rimmy_camp_var_fortifyCheckCost;
	
	_closest setVariable ["rimmy_camp_var_fortifyBudget", (_supplyCounter - _objectCost), true];
	
		}] call CBA_fnc_addEventHandler;
		
["acex_fortify_objectDeleted", {
	params ["_unit", "_side", "_object"];

	_objectLoc = getPos _object;
	_closest = objNull;
	_closestdist = 100000;
	{
	if (_x distance _objectLoc < _closestdist) then {
	_closest = _x;
	_closestdist = _x distance _objectLoc;
	};
	} forEach rimmy_camp_var_fortifyAllowers;
	
	if (_closestdist >= 100) then {
	"No Building Supply storage location close enough. Refund wasted." remoteExec ["hint", _unit];
	} else {
	
	_objectCost = 0;
	_supplyCounter = _closest getVariable "rimmy_camp_var_fortifyBudget";
	_supplyMax = _closest getVariable "rimmy_camp_var_fortifyBudgetMax";
	
	_objectCost = (typeOf _object) call rimmy_camp_var_fortifyCheckCost;
	
	if ((_supplyCounter + _objectCost) > _supplyMax) then {
	"Closest Building Supply storage location lacks space. Refund wasted." remoteExec ["hint", _unit];
	} else {
	_closest setVariable ["rimmy_camp_var_fortifyBudget", (_supplyCounter + _objectCost), true];	
	"Refund succeeded." remoteExec ["hint", _unit];
	};
	
	};
		}] call CBA_fnc_addEventHandler;

{
{
	_x setVariable ["rimmy_camp_var_fortifyBudget", rimmy_camp_var_fortifyVehicleBigMax, true];
	_x setVariable ["rimmy_camp_var_fortifyBudgetMax", rimmy_camp_var_fortifyVehicleBigMax, true];
	rimmy_camp_var_fortifyAllowers pushBack _x;
} forEach allMissionObjects _x;
} forEach rimmy_camp_var_fortifyVehicleBig;

{
{
	_x setVariable ["rimmy_camp_var_fortifyBudget", rimmy_camp_var_fortifyVehicleSmallMax, true];
	_x setVariable ["rimmy_camp_var_fortifyBudgetMax", rimmy_camp_var_fortifyVehicleSmallMax, true];
	rimmy_camp_var_fortifyAllowers pushBack _x;	
} forEach allMissionObjects _x;
} forEach rimmy_camp_var_fortifyVehicleSmall;

{
{
	_x setVariable ["rimmy_camp_var_fortifyBudget", rimmy_camp_var_fortifyObjectBigMax, true];
	_x setVariable ["rimmy_camp_var_fortifyBudgetMax", rimmy_camp_var_fortifyObjectBigMax, true];
	rimmy_camp_var_fortifyAllowers pushBack _x;	
} forEach allMissionObjects _x;
} forEach rimmy_camp_var_fortifyObjectBig;

{
{
	_x setVariable ["rimmy_camp_var_fortifyBudget", rimmy_camp_var_fortifyObjectSmallMax, true];
	_x setVariable ["rimmy_camp_var_fortifyBudgetMax", rimmy_camp_var_fortifyObjectSmallMax, true];
	rimmy_camp_var_fortifyAllowers pushBack _x;	
} forEach allMissionObjects _x;
} forEach rimmy_camp_var_fortifyObjectSmall;

publicVariable "rimmy_camp_var_fortifyAllowers";


{
// add ace actions

rimmy_camp_var_fortifyCheckCost = compile preprocessFile "RCOP\RCOFortify\RCOFcheckCost.sqf";

[{
	params ["_unit", "_object", "_cost"];
	_objectLoc = getPos _object;
	
	_closest = objNull;
	_closestdist = 100000;
	_objectCost = 100000;
	_finalReturn = false;
	{
	if (_x distance _objectLoc < _closestdist) then {
	_closest = _x;
	_closestdist = _x distance _objectLoc;
	};
	} forEach rimmy_camp_var_fortifyAllowers;

	_objectCost = (typeOf _object) call rimmy_camp_var_fortifyCheckCost;

	if (_closestdist < rimmy_camp_var_fortifyBuildRange) then {
	_supplyCounter = _closest getVariable "rimmy_camp_var_fortifyBudget";
	
	_finalReturn = _supplyCounter >= _objectCost;
	};
	_finalReturn
}] call acex_fortify_fnc_addDeployHandler;

fortifyStorageSubmenu = ["fortifyStorageSubmenu", "Fortify Supply", "", {}, {true}] call ace_interact_menu_fnc_createAction;

checkFortifyStorage = ["checkFortifyStorage", "Check Building Supplies", "", {
hint format ["This vehicle has %1 building supplies left.", str (_target getVariable "rimmy_camp_var_fortifyBudget")];}
, {true}] call ace_interact_menu_fnc_createAction;

changeFortifyDesert = ["changeFortifyDesert", "Change List to Desert", "", {
"RCOP\RCOfortify\listDesert.sqf" remoteExec ["execVM",2];
"RCOP\RCOfortify\alertUpdate.sqf" remoteExec ["execVM",0];
}, {currentFortifyList != "Desert"}] call ace_interact_menu_fnc_createAction;

changeFortifyWoodland = ["changeFortifyWoodland", "Change List to Woodland", "", {
"RCOP\RCOfortify\listWoodland.sqf" remoteExec ["execVM",2];
"RCOP\RCOfortify\alertUpdate.sqf" remoteExec ["execVM",0];
}, {currentFortifyList != "Woodland"}] call ace_interact_menu_fnc_createAction;

changeFortifyLarge = ["changeFortifyLarge", "Change List to Large", "", {
"RCOP\RCOfortify\listLarge.sqf" remoteExec ["execVM",2];
"RCOP\RCOfortify\alertUpdate.sqf" remoteExec ["execVM",0];
}, {currentFortifyList != "Large"}] call ace_interact_menu_fnc_createAction;

changeFortifyCamp = ["changeFortifyCamp", "Change List to Camp", "", {
"RCOP\RCOfortify\listCamp.sqf" remoteExec ["execVM",2];
"RCOP\RCOfortify\alertUpdate.sqf" remoteExec ["execVM",0];
}, {currentFortifyList != "Camp"}] call ace_interact_menu_fnc_createAction;

changeFortifyCustom1 = ["changeFortifyCustom1", "Change List to Custom 1", "", {
"RCOP\RCOfortify\listCustom1.sqf" remoteExec ["execVM",2];
"RCOP\RCOfortify\alertUpdate.sqf" remoteExec ["execVM",0];
}, {currentFortifyList != "Custom 1"}] call ace_interact_menu_fnc_createAction;

changeFortifyCustom2 = ["changeFortifyCustom2", "Change List to Custom 2", "", {
"RCOP\RCOfortify\listCustom2.sqf" remoteExec ["execVM",2];
"RCOP\RCOfortify\alertUpdate.sqf" remoteExec ["execVM",0];
}, {currentFortifyList != "Custom 2"}] call ace_interact_menu_fnc_createAction;

refillFortifyBudget = ["refillFortifyBudget", "Refill Building Supplies", "", {
_supplyRefillTypeHolder = [];
{
_supplyRefillTypeHolder pushBackUnique (typeOf _x);
} forEach rimmy_camp_var_fortifyAllowers;
{
_refillBudgetList = getPos _target nearObjects [_x, 100];
{
_supplyRefillToMax = _x getVariable "rimmy_camp_var_fortifyBudgetMax";
_x setVariable ["rimmy_camp_var_fortifyBudget", _supplyRefillToMax, true];
hint "Refilled all building supply holders within 100 metres.";
} forEach _refillBudgetList;
} forEach _supplyRefillTypeHolder;
}, {true}] call ace_interact_menu_fnc_createAction;

checkPlayerBuildingBudget = ["checkPlayerBuildingBudget", "Check Personal Supplies", "", {
hint format ["You have %1 building supplies left. The building ability will be removed if you hit 0 supplies or drop your fortify tool.", str (_target getVariable "rimmy_camp_var_fortifyBudget")];
}, {"ACE_Fortify" in items _player}] call ace_interact_menu_fnc_createAction;

addPlayerBuildingBudget = ["addPlayerBuildingBudget", "Collect Player Supplies", "", {
_player setVariable ["rimmy_camp_var_fortifyBudgetMax", 50, true];
_player setVariable ["rimmy_camp_var_fortifyBudget", 50, true];
rimmy_camp_var_fortifyAllowers pushBack _player;
publicVariable "rimmy_camp_var_fortifyAllowers";
hint "You now have 50 supplies in your backpack. Dropping the fortify tool will make them disappear.";
[_player, 1, ["ACE_SelfActions", "ACE_Equipment"], checkPlayerBuildingBudget] call ace_interact_menu_fnc_addActionToObject;
execVM "RCOP\RCOFortify\RCOFplayerSupplyPolicer.sqf";
}, {"ACE_Fortify" in items _player}] call ace_interact_menu_fnc_createAction;

checkForNewFortifyVehicles = ["checkForNewFortifyVehicles", "Add Supplies to Newly Spawned Vehicles", "", {
"RCOP\RCOFortify\RCOFcheckForNewFortifyVehicles.sqf" remoteExec ["execVM", 0, true];
hint "Checking new vehicles and objects - if they lack supplies, they'll be added along with the ACE interact options.";
}, {true}] call ace_interact_menu_fnc_createAction;

deleteMissionPlacedObject = ["deleteMissionPlacedObject", "Delete Mission Placed Object", "", {
deleteVehicle _target;
hint "You have deleted the object and recieved no refund as it was a mission object.";
}, {"ACE_Fortify" in items _player}] call ace_interact_menu_fnc_createAction;

{
	[_x, 0, ["ACE_MainActions"], fortifyStorageSubmenu] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], refillFortifyBudget] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], addPlayerBuildingBudget] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], checkForNewFortifyVehicles] call ace_interact_menu_fnc_addActionToClass;
} forEach rimmy_camp_var_fortifyStation;

[rimmy_camp_var_fortifyFOBCentre, 0, ["ACE_MainActions"], fortifyStorageSubmenu] call ace_interact_menu_fnc_addActionToClass;
[rimmy_camp_var_fortifyFOBCentre, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyDesert] call ace_interact_menu_fnc_addActionToClass;
if !(rimmy_camp_var_fortifyWoodlandArrayKey isEqualTo []) then {[rimmy_camp_var_fortifyFOBCentre, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyWoodland] call ace_interact_menu_fnc_addActionToClass;};
if !(rimmy_camp_var_fortifyLargeArrayKey isEqualTo []) then {[rimmy_camp_var_fortifyFOBCentre, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyLarge] call ace_interact_menu_fnc_addActionToClass;};
if !(rimmy_camp_var_fortifyCampArrayKey isEqualTo []) then {[rimmy_camp_var_fortifyFOBCentre, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyCamp] call ace_interact_menu_fnc_addActionToClass;};
if !(rimmy_camp_var_fortifyCustom1ArrayKey isEqualTo []) then {[rimmy_camp_var_fortifyFOBCentre, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyCustom1] call ace_interact_menu_fnc_addActionToClass;};
if !(rimmy_camp_var_fortifyCustom2ArrayKey isEqualTo []) then {[rimmy_camp_var_fortifyFOBCentre, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyCustom2] call ace_interact_menu_fnc_addActionToClass;};

{
{
	[_x, 0, ["ACE_MainActions"], fortifyStorageSubmenu] call ace_interact_menu_fnc_addActionToObject;
	[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], checkFortifyStorage] call ace_interact_menu_fnc_addActionToObject;
	[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyDesert] call ace_interact_menu_fnc_addActionToObject;
	if !(rimmy_camp_var_fortifyWoodlandArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyWoodland] call ace_interact_menu_fnc_addActionToObject;};
	if !(rimmy_camp_var_fortifyLargeArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyLarge] call ace_interact_menu_fnc_addActionToObject;};
	if !(rimmy_camp_var_fortifyCampArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyCamp] call ace_interact_menu_fnc_addActionToObject;};
	if !(rimmy_camp_var_fortifyCustom1ArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyCustom1] call ace_interact_menu_fnc_addActionToObject;};
	if !(rimmy_camp_var_fortifyCustom2ArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyCustom2] call ace_interact_menu_fnc_addActionToObject;};
} forEach allMissionObjects _x;
} forEach rimmy_camp_var_fortifyVehicleBig;

{
{
	[_x, 0, ["ACE_MainActions"], fortifyStorageSubmenu] call ace_interact_menu_fnc_addActionToObject;
	[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], checkFortifyStorage] call ace_interact_menu_fnc_addActionToObject;
	[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyDesert] call ace_interact_menu_fnc_addActionToObject;
	if !(rimmy_camp_var_fortifyWoodlandArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyWoodland] call ace_interact_menu_fnc_addActionToObject;};
	if !(rimmy_camp_var_fortifyLargeArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyLarge] call ace_interact_menu_fnc_addActionToObject;};
	if !(rimmy_camp_var_fortifyCampArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyCamp] call ace_interact_menu_fnc_addActionToObject;};
	if !(rimmy_camp_var_fortifyCustom1ArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyCustom1] call ace_interact_menu_fnc_addActionToObject;};
	if !(rimmy_camp_var_fortifyCustom2ArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyCustom2] call ace_interact_menu_fnc_addActionToObject;};
} forEach allMissionObjects _x;
} forEach rimmy_camp_var_fortifyVehicleSmall;

{
{
	[_x, 0, ["ACE_MainActions"], fortifyStorageSubmenu] call ace_interact_menu_fnc_addActionToObject;
	[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], checkFortifyStorage] call ace_interact_menu_fnc_addActionToObject;
	[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyDesert] call ace_interact_menu_fnc_addActionToObject;
	if !(rimmy_camp_var_fortifyWoodlandArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyWoodland] call ace_interact_menu_fnc_addActionToObject;};
	if !(rimmy_camp_var_fortifyLargeArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyLarge] call ace_interact_menu_fnc_addActionToObject;};
	if !(rimmy_camp_var_fortifyCampArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyCamp] call ace_interact_menu_fnc_addActionToObject;};
	if !(rimmy_camp_var_fortifyCustom1ArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyCustom1] call ace_interact_menu_fnc_addActionToObject;};
	if !(rimmy_camp_var_fortifyCustom2ArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyCustom2] call ace_interact_menu_fnc_addActionToObject;};
} forEach allMissionObjects _x;
} forEach rimmy_camp_var_fortifyObjectBig;

{
{
	[_x, 0, ["ACE_MainActions"], fortifyStorageSubmenu] call ace_interact_menu_fnc_addActionToObject;
	[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], checkFortifyStorage] call ace_interact_menu_fnc_addActionToObject;
	[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyDesert] call ace_interact_menu_fnc_addActionToObject;
	if !(rimmy_camp_var_fortifyWoodlandArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyWoodland] call ace_interact_menu_fnc_addActionToObject;};
	if !(rimmy_camp_var_fortifyLargeArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyLarge] call ace_interact_menu_fnc_addActionToObject;};
	if !(rimmy_camp_var_fortifyCampArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyCamp] call ace_interact_menu_fnc_addActionToObject;};
	if !(rimmy_camp_var_fortifyCustom1ArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyCustom1] call ace_interact_menu_fnc_addActionToObject;};
	if !(rimmy_camp_var_fortifyCustom2ArrayKey isEqualTo []) then {[_x, 0, ["ACE_MainActions", "fortifyStorageSubmenu"], changeFortifyCustom2] call ace_interact_menu_fnc_addActionToObject;};
} forEach allMissionObjects _x;
} forEach rimmy_camp_var_fortifyObjectSmall;

if (rimmy_camp_var_missionObjectAllow) then {
{
{
[_x, 0, ["ACE_MainActions"], deleteMissionPlacedObject] call ace_interact_menu_fnc_addActionToObject;
} forEach allMissionObjects _x;
} forEach rimmy_camp_var_missionObjectChecker;
};

hint "RCOP Limited Fortify Initialised...";

} remoteExec ["call", 0, true];