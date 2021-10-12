class CfgPatches
{
    class RCOP_patches
    {
        units[] =
        {
            "RCOP_SaveAction",
			"RCOP_CrateAction",
			"RCOF_LimitedFortify",
			"RCOP_InfoToAdd",
			"RCOP_DefineSavedCrates",
			"RCOP_DefineSavedFOBs",
			"RCOP_EasyDetailLoad"
		};
        requiredVersion = 1.00;
        requiredAddons[] =
        {
            "A3_Modules_F",
			"3DEN"
        };
        author = "Rimmy";
        name = "PERSIST - RCO";
        version = "1.0";
    };
};

class CfgFactionClasses
{
    class RCOP_modules
    {
        displayname = "PERSIST - RCO";
        priority = 1;
        side = 7;
    };
	class RCOF_modules
    {
        displayname = "Limited Fortify - RCO";
        priority = 1;
        side = 7;
    };
};

class CfgFunctions
{
    class RCOP
    {
        class RCOP_functions
        {
            tag = "RCOP";
            file = "\RCOP\RCOPersist";
            class RCOPsaveAction;
			class RCOPcrateAction;
			class RCOPendOfRoundInfoStore;
			class RCOPdefineSaves;
			class RCOPcrateFillerStart;
			class RCOPloadEDENStart;
			class RCOPtoClipboard;
			class RCOPfromClipboard;
			class RCOPmarkerToString;
			class RCOPstringToMarker;
			class RCOPsavingMarkers;
			
        };
	};
	class RCOF
    {
		class RCOF_functions
        {
            tag = "RCOF";
            file = "\RCOP\RCOFortify";
            class RCOFortifyInit;
        };
    };
};

class CtrlMenuStrip;

class Display3DEN
{
	class Controls
	{
		class MenuStrip: CtrlMenuStrip
		{
			class Items
			{
				class Tools
				{
					items[] += {"RCOP_ToolsMenu"};
				};

				class RCOP_ToolsMenu
				{
					text = "PERSIST - RCO";
					items[] = {
					"RCOP_SaveToClipboard",
					"RCOP_LoadPersistence",
					"RCOP_LoadPersistenceNoDel",
					"RCOP_LoadPersistenceNoLoad",
					"RCOP_LoadPersistenceNoDelLoad",
					"RCOP_LoadFromClipboard"
					};
				};

				class RCOP_LoadPersistence
				{
					text = "Load Saved Persistence Data";
					picture = "";
					action = "[1,1] call RCOP_fnc_RCOPloadEDENStart;";
				};
				
				class RCOP_LoadPersistenceNoDel
				{
					text = "Load Saved Persistence Data (No Deleting)";
					picture = "";
					action = "[0,1] call RCOP_fnc_RCOPloadEDENStart;";
				};
				
				class RCOP_LoadPersistenceNoLoad
				{
					text = "Load Saved Persistence Data (No Crate Loading)";
					picture = "";
					action = "[1,0] call RCOP_fnc_RCOPloadEDENStart;";
				};
				
				class RCOP_LoadPersistenceNoDelLoad
				{
					text = "Load Saved Persistence Data (No Deleting/Loading)";
					picture = "";
					action = "[0,0] call RCOP_fnc_RCOPloadEDENStart;";
				};
				class RCOP_SaveToClipboard
				{
					text = "Save Persistence Data to Clipboard";
					picture = "";
					action = "[] call RCOP_fnc_RCOPtoClipboard;";
				};
				class RCOP_LoadFromClipboard
				{
					text = "Load Persistence Data from Clipboard";
					picture = "";
					action = "[] call RCOP_fnc_RCOPfromClipboard;";
				};
			};
		};
	};
};

class CfgVehicles
{
    class Logic;
    class Module_F: Logic
    {
        class AttributesBase
        {
            class Default;
            class Edit; // Default edit box (i.e., text input field)
            class Combo; // Default combo box (i.e., drop-down menu)
            class CheckBox; // Tickbox, returns true/false
            class CheckBoxNumber; // Tickbox, returns 1/0
            class ModuleDescription; // Module description
        };
        class ModuleDescription
        {
            class Anything;
        };
    };
	
	// Persistence Modules
    #include "modules\RCOP_SaveAction.hpp"
	#include "modules\RCOP_CrateAction.hpp"
	#include "modules\RCOP_InfoToAdd.hpp"
	#include "modules\RCOP_DefineSavedCrates.hpp"
	#include "modules\RCOP_DefineSavedFOBs.hpp"
	#include "modules\RCOP_EasyDetailLoad.hpp"
	
	// Limited Fortify Modules
	#include "modules\RCOF_LimitedFortify.hpp"
	
};