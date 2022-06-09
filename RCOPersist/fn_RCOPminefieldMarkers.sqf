_markerDataList = []; 
{  
if ("PLANTEDMinefieldExclusionAreaMarker" in _x) then {
_saveInfo = _x call RCOP_fnc_RCOPmarkerToString;
_markerDataList pushBack _saveInfo;
}; 
} forEach allMapMarkers; 
	
_markerDataList