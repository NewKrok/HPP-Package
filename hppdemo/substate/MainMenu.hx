package hppdemo.substate;

import flixel.FlxG;
import flixel.FlxSubState;
import hpp.flixel.ui.HPPButton;
import hppdemo.commonview.MenuButton;

/**
 * ...
 * @author Krisztian Somoracz
 */
class MainMenu extends FlxSubState
{
	var scrollContainerDemoButton:HPPButton;
	
	public function new() 
	{
		super();
		
		add( scrollContainerDemoButton = new MenuButton( "HPPScrollContainer", openHPPScrollContainerDemo ) );
		scrollContainerDemoButton.x = FlxG.width / 2 - scrollContainerDemoButton.width / 2;
		scrollContainerDemoButton.y = FlxG.height / 2 - scrollContainerDemoButton.height / 2;
	}
	
	function openHPPScrollContainerDemo() 
	{
		
	}
}