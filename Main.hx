package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

import hppdemo.state.MainState;

class Main extends Sprite
{
	public function new()
	{
		super();
		
		addChild( new FlxGame( 0, 0, MainState ) );
		
		addChild( new FPS( stage.stageWidth - 75, stage.stageHeight - 50, 0xffffff ) );
	}
}