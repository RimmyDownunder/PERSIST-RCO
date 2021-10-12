while {!isNil {player getVariable "rimmy_camp_var_fortifyBudget"}} do {
sleep 300;

if (!("ACE_Fortify" in items player) || (player getVariable "rimmy_camp_var_fortifyBudget") == 0) then {
player setVariable ["rimmy_camp_var_fortifyBudget", nil, true];

_removePlayer = rimmy_camp_var_fortifyAllowers find player;
rimmy_camp_var_fortifyAllowers deleteAt _removePlayer;

};
};