class RCOP_SaveAction: Module_F
{
	scope = 2;
	displayName = "Save Action";
	category = "RCOP_modules";
	function = "RCOP_fnc_RCOPsaveAction";
	icon = "\a3\ui_f\data\igui\cfg\actions\settimer_ca.paa";
	functionPriority = 2;
	isGlobal = 0;
	isTriggerActivated = 0;
	isDisposable = 1;

	class Attributes: AttributesBase
	{
		class RCOP_FOBMarker: Edit
		{
			property = "RCOP_FOBMarker";
			displayName = "FOB Marker";
			tooltip = $STR_RCOP_Modules_FOBMarker_tooltip;
			typeName = "STRING";
			defaultValue = "'Land_PortableCabinet_01_closed_black_F'";
		};
		class RCOP_FOBObjects: Edit
		{
			property = "RCOP_FOBObjects";
			displayName = "Permitted FOB Objects";
			tooltip = $STR_RCOP_Modules_FOBObjects_tooltip;
			typeName = "STRING";
			defaultValue = "['Land_BagFence_Long_F','Land_BagBunker_Small_F','Land_Plank_01_4m_F','Land_PortableCabinet_01_closed_black_F']";
		};
		class RCOP_VehicleCratesToSave: Edit
		{
			property = "RCOP_VehicleCratesToSave";
			displayName = "Vehicles & Crates to Save";
			tooltip = $STR_RCOP_Modules_vehicleCratesToSave_tooltip;
			typeName = "STRING";
			defaultValue = "['B_supplyCrate_F','B_Truck_01_box_F']";
		};
		class RCOP_permittedMines: Edit
		{
			property = "RCOP_permittedMines";
			displayName = "Permitted Mines";
			tooltip = $STR_RCOP_Modules_permittedMines_tooltip;
			typeName = "STRING";
			defaultValue = "['ATMine_Range_Ammo','APERSMine_Range_Ammo']"; 
		};
		class RCOP_deleteBlocker: Edit
		{
			property = "RCOP_deleteBlocker";
			displayName = "Object to Block Delete";
			tooltip = $STR_RCOP_Modules_deleteBlocker_tooltip;
			typeName = "STRING";
			defaultValue = "'VR_3DSelector_01_default_F'"; 
		};
		
		class RCOP_OldSlot: CheckBox
		{
			property = "RCOP_OldSlot";
			displayName="Save Missing Slot's Loadouts?";
			tooltip=$STR_RCOP_Modules_OldSlot_tooltip;
			typeName="BOOL";
			defaultValue = "False";
		};
		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description[] =
		{
			$STR_RCOP_Modules_save_description
		};
	};
};