package hppdemo.view;

import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import hpp.flixel.ui.HPPButton;
import hpp.flixel.util.HPPAssetManager;
import hppdemo.Fonts;
import hppdemo.state.MainState.SubStateType;

/**
 * ...
 * @author Krisztian Somoracz
 */ 
class Header extends FlxSpriteGroup
{
	private static inline var WELCOME_TEXT:String = "HPP package demos";
	
	var backButton:HPPButton;
	var title:FlxText;
	var mainMenuCallBack:SubStateType->Void;
	
	public function new( mainMenuCallBack:SubStateType->Void ) 
	{
		super();
		
		this.mainMenuCallBack = mainMenuCallBack;
		
		build();
		changeToWelcomeMode();
	}
	
	function build():Void 
	{
		add( HPPAssetManager.getSprite( "frame" ) );
		
		title = new FlxText( 0, 0, width );
		title.font = Fonts.DEFAULT_FONT;
		title.borderColor = 0xFFF;
		title.size = 32;
		title.text = "Placeholder";
		title.y = height / 2 - title.textField.textHeight / 2;
		add( title );
		
		add( backButton = new HPPButton( "Back", backToMainMenu, "back_button" ) );
		backButton.overScale = .98;
		backButton.labelSize = 25;
		backButton.label.font = Fonts.DEFAULT_FONT;
		backButton.x = 20;
		backButton.y = height / 2 - backButton.height / 2;
	}
	
	function backToMainMenu( target:HPPButton ):Void 
	{
		mainMenuCallBack( SubStateType.STATE_MAIN_MENU );
	}
	
	public function changeToWelcomeMode():Void
	{
		title.x = 0;
		title.alignment = "center";
		title.text = WELCOME_TEXT;
		
		backButton.visible = false;
	}
	
	public function changeToDemoMode( subStateType:SubStateType ) 
	{
		title.x = -20;
		title.alignment = "right";
		title.text = cast subStateType;
		
		backButton.visible = true;
	}
}