package hppdemo.view;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import hpp.flixel.ui.HPPButton;
import hpp.flixel.util.HPPAssetManager;
import openfl.net.URLRequest;

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
		
		var logo:HPPButton = new HPPButton( "", goToHome, "logo" );
		logo.overScale = 1.02;
		logo.x = width / 2 - logo.width / 2;
		logo.y = height / 2 - logo.height / 2;
		add( logo );
	}
	
	function goToHome( target:HPPButton ):Void
	{
		var homeURL:URLRequest = new URLRequest( "http://flashplusplus.net/?utm_source=HPP-Demo&utm_medium=demo_footer&utm_campaign=HPP_Package" );
		openfl.Lib.getURL( homeURL, "_blank" );
	}
}