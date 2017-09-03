package hppdemo.view;

import flixel.text.FlxText;
import flixel.util.FlxColor;
import hpp.flixel.ui.HPPExtendedButton;
import hpp.flixel.util.HPPAssetManager;

/**
 * ...
 * @author Krisztian Somoracz
 */
class ContentBox extends HPPExtendedButton
{
	var textContent:FlxText;
	var text:String;
	var onSelectCallback:ContentBox->Void;

	public function new( text:String = "", onSelectCallback:ContentBox->Void ) 
	{
		super( onClick );
		
		this.onSelectCallback = onSelectCallback;
		this.text = text;
		
		build();
	}
	
	function onClick():Void
	{
		onSelectCallback( this );
	}
	
	function build():Void 
	{
		add( HPPAssetManager.getSprite( "demo_content_box" ) );
		
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