_module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};

_newInfo = _module getVariable "RCOP_Info";

if (isnil "rimmy_camp_endOfRoundInfo") then {
rimmy_camp_endOfRoundInfo = ["This PERSIST session is coming to a close."];
publicVariable "rimmy_camp_endOfRoundInfo";
}; 
rimmy_camp_endOfRoundInfo pushBack _newInfo;
publicVariable "rimmy_camp_endOfRoundInfo";