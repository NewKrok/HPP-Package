package hppdemo.state;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import hpp.flixel.util.HPPAssetManager;
import hppdemo.commonview.Footer;
import hppdemo.commonview.Header;
import hppdemo.substate.MainMenu;

/**
 * ...
 * @author Krisztian Somoracz
 */
class MenuState extends FlxState
{
	var header:Header;
	var footer:Footer;
	
	var mainMenu:MainMenu;
	
	override public function create():Void
	{
		super.create();
		
		persistentUpdate = true;
		destroySubStates = false;
		
		loadAssets();
		build();
		openSubState( mainMenu );
	}
	
	function loadAssets():Void
	{
		HPPAssetManager.loadXMLAtlas( "assets/images/demo_atlas.png", "assets/images/demo_atlas.xml" );
	}
	
	function build():Void
	{
		add( header = new Header() );
		
		add( footer = new Footer() );
		footer.y = FlxG.height - footer.height;
		
		mainMenu = new MainMenu();
	}
}