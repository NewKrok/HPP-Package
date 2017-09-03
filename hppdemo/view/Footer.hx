package hppdemo.view;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import hpp.flixel.util.HPPAssetManager;

/**
 * ...
 * @author Krisztian Somoracz
 */
class Footer extends FlxSpriteGroup
{
	public function new() 
	{
		super();
		
		var background:FlxSprite = HPPAssetManager.getSprite( "frame" );
		background.angle = 180;
		add( background );
		
		var logo:FlxSprite = HPPAssetManager.getSprite( "logo" );
		logo.x = width / 2 - logo.width / 2;
		logo.y = height / 2 - logo.height / 2;
		add( logo );
	}
}