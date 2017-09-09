package hppdemo.substate;

import flixel.FlxG;
import flixel.text.FlxText;
import hpp.flixel.ui.HPPButton;
import hpp.flixel.ui.HPPExtendableButton;
import hpp.flixel.ui.HPPHUIBox;
import hppdemo.Fonts;

/**
 * ...
 * @author Krisztian Somoracz
 */ 
class DemoButton extends BaseSubState
{
	var hppButtonA:HPPButton;
	var hppButtonB:HPPButton;
	var hppExtendableButton:HPPExtendableButton;
	
	var actionText:FlxText;
	
	public function new() 
	{
		super();
		
		build();
	}
	
	function build():Void
	{
		setTitle( "Try the improved onClick detection, the new mouse over scale effect and the new HPPExtendableButton." );
		
		actionText = new FlxText();
		actionText.size = 20;
		actionText.font = Fonts.DEFAULT_FONT;
		actionText.text = "You will see here the click target after click.";
		actionText.fieldWidth = FlxG.width - 100;
		actionText.alignment = "center";
		mainContainer.add( actionText );
		
		var buttonContainer:HPPHUIBox = new HPPHUIBox( 20 );
		
		buttonContainer.add( hppButtonA = new HPPButton( "Demo Button", hppButtonClicked, "demo_content_box" ) );
		hppButtonA.label.font = Fonts.DEFAULT_FONT;
		hppButtonA.labelSize = 20;
		hppButtonA.overScale = 1.05;
		
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
		
		mainContainer.add( buttonContainer );
		
		rePosition();
	}
	
	function hppButtonClicked( target:HPPButton ):Void
	{
		actionText.text = target + " clicked";
	}
}