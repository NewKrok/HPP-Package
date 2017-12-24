package hpp.flixel.system;

import flixel.FlxGame;
import flixel.FlxState;
import flixel.system.ui.FlxFocusLostScreen;
import hpp.flixel.system.HPPFocusLostScreen;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPFlxMain extends FlxGame
{
	public function new(GameWidth:Int = 0, GameHeight:Int = 0, ?InitialState:Class<FlxState>, focusLostScreen:Class<FlxFocusLostScreen> = null, Zoom:Float = 1,
		UpdateFramerate:Int = 60, DrawFramerate:Int = 60, SkipSplash:Bool = true, StartFullscreen:Bool = false)
	{
		super(GameWidth, GameHeight, InitialState, Zoom, UpdateFramerate, DrawFramerate, SkipSplash, StartFullscreen);
		
		_customFocusLostScreen = focusLostScreen == null ? HPPFocusLostScreen : focusLostScreen;
	}
}