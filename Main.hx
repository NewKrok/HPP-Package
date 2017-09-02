package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

import hppdemo.state.MenuState;

class Main extends Sprite
{
	public function new()
	{
		super();
		
		addChild( new FlxGame( 0, 0, MenuState ) );
		
		addChild( new FPS( stage.stageWidth - 75, stage.stageHeight - 50, 0xffffff ) );
	}
}