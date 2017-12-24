package;

import hpp.heaps.Base2dApp;
import hpp.heaps.Base2dStage.StageScaleMode;
import hxd.Res;
import state.MenuState;

/**
 * ...
 * @author Krisztian Somoracz
 */
class Main extends Base2dApp
{
	override function init()
	{
		super.init();

		stage.stageScaleMode = StageScaleMode.NO_SCALE;

		changeState(MenuState);
	}

	static function main()
	{
		Res.initEmbed();
		new Main();
	}
}