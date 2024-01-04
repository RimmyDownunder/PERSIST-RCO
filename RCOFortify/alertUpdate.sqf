_items = items player;

if ("ACE_Fortify" in _items) then {
sleep 3;

private _playerSidePicked = side player;
_currentFortifyList = "";
_currentFortifyList = missionNamespace getVariable [format ["rimmy_camp_var_fortifyListUpdate_%1", (str _playerSidePicked)],"Failed, error in Alert Update"];

hint format ["List updated. Current list: %1", _currentFortifyList];
};