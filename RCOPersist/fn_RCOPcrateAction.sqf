_module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};

rimmy_camp_crateAction_unitSync = synchronizedObjects _module;
publicVariable "rimmy_camp_crateAction_unitSync";

{

RCOPcrateLoadACEAction = ["RCOPcrateLoadACEAction", "Fill Crates with Saved Items (For Testing)", "", {
"RCOP\RCOPersist\RCOPcrateFiller.sqf" remoteExec ["execVM",0];
}, {true}] call ace_interact_menu_fnc_createAction;

{[_x, 0, ["ACE_MainActions"], RCOPcrateLoadACEAction] call ace_interact_menu_fnc_addActionToObject;} forEach rimmy_camp_crateAction_unitSync;

} remoteExec ["call", 0, true];

sleep 1;

deleteVehicle _module;