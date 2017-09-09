package hppdemo.substate;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import hpp.flixel.ui.HPPVUIBox;
import hppdemo.Fonts;

/**
 * ...
 * @author Krisztian Somoracz
 */
class BaseSubState extends FlxSubState
{
	var mainContainer:HPPVUIBox;
	var titleText:FlxText;
	
	public function new() 
	{
		super();
		
		add( mainContainer = new HPPVUIBox( 20 ) );
		
		titleText = new FlxText();
		titleText.size = 20;
		titleText.font = Fonts.DEFAULT_FONT;
		titleText.text = "You can modify this base title with setTitle function.";
		titleText.fieldWidth = FlxG.width - 100;
		titleText.alignment = "center";
		mainContainer.add( titleText );
		
		rePosition();
	}
	
	function setTitle( value:String ):Void
	{
		titleText.text = value;
	}
	
	function rePosition():Void
	{
		mainContainer.x = FlxG.stage.stageWidth / 2 - mainContainer.width / 2;
		mainContainer.y = FlxG.stage.stageHeight / 2 - mainContainer.height / 2;
	}
}