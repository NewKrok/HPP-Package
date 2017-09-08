package hpp.flixel.ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPExtendableButton extends FlxSpriteGroup
{
	public var overScale( get, set ):Float;
	
	var button:HPPButton;
	
	public function new( onClick:HPPButton->Void = null, graphicId:String = null )
	{
		super();
		
		super.add( button = new HPPButton( "", onClick, graphicId ) );
		
		button.onMouseOver = onMouseOver;
		button.onMouseOut = onMouseOut;
	}
	
	function onMouseOver() 
	{
		scale.set( button.overScale, button.overScale );
	}
	
	function onMouseOut() 
	{
		scale.set( 1, 1 );
	}
	
	override public function add( sprite:FlxSprite ):FlxSprite 
	{
		super.add( sprite );
		
		return sprite;
	}
	
	public function get_overScale():Float
	{
		return button.overScale;
	}
	
	public function set_overScale( value:Float ):Float
	{
		return button.overScale = value;
	}
}