package;

import hpp.flixel.system.HPPFlxMain;
import hpp.openfl.debug.DebugConsole;
import hpp.util.JsFullScreenUtil;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.UncaughtErrorEvent;

import hppdemo.state.MainState;

class Main extends Sprite
{
	public function new()
	{
		super();
		
		var console:DebugConsole = new DebugConsole();
		JsFullScreenUtil.init("openfl-content");
		
		addChild(new HPPFlxMain(0, 0, MainState));
		addChild(console);
		addChild(new FPS( stage.stageWidth - 75, stage.stageHeight - 50, 0xffffff));
		
		addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, function(e:UncaughtErrorEvent){DebugConsole.add("ERROR: " + e.error); });
	}
}