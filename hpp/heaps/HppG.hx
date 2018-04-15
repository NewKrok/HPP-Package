package hpp.heaps;

import hpp.heaps.Base2dApp;
import hpp.heaps.Base2dStage;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HppG
{
	// TODO use @:access or singleton
	static public function setStage2d(v:Base2dStage) { stage2d = v; }

	public static var stage2d(default, null):Base2dStage;
}