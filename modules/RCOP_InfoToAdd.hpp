class RCOP_InfoToAdd: Module_F
{
	scope = 2;
	displayName = "Add Information to End of Round Report";
	category = "RCOP_modules";
	function = "RCOP_fnc_RCOPendOfRoundInfoStore";
	icon = "\a3\ui_f\data\igui\cfg\actions\settimer_ca.paa";
	functionPriority = 3;
	isGlobal = 0;
	isTriggerActivated = 1;
	isDisposable = 1;

	class Attributes: AttributesBase
	{
		class RCOP_Info: Edit
		{
			property = "RCOP_Info";
			displayName = "Information";
			tooltip = $STR_RCOF_Modules_Info_tooltip;
			typeName = "STRING";
			defaultValue = "'The enemy commander is dead!'";
		};
		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description[] =
		{
			$STR_RCOP_Modules_InfoToAdd_description
		};
	};
};