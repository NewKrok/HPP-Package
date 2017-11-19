package hppdemo.substate;

import flixel.text.FlxText;
import hpp.flixel.ui.HPPButton;
import hpp.openfl.debug.DebugConsole;
import hpp.util.DeviceData;
import hpp.util.JsFullScreenUtil;
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
	var fullScreenDemoButton:HPPButton;
	var debugConsoleDemoButton:HPPButton;
	
	var changeSubStateCallback:SubStateType->Void;
	
	public function new( changeSubStateCallback:SubStateType->Void )
	{
		super();
		
		this.changeSubStateCallback = changeSubStateCallback;
		
		build();
	}
	
	function build():Void 
	{
		setTitle("Choose a demo");
		
		mainContainer.add(layoutDemoButton = new MenuButton("Layout", openHPPLayoutDemo));
		mainContainer.add(buttonDemoButton = new MenuButton("Button", openHPPButtonDemo));
		mainContainer.add(touchScrollContainerDemoButton = new MenuButton("Touch scroll container", openHPPTouchScrollContainerDemo));
		mainContainer.add(fullScreenDemoButton = new MenuButton("Toggle full screen", function (_) { JsFullScreenUtil.toggleFullScreen(); } ));
		mainContainer.add(debugConsoleDemoButton = new MenuButton("Show debug console", openDebugConsole));
		
		var deviceInfo:FlxText = new FlxText(0, 0, 300, "Your device is: " + (DeviceData.isMobile() ? "MOBILE" : "DESKTOP"), 14);
		deviceInfo.alignment = "center";
		deviceInfo.font = Fonts.DEFAULT_FONT;
		mainContainer.add(deviceInfo);
		
		rePosition();
	}
	
	function openHPPLayoutDemo(target:HPPButton):Void
	{
		DebugConsole.add("open HPPLayoutDemo");
		
		changeSubStateCallback(SubStateType.STATE_HPP_LAYOUT);
	}
	
	function openHPPButtonDemo(target:HPPButton):Void
	{
		DebugConsole.add("open HPPButtonDemo");
		
		changeSubStateCallback(SubStateType.STATE_HPP_BUTTON);
	}
	
	function openHPPTouchScrollContainerDemo(target:HPPButton):Void
	{
		DebugConsole.add("open HPPTouchScrollContainerDemo");
		
		changeSubStateCallback(SubStateType.STATE_HPP_TOUCH_SCROLL_CONTAINER);
	}
	
	function openDebugConsole(target:HPPButton):Void 
	{
		DebugConsole.add("open DebugConsole - You can close it with a simple click");
		
		DebugConsole.show();
	}
}