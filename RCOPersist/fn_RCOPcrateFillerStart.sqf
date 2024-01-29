_module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};

private ["_playerLoadoutChoicePass","_medicalLoadChoicePass","_hungerLoadChoicePass","_markerLoadChoicePass"];

_playerLoadoutChoice = _module getVariable "RCOP_PlayerLoadout";
_medicalLoadChoice = _module getVariable "RCOP_LoadMedical";
_hungerLoadChoice = _module getVariable "RCOP_LoadHunger";
_markerLoadChoice = _module getVariable "RCOP_LoadMarker";
_JIPChoice = _module getVariable "RCOP_JIPLoadout";

sleep 1;

if (isNil "_playerLoadoutChoice") then {_playerLoadoutChoicePass = 0;} else {_playerLoadoutChoicePass = _playerLoadoutChoice;};
if (_medicalLoadChoice) then {_medicalLoadChoicePass = 1;} else {_medicalLoadChoicePass = 0;};
if (_hungerLoadChoice) then {_hungerLoadChoicePass = 1;} else {_hungerLoadChoicePass = 0;};
if (_markerLoadChoice) then {_markerLoadChoicePass = 1;} else {_markerLoadChoicePass = 0;};
if (_JIPChoice) then {_JIPChoice = true;} else {_JIPChoice = false;};

sleep 3;

"Starting PERSIST loading..." remoteExec ["hint",0];
sleep 0.1;


[[_playerLoadoutChoicePass,_medicalLoadChoicePass,_hungerLoadChoicePass,_markerLoadChoicePass,_JIPChoice],"RCOP\RCOPersist\RCOPcrateFiller.sqf"] remoteExec ["execVM",0];