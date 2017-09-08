package hppdemo.state;

import flixel.FlxG;
import flixel.FlxState;
import hpp.flixel.util.HPPAssetManager;
import hppdemo.substate.DemoButton;
import hppdemo.substate.DemoScrollContainer;
import hppdemo.substate.MainMenu;
import hppdemo.view.Footer;
import hppdemo.view.Header;

/**
 * ...
 * @author Krisztian Somoracz
 */
class MainState extends FlxState
{
	var header:Header;
	var footer:Footer;
	
	var mainMenu:MainMenu;
	var demoTouchScrollContainer:DemoScrollContainer;
	var demoButton:DemoButton;
	
	override public function create():Void
	{
		super.create();
		
		persistentUpdate = true;
		destroySubStates = false;
		
		FlxG.mouse.unload();
		FlxG.mouse.useSystemCursor = true;
		
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
		add( header = new Header( changeSubState ) );
		
		add( footer = new Footer() );
		footer.y = FlxG.height - footer.height;
		
		mainMenu = new MainMenu( changeSubState );
		demoTouchScrollContainer = new DemoScrollContainer();
		demoButton = new DemoButton();
	}
	
	function changeSubState( subStateType:SubStateType ):Void
	{
		switch( subStateType )
		{
			case SubStateType.STATE_MAIN_MENU:
				openSubState( mainMenu );
				
			case SubStateType.STATE_HPP_BUTTON:
				openSubState( demoButton );
				
			case SubStateType.STATE_HPP_TOUCH_SCROLL_CONTAINER:
				openSubState( demoTouchScrollContainer );
		}
		
		if ( subStateType == SubStateType.STATE_MAIN_MENU )
		{
			header.changeToWelcomeMode();
		}
		else
		{
			header.changeToDemoMode( subStateType );
		}
	}
}

@:enum
abstract SubStateType( String ) {
  var STATE_MAIN_MENU = "";
  var STATE_HPP_BUTTON = "HPPButton demo";
  var STATE_HPP_TOUCH_SCROLL_CONTAINER = "HPPTouchScrollContainer demo";
}