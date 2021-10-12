_module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};


{
    switch (typeOf _module) do {

    case "RCOP_DefineSavedFOBs": {
	if !(_x isKindOf "Logic") then {
	if (isNil "rimmy_camp_var_fobSaver") then {rimmy_camp_var_fobSaver = []}; 
	rimmy_camp_var_fobSaver pushBackUnique (typeOf _x);
	publicVariable "rimmy_camp_var_fobSaver";
	_module setVariable ["rimmy_camp_var_DefineSavedFOBsVar",rimmy_camp_var_fobSaver,true];
	deleteVehicle _x;
	};
	};
	case "RCOP_DefineSavedCrates": {
	if !(_x isKindOf "Logic") then {
	if (isNil "rimmy_camp_var_crateSaver") then {rimmy_camp_var_crateSaver = []}; 
	rimmy_camp_var_crateSaver pushBackUnique (typeOf _x);
	publicVariable "rimmy_camp_var_crateSaver";
	_module setVariable ["rimmy_camp_var_DefineSavedCratesVar",rimmy_camp_var_crateSaver,true];
	deleteVehicle _x;
	};
	};
	default {};
	
	};

} foreach (synchronizedObjects _module);