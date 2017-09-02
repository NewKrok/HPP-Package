package hppdemo.commonview;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import hpp.flixel.util.HPPAssetManager;
import hppdemo.Fonts;

/**
 * ...
 * @author Krisztian Somoracz
 */ 
class Header extends FlxSpriteGroup
{
	private static inline var WELCOME_TEXT:String = "HPP package demos";
	
	var title:FlxText;
	
	public function new() 
	{
		super();
		
		add( HPPAssetManager.getSprite( "frame" ) );
		
		title = new FlxText( 0, 0, width );
		title.font = Fonts.DEFAULT_FONT;
		title.borderColor = 0xFFF;
		title.size = 32;
		title.text = "Placeholder";
		title.y = height / 2 - title.textField.textHeight / 2;
		add( title );
		
		changeToWelcomeMode();
	}
	
	public function changeToWelcomeMode():Void
	{
		title.x = 0;
		title.alignment = "center";
		title.text = WELCOME_TEXT;
	}
}