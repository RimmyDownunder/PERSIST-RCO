class RCOP_EasyDetailLoad: Module_F
{
	scope = 2;
	displayName = "Auto Detailed Load";
	category = "RCOP_modules";
	function = "RCOP_fnc_RCOPcrateFillerStart";
	icon = "\a3\ui_f\data\igui\cfg\actions\settimer_ca.paa";
	functionPriority = 2;
	isGlobal = 0;
	isTriggerActivated = 0;
	isDisposable = 1;

	class Attributes: AttributesBase
	{
		
		class RCOP_PlayerLoadout: Combo
		{
			property = "RCOP_PlayerLoadout";
			displayName="Load Player Loadout";
			tooltip=$STR_RCOP_Modules_PlayerLoadout_tooltip;
			typeName="NUMBER";
			defaultValue = 2;
			class values
			{
				class NoLoad
				{
					name="Don't Load Loadouts";
					value=0;
				};
				class PlayerLoad
				{
					name="Profile-Based Loading (Old)";
					value=1;
				};
				class SlotLoad
				{
					name="Slot-Based Loading";
					value=2;
				};
			};
		};
		
		class RCOP_LoadMedical: CheckBox
		{
			property = "RCOP_LoadMedical";
			displayName="Load ACE Medical";
			tooltip=$STR_RCOP_Modules_LoadMedical_tooltip;
			typeName="BOOL";
			defaultValue = "False";
		};
		
		class RCOP_LoadHunger: CheckBox
		{
			property = "RCOP_LoadHunger";
			displayName="Load ACEX Hunger & Thirst";
			tooltip=$STR_RCOP_Modules_LoadHunger_tooltip;
			typeName="BOOL";
			defaultValue = "False";
		};
		
		class RCOP_LoadMarker: CheckBox
		{
			property = "RCOP_LoadMarker";
			displayName="Load Map Data";
			tooltip=$STR_RCOP_Modules_LoadMarker_tooltip;
			typeName="BOOL";
			defaultValue = "False";
		};
		
		class RCOP_JIPLoadout: CheckBox
		{
			property = "RCOP_JIPLoadout";
			displayName="Join-In-Progress Loadout";
			tooltip=$STR_RCOP_Modules_JIPLoadout_tooltip;
			typeName="BOOL";
			defaultValue = "True";
		};
		
		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description[] =
		{
			$STR_RCOP_Modules_EasyDetailLoad_description
		};
	};
};