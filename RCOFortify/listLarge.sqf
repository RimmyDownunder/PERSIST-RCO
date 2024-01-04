private _playerSidePicked = side player;

[_playerSidePicked, -1, rimmy_camp_var_fortifyLargeArray] call acex_fortify_fnc_registerObjects;

missionNamespace setVariable [format ["rimmy_camp_var_fortifyListUpdate_%1", (str _playerSidePicked)],"Large",true];