private _playerSidePicked = side player;

[_playerSidePicked, -1, rimmy_camp_var_fortifyDefaultArray] call acex_fortify_fnc_registerObjects;

missionNamespace setVariable [format ["rimmy_camp_var_fortifyListUpdate_%1", (str _playerSidePicked)],"Default",true];