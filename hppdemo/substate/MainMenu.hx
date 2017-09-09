package hppdemo.substate;

import hpp.flixel.ui.HPPButton;
import hppdemo.state.MainState.SubStateType;
import hppdemo.view.MenuButton;

/**
 * ...
 * @author Krisztian Somoracz
 */
class MainMenu extends BaseSubState
{
	var layoutDemoButton:HPPButton;
	var buttonDemoButton:HPPButton;
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
		setTitle( "Choose a demo" );
		
		mainContainer.add( layoutDemoButton = new MenuButton( "Layout", openHPPLayoutDemo ) );
		mainContainer.add( buttonDemoButton = new MenuButton( "Button", openHPPButtonDemo ) );
		mainContainer.add( touchScrollContainerDemoButton = new MenuButton( "Touch scroll container", openHPPTouchScrollContainerDemo ) );
		
		rePosition();
	}
	
	function openHPPLayoutDemo( target:HPPButton ):Void
	{
		changeSubStateCallback( SubStateType.STATE_HPP_LAYOUT );
	}
	
	function openHPPButtonDemo( target:HPPButton ):Void
	{
		changeSubStateCallback( SubStateType.STATE_HPP_BUTTON );
	}
	
	function openHPPTouchScrollContainerDemo( target:HPPButton ):Void
	{
		changeSubStateCallback( SubStateType.STATE_HPP_TOUCH_SCROLL_CONTAINER );
	}
}