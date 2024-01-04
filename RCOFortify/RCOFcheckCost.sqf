params ["_object"];

_finalCost = 0;

scopeName "final";

while {true} do {

if (_object in rimmy_camp_var_fortifyDefaultArrayKey) then {
_selector = rimmy_camp_var_fortifyDefaultArrayKey find _object;
_finalCost = rimmy_camp_var_fortifyDefaultArrayValue select _selector;
breakTo "final";
};

if (_object in rimmy_camp_var_fortifyDesertArrayKey) then {
_selector = rimmy_camp_var_fortifyDesertArrayKey find _object;
_finalCost = rimmy_camp_var_fortifyDesertArrayValue select _selector;
breakTo "final";
};

if (_object in rimmy_camp_var_fortifyWoodlandArrayKey) then {
_selector = rimmy_camp_var_fortifyWoodlandArrayKey find _object;
_finalCost = rimmy_camp_var_fortifyWoodlandArrayValue select _selector;
breakTo "final";
};

if (_object in rimmy_camp_var_fortifyLargeArrayKey) then {
_selector = rimmy_camp_var_fortifyLargeArrayKey find _object;
_finalCost = rimmy_camp_var_fortifyLargeArrayValue select _selector;
breakTo "final";
};

if (_object in rimmy_camp_var_fortifyCampArrayKey) then {
_selector = rimmy_camp_var_fortifyCampArrayKey find _object;
_finalCost = rimmy_camp_var_fortifyCampArrayValue select _selector;
breakTo "final";
};

if (_object in rimmy_camp_var_fortifyCustom1ArrayKey) then {
_selector = rimmy_camp_var_fortifyCustom1ArrayKey find _object;
_finalCost = rimmy_camp_var_fortifyCustom1ArrayValue select _selector;
breakTo "final";
};

if (_object in rimmy_camp_var_fortifyCustom2ArrayKey) then {
_selector = rimmy_camp_var_fortifyCustom2ArrayKey find _object;
_finalCost = rimmy_camp_var_fortifyCustom2ArrayValue select _selector;
breakTo "final";
};

}; 

_finalCost