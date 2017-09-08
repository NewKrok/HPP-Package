package hppdemo.substate;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import hpp.flixel.ui.HPPButton;
import hpp.flixel.ui.HPPExtendableButton;
import hppdemo.Fonts;

/**
 * ...
 * @author Krisztian Somoracz
 */ 
class DemoButton extends FlxSubState
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
		actionText = new FlxText();
		actionText.size = 20;
		actionText.font = Fonts.DEFAULT_FONT;
		actionText.text = "";
		actionText.alignment = "center";
		actionText.y = FlxG.height / 2 - actionText.height - 120;
		add( actionText );
		
		hppButtonA = new HPPButton( "Demo Button", hppButtonClicked, "demo_content_box" );
		add( hppButtonA );
		hppButtonA.x = FlxG.stage.width / 2 - hppButtonA.width - 20;
		hppButtonA.y = actionText.y + actionText.height + 40;
		hppButtonA.label.font = Fonts.DEFAULT_FONT;
		hppButtonA.labelSize = 20;
		hppButtonA.overScale = 1.05;
		
		hppButtonB = new HPPButton( "Demo Button", hppButtonClicked, "demo_content_box" );
		add( hppButtonB );
		hppButtonB.x = FlxG.stage.width / 2 + 20;
		hppButtonB.y = actionText.y + actionText.height + 40;
		hppButtonB.label.font = Fonts.DEFAULT_FONT;
		hppButtonB.labelSize = 20;
		hppButtonB.overScale = .95;
		
		add( hppExtendableButton = new HPPExtendableButton( hppButtonClicked, "demo_content_box" ) );
		hppExtendableButton.overScale = 1.05;
		hppExtendableButton.x = FlxG.stage.width / 2 - hppExtendableButton.width / 2;
		hppExtendableButton.y = hppButtonA.y + hppButtonA.height + 20;
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
	}
	
	function hppButtonClicked( target:HPPButton ):Void
	{
		actionText.text = target + " clicked";
		actionText.x = FlxG.stage.width / 2 - actionText.width / 2;
	}
}