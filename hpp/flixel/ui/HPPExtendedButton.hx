package hpp.flixel.ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPExtendedButton extends FlxSpriteGroup
{
	var button:HPPButton;
	
	public function new( onClick:Void->Void = null, graphicId:String = null )
	{
		super();
		
		add( button = new HPPButton( "", onClick, graphicId ) );
	}
	
	override public function add( sprite:FlxSprite ):FlxSprite 
	{
		super.add( sprite );
		button.resize( width, height );
		
		return sprite;
	}
}