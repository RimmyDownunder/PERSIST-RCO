params ["_vehicleToLoad","_supplyCountToLoad"];

waitUntil {!isNil {_vehicleToLoad getVariable "rimmy_camp_var_fortifyBudget" }};
sleep (5 + random 5);
_vehicleToLoad setVariable ["rimmy_camp_var_fortifyBudget",_supplyCountToLoad, true];