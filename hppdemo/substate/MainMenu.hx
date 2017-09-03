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
	var changeSubStateCallback:SubStateType->Void;
	
	public function new( changeSubStateCallback:SubStateType->Void )
	{
		super();
		
		this.changeSubStateCallback = changeSubStateCallback;
		
		build();
	}
	
	function build():Void 
	{
		add( touchScrollContainerDemoButton = new MenuButton( "HPPTouchScrollContainer", openHPPTouchScrollContainerDemo ) );
		touchScrollContainerDemoButton.x = FlxG.width / 2 - touchScrollContainerDemoButton.width / 2;
		touchScrollContainerDemoButton.y = FlxG.height / 2 - touchScrollContainerDemoButton.height / 2;
	}
	
	function openHPPTouchScrollContainerDemo() 
	{
		changeSubStateCallback( SubStateType.STATE_HPP_TOUCH_SCROLL_CONTAINER );
	}
}