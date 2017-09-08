package hppdemo.view;

import flixel.text.FlxText;
import flixel.util.FlxColor;
import hpp.flixel.ui.HPPButton;
import hpp.flixel.ui.HPPExtendableButton;
import hpp.flixel.util.HPPAssetManager;

/**
 * ...
 * @author Krisztian Somoracz
 */
class ContentBox extends HPPExtendableButton
{
	var textContent:FlxText;
	var text:String;
	var onSelectCallback:ContentBox->Void;

	public function new( text:String = "", onSelectCallback:ContentBox->Void ) 
	{
		super( onClick, "demo_content_box" );
		
		this.onSelectCallback = onSelectCallback;
		this.text = text;
		
		build();
	}
	
	function onClick( target:HPPButton ):Void
	{
		onSelectCallback( this );
	}
	
	function build():Void 
	{
		textContent = new FlxText( 0, 0, width, text, 12 );
		textContent.font = Fonts.DEFAULT_FONT;
		textContent.alignment = "center";
		textContent.y = height / 2 - textContent.height / 2;
		add( textContent );
	}
	
	public function select():Void
	{
		textContent.text = text + "\n" + "SELECTED";
		textContent.y = y + height / 2 - textContent.height / 2;
		textContent.color = FlxColor.YELLOW;
	}
	
	public function deselect():Void
	{
		textContent.text = text;
		textContent.y = y + height / 2 - textContent.height / 2;
		textContent.color = FlxColor.WHITE;
	}
}