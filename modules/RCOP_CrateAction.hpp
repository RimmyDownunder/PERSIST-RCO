class RCOP_CrateAction: Module_F
{
	scope = 2;
	displayName = "Detailed Load Action (For Testing)";
	category = "RCOP_modules";
	function = "RCOP_fnc_RCOPcrateAction";
	icon = "\a3\ui_f\data\igui\cfg\actions\settimer_ca.paa";
	functionPriority = 2;
	isGlobal = 0;
	isTriggerActivated = 0;
	isDisposable = 1;

	class Attributes: AttributesBase
	{
		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description[] =
		{
			$STR_RCOP_Modules_CrateAction_description
		};
	};
};