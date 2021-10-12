class RCOP_DefineSavedFOBs: Module_F
{
	scope = 2;
	displayName = "FOB Objects to Save";
	category = "RCOP_modules";
	function = "RCOP_fnc_RCOPdefineSaves";
	icon = "\a3\ui_f\data\igui\cfg\actions\settimer_ca.paa";
	functionPriority = 1;
	isGlobal = 0;
	isTriggerActivated = 1;
	isDisposable = 1;
	canSetArea = 1;

	class Attributes: AttributesBase
	{
		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description[] =
		{
			$STR_RCOP_Modules_DefineSavedFOBs_description
		};
	};
};