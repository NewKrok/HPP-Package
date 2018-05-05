package hpp.heaps;

import hpp.heaps.Base2dApp;
import hpp.heaps.Base2dStage;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HppG
{
	static var config:HppGConfig;

	public static function init(c:HppGConfig):Void
	{
		if (config == null) config = c;
		else trace("Error, You can't init HppG!");
	}

	public static var stage2d(get, never):Base2dStage;
	public static var changeState(get, never):Class<Base2dState>->?Array<Dynamic>->Void;

	static function get_stage2d():Base2dStage
	{
		return config.stage2d;
	}

	static function get_changeState():Class<Base2dState>->?Array<Dynamic>->Void
	{
		return config.changeState;
	}
}

typedef HppGConfig = {
	final stage2d:Base2dStage;
	final changeState:Class<Base2dState>->?Array<Dynamic>->Void;
}