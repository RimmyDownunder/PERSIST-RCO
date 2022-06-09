params ["_playerLoadoutChoice","_medicalLoadChoice","_hungerLoadChoice","_markerLoadChoice","_JIPChoice"];

if (isNil "_playerLoadoutChoice") then { _playerLoadoutChoice = 2; };
if (isNil "_medicalLoadChoice") then { _medicalLoadChoice = 0; };
if (isNil "_hungerLoadChoice") then { _hungerLoadChoice = 0; };
if (isNil "_markerLoadChoice") then { _markerLoadChoice = 0; };
if (isNil "_JIPChoice") then { _JIPChoice = false; };

detailedLoadInfoPassComplete = 0;

if ((vehicleVarName player) == "persist1") then {
crateCargoPass = [];
crateSpawnerPass = [];
crateBudgetPass = [];
crateStatsPass = [];
rimmySlotLoadout = [];
rimmySlotMedical = [];
rimmySlotHunger = [];
crateCargoPass = profileNamespace getVariable "rimmy_camp_var_recCrateCargo";	
crateSpawnerPass = profileNamespace getVariable "rimmy_camp_var_recCrateLocation";
crateBudgetPass = profileNamespace getVariable "rimmy_camp_var_recCrateBudget";
crateStatsPass = profileNamespace getVariable "rimmy_camp_var_recCrateStats";
rimmySlotLoadout = profileNamespace getVariable "rimmy_camp_var_slotLoadout"; 
rimmySlotMedical = profileNamespace getVariable "rimmy_camp_var_slotMedical"; 
rimmySlotHunger = profileNamespace getVariable "rimmy_camp_var_slotHunger";
rimmySlotMarkers = profileNamespace getVariable "rimmy_camp_var_slotMarkers"; 

publicVariable "crateCargoPass";
publicVariable "crateSpawnerPass";
publicVariable "crateBudgetPass";
publicVariable "crateStatsPass";
publicVariable "rimmySlotLoadout";
publicVariable "rimmySlotMedical";
publicVariable "rimmySlotHunger";
publicVariable "rimmySlotMarkers";
detailedLoadInfoPassComplete = 1;
publicVariable "detailedLoadInfoPassComplete";
};

waitUntil {sleep 1; detailedLoadInfoPassComplete == 1};

if (isServer) then {

	"PERSIST Detailed Server Load Beginning..." remoteExec ["hint",0];
};

[[_playerLoadoutChoice,_medicalLoadChoice,_hungerLoadChoice,_markerLoadChoice,rimmySlotLoadout,rimmySlotMedical,rimmySlotHunger,rimmySlotMarkers],"RCOP\RCOPersist\RCOPplayerLoadout.sqf"] remoteExec ["execVM",0,_JIPChoice];