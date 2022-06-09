private _clipboardSave = call (compile copyFromClipboard);

profileNamespace setVariable ["rimmy_camp_var_FOBMarkerForDelete", _clipboardSave select 0];
profileNamespace setVariable ["rimmy_camp_var_recBuilding", _clipboardSave select 1];
profileNamespace setVariable ["rimmy_camp_var_recFOBAnchorLoc", _clipboardSave select 2];
profileNamespace setVariable ["rimmy_camp_var_recMine", _clipboardSave select 3];
profileNamespace setVariable ["rimmy_camp_var_recGroupLeaderSide", _clipboardSave select 4];
profileNamespace setVariable ["rimmy_camp_var_recGroupLocation", _clipboardSave select 5];
profileNamespace setVariable ["rimmy_camp_var_recGroupVehicle", _clipboardSave select 6];
profileNamespace setVariable ["rimmy_camp_var_recGroupLeaderType", _clipboardSave select 7];
profileNamespace setVariable ["rimmy_camp_var_recGroupCallsign", _clipboardSave select 8];
profileNamespace setVariable ["rimmy_camp_var_recGroupNumbers", _clipboardSave select 9];
profileNamespace setVariable ["rimmy_camp_var_recCrateCargo", _clipboardSave select 10]; 
profileNamespace setVariable ["rimmy_camp_var_recCrateLocation", _clipboardSave select 11]; 
profileNamespace setVariable ["rimmy_camp_var_recCrateBudget", _clipboardSave select 12]; 
profileNamespace setVariable ["rimmy_camp_var_recCrateStats", _clipboardSave select 13]; 
profileNamespace setVariable ["rimmy_camp_var_recFOBDeleteBlocker", _clipboardSave select 14];

private _slotLoadoutKeys = [];
private _slotLoadoutValues = [];
{
_slotLoadoutKeys pushBack (_x select 0);
_slotLoadoutValues pushBack (_x select 1);
} forEach (_clipboardSave select 15);
private _slotLoadoutHashmap =  _slotLoadoutKeys createHashMapFromArray _slotLoadoutValues;

profileNamespace setVariable ["rimmy_camp_var_slotLoadout", _slotLoadoutHashmap]; 

private _slotMedicalKeys = [];
private _slotMedicalValues = [];
{
_slotMedicalKeys pushBack (_x select 0);
_slotMedicalValues pushBack (_x select 1);
} forEach (_clipboardSave select 16);
private _slotMedicalHashmap =  _slotMedicalKeys createHashMapFromArray _slotMedicalValues;

profileNamespace setVariable ["rimmy_camp_var_slotMedical", _slotMedicalHashmap];

private _slotHungerKeys = [];
private _slotHungerValues = [];
// TESTER FOR LATER
// private = _slotHungerIterate = [];
// if ((_clipboardSave select 17) isEqualTo []) then {_slotHungerIterate = [[],[]]};
{
_slotHungerKeys pushBack (_x select 0);
_slotHungerValues pushBack (_x select 1);
} forEach (_clipboardSave select 17);
private _slotHungerHashmap =  _slotHungerKeys createHashMapFromArray _slotHungerValues;

profileNamespace setVariable ["rimmy_camp_var_slotHunger", _slotHungerHashmap];
profileNamespace setVariable ["rimmy_camp_var_playerLoadout", _clipboardSave select 18]; 
profileNamespace setVariable ["rimmy_camp_var_playerHunger", _clipboardSave select 19];
profileNamespace setVariable ["rimmy_camp_var_playerMedical", _clipboardSave select 20];

private _slotMarkersKeys = [];
private _slotMarkersValues = [];
{
_slotMarkersKeys pushBack (_x select 0);
_slotMarkersValues pushBack (_x select 1);
} forEach (_clipboardSave select 21);
private _slotMarkersHashmap =  _slotMarkersKeys createHashMapFromArray _slotMarkersValues;

profileNamespace setVariable ["rimmy_camp_var_slotMarkers", _slotMarkersHashmap];
profileNamespace setVariable ["rimmy_camp_var_recDAMMinefieldLocation", _clipboardSave select 22];
profileNamespace setVariable ["rimmy_camp_var_recMineListToDelete", _clipboardSave select 23];