package hppdemo.substate;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import hpp.flixel.ui.HPPButton;
import hpp.flixel.ui.HPPExtendableButton;
import hpp.flixel.ui.HPPHUIBox;
import hpp.flixel.ui.HPPToggleButton;
import hppdemo.Fonts;

/**
 * ...
 * @author Krisztian Somoracz
 */ 
class DemoButton extends BaseSubState
{
	var hppButton:HPPButton;
	var hppExtendableButton:HPPExtendableButton;
	var hppToggleButton:HPPToggleButton;
	
	var actionText:FlxText;
	
	public function new() 
	{
		super();
		
		build();
	}
	
	function build():Void
	{
		mainContainer.gap = 40;
		
		setTitle( "Try the improved onClick detection, the new mouse over scale effect, the new HPPExtendableButton and the new HPPToggleButton." );
		
		actionText = new FlxText();
		actionText.size = 20;
		actionText.font = Fonts.DEFAULT_FONT;
		actionText.text = "You will see here the click target after click.";
		actionText.fieldWidth = FlxG.width - 100;
		actionText.alignment = "center";
		mainContainer.add( actionText );
		
		var buttonContainer:HPPHUIBox = new HPPHUIBox( 20 );
		
		buttonContainer.add( hppButton = new HPPButton( "Demo Button", hppButtonClicked, "demo_content_box" ) );
		hppButton.label.font = Fonts.DEFAULT_FONT;
		hppButton.labelSize = 20;
		hppButton.overScale = 1.05;
		
		buttonContainer.add( hppExtendableButton = new HPPExtendableButton( hppButtonClicked, "demo_content_box" ) );
		hppExtendableButton.overScale = 1.05;
		var textA:FlxText = new FlxText( 0, 0, hppExtendableButton.width, "", 12 );
		textA.text = "CONTENT #A";
		textA.font = Fonts.DEFAULT_FONT;
		textA.alignment = "center";
		textA.y = hppExtendableButton.height / 2 - textA.height - 5;
		hppExtendableButton.add( textA );
		var textB:FlxText = new FlxText( 0, 0, hppExtendableButton.width, "", 12 );
		textB.text = "CONTENT #B";
		textB.y = textA.height;
		textB.font = Fonts.DEFAULT_FONT;
		textB.alignment = "center";
		textB.angle = 180;
		textB.y = hppExtendableButton.height / 2 + 5;
		hppExtendableButton.add( textB );
		
		buttonContainer.add( hppToggleButton = new HPPToggleButton( "OFF", "ON", hppToggleButtonClicked, "small_button_dark", "small_button" ) );
		hppToggleButton.font = Fonts.DEFAULT_FONT;
		hppToggleButton.labelSize = 20;
		hppToggleButton.overScale = 1.05;
		hppToggleButton.normalLabel.alignment = "right";
		hppToggleButton.normalLabel.offset.x = 10;
		hppToggleButton.normalLabel.color = FlxColor.WHITE;
		hppToggleButton.selectedLabel.alignment = "right";
		hppToggleButton.selectedLabel.offset.x = 10;
		hppToggleButton.selectedLabel.color = FlxColor.YELLOW;
		hppToggleButton.setNormalIcon( "icon_dark", 10, cast hppToggleButton.height / 2 - 27 / 2 );
		hppToggleButton.setSelectedIcon( "icon_normal", 10, cast hppToggleButton.height / 2 - 27 / 2 );
		
		mainContainer.add( buttonContainer );
		
		rePosition();
	}
	
	function hppButtonClicked( target:HPPButton ):Void
	{
		actionText.text = target + " clicked";
	}
	
	function hppToggleButtonClicked( target:HPPToggleButton ):Void
	{
		actionText.text = target + " clicked (isSelected:" + target.isSelected + ")";
	}
}