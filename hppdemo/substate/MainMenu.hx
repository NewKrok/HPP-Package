package hppdemo.substate;

import flixel.FlxG;
import flixel.FlxSubState;
import hpp.flixel.ui.HPPButton;
import hppdemo.view.MenuButton;
import hppdemo.state.MainState.SubStateType;

/**
 * ...
 * @author Krisztian Somoracz
 */
class MainMenu extends FlxSubState
{
	var touchScrollContainerDemoButton:HPPButton;
	var buttonDemoButton:HPPButton;
	
	var changeSubStateCallback:SubStateType->Void;
	
	public function new( changeSubStateCallback:SubStateType->Void )
	{
		super();
		
		this.changeSubStateCallback = changeSubStateCallback;
		
		build();
	}
	
	function build():Void 
	{
		add( buttonDemoButton = new MenuButton( "HPPButtonDemo", openHPPButtonDemo ) );
		buttonDemoButton.x = FlxG.width / 2 - buttonDemoButton.width / 2;
		buttonDemoButton.y = FlxG.height / 2 - buttonDemoButton.height / 2 - 50;
		
		add( touchScrollContainerDemoButton = new MenuButton( "HPPTouchScrollContainer", openHPPTouchScrollContainerDemo ) );
		touchScrollContainerDemoButton.x = FlxG.width / 2 - touchScrollContainerDemoButton.width / 2;
		touchScrollContainerDemoButton.y = FlxG.height / 2 - touchScrollContainerDemoButton.height / 2 + 50;
	}
	
	function openHPPTouchScrollContainerDemo( target:HPPButton ):Void
	{
		changeSubStateCallback( SubStateType.STATE_HPP_TOUCH_SCROLL_CONTAINER );
	}
	
	function openHPPButtonDemo( target:HPPButton ):Void
	{
		changeSubStateCallback( SubStateType.STATE_HPP_BUTTON );
	}
}