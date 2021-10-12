"Mission Ending" hintC rimmy_camp_endOfRoundInfo;
hintC_EH = findDisplay 72 displayAddEventHandler ["Unload", {
	_this spawn {
		_this select 0 displayRemoveEventHandler ["Unload", hintC_EH];
		hintSilent "";
	};
}];