_markerDataList = []; 
{  
private "_a";  
_a = toArray _x; 
_a resize 15; 
if (toString _a == "_USER_DEFINED #") then {
_saveInfo = _x call RCOP_fnc_RCOPmarkerToString;
_markerDataList pushBack _saveInfo;
}; 
} forEach allMapMarkers; 
	
_markerDataList