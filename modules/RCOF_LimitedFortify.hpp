class RCOF_LimitedFortify: Module_F
{
	scope = 2;
	displayName = "Limited Fortify Core";
	category = "RCOF_modules";
	function = "RCOF_fnc_RCOFortifyInit";
	icon = "\a3\ui_f\data\igui\cfg\actions\repair_ca.paa";
	functionPriority = 2;
	isGlobal = 0;
	isTriggerActivated = 0;
	isDisposable = 1;

	class Attributes: AttributesBase
	{
		class RCOF_Station: Edit
		{
			property = "RCOF_Station";
			displayName = "LF Stations";
			tooltip = $STR_RCOF_Modules_station_tooltip;
			typeName = "STRING";
			defaultValue = "['Land_CratesWooden_F']";
		};
		class RCOF_VehicleBig: Edit
		{
			property = "RCOF_VehicleBig";
			displayName = "Big Vehicles";
			tooltip = $STR_RCOF_Modules_VehicleBig_tooltip;
			typeName = "STRING";
			defaultValue = "['B_Truck_01_box_F']";
		};
		class RCOF_VehicleBigMax: Edit
		{
			property = "RCOF_VehicleBigMax";
			displayName = "Big Vehicle Storage";
			tooltip = $STR_RCOF_Modules_VehicleBigMax_tooltip;
			typeName = "NUMBER";
			defaultValue = 1000;
		};
		class RCOF_VehicleSmall: Edit
		{
			property = "RCOF_VehicleSmall";
			displayName = "Small Vehicles";
			tooltip = $STR_RCOF_Modules_VehicleSmall_tooltip;
			typeName = "STRING";
			defaultValue = "['B_MRAP_01_F']";
		};
		class RCOF_VehicleSmallMax: Edit
		{
			property = "RCOF_VehicleSmallMax";
			displayName = "Small Vehicle Storage";
			tooltip = $STR_RCOF_Modules_VehicleSmallMax_tooltip;
			typeName = "NUMBER";
			defaultValue = 250;
		};
		class RCOF_ObjectBig: Edit
		{
			property = "RCOF_ObjectBig";
			displayName = "Big Objects";
			tooltip = $STR_RCOF_Modules_ObjectBig_tooltip;
			typeName = "STRING";
			defaultValue = "['B_Slingload_01_Ammo_F']";
		};
		class RCOF_ObjectBigMax: Edit
		{
			property = "RCOF_ObjectBigMax";
			displayName = "Big Object Storage";
			tooltip = $STR_RCOF_Modules_ObjectBigMax_tooltip;
			typeName = "NUMBER";
			defaultValue = 500;
		};
		class RCOF_ObjectSmall: Edit
		{
			property = "RCOF_ObjectSmall";
			displayName = "Small Objects";
			tooltip = $STR_RCOF_Modules_ObjectSmall_tooltip;
			typeName = "STRING";
			defaultValue = "['CargoNet_01_box_F']";
		};
		class RCOF_ObjectSmallMax: Edit
		{
			property = "RCOF_ObjectSmallMax";
			displayName = "Small Object Storage";
			tooltip = $STR_RCOF_Modules_ObjectSmallMax_tooltip;
			typeName = "NUMBER";
			defaultValue = 250;
		};
		class RCOF_BuildRange: Edit
		{
			property = "RCOF_BuildRange";
			displayName = "Build Range";
			tooltip = $STR_RCOF_Modules_BuildRange_tooltip;
			typeName = "NUMBER";
			defaultValue = 50;
		};
		class RCOF_FortifySide: Combo
		{
			property = "RCOF_FortifySide";
			displayName = "Fortify Side";
			tooltip = $STR_RCOF_Modules_FortifySide_tooltip;
			typeName = "STRING";
			defaultValue = """WEST""";
			class Values
			{
				class sideWest
				{
					name = "BLUFOR";
					value = "WEST";
				};
				class sideEast
				{
					name = "OPFOR";
					value = "EAST";
				};
				class sideInd
				{
					name = "INDFOR";
					value = "INDEPENDENT";
				};
				class sideCiv
				{
					name = "Civilian";
					value = "CIV";
				};
			};
		};
		class RCOF_DesertArray: Edit
		{
			property = "RCOF_DesertArray";
			displayName = "Desert List";
			tooltip = $STR_RCOF_Modules_DesertArray_tooltip;
			typeName = "STRING";
			defaultValue = "[['Land_BagFence_Long_F', 10],['Land_BagBunker_Small_F', 50],['Land_Plank_01_4m_F', 10],['Land_PortableCabinet_01_closed_black_F', 5]]";
		};
		class RCOF_WoodlandArray: Edit
		{
			property = "RCOF_WoodlandArray";
			displayName = "Woodland List";
			tooltip = $STR_RCOF_Modules_WoodlandArray_tooltip;
			typeName = "STRING";
			defaultValue = "[['Land_BagFence_01_long_green_F', 10],['Land_BagBunker_01_small_green_F', 50],['Land_Plank_01_4m_F', 10],['Land_PortableCabinet_01_closed_black_F', 5]]";
		};
		class RCOF_LargeArray: Edit
		{
			property = "RCOF_LargeArray";
			displayName = "Large List";
			tooltip = $STR_RCOF_Modules_LargeArray_tooltip;
			typeName = "STRING";
			defaultValue = "[['Land_Bunker_01_small_F', 500],['Land_Cargo_Tower_V3_F', 1000],['Land_PortableCabinet_01_closed_black_F', 5]]";
		};
		class RCOF_CampArray: Edit
		{
			property = "RCOF_CampArray";
			displayName = "Camp List";
			tooltip = $STR_RCOF_Modules_CampArray_tooltip;
			typeName = "STRING";
			defaultValue = "[['Land_TentA_F', 10],['Land_TentDome_F', 10],['Campfire_burning_F', 10],['Land_PortableCabinet_01_closed_black_F', 5]]";
		};
		class RCOF_Custom1Array: Edit
		{
			property = "RCOF_Custom1Array";
			displayName = "Custom 1 List";
			tooltip = $STR_RCOF_Modules_Custom1Array_tooltip;
			typeName = "STRING";
		};
		class RCOF_Custom2Array: Edit
		{
			property = "RCOF_Custom2Array";
			displayName = "Custom 2 List";
			tooltip = $STR_RCOF_Modules_Custom2Array_tooltip;
			typeName = "STRING";
		};
		class RCOF_AllowDelete: CheckBox
		{
				property = "RCOF_AllowDelete";
				displayName="Allow Mission Object Deletion";
				tooltip=$STR_RCOF_Modules_AllowDelete_tooltip;
				typeName="BOOL";
				defaultValue = "True";
		};
		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description[] =
		{
			$STR_RCOP_Modules_LimitedFortify_description
		};
	};
};