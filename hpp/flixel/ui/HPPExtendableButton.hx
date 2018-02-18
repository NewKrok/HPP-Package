package hpp.flixel.ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPExtendableButton extends FlxSpriteGroup
{
	public var overScale:Float = 1;

	var button:HPPButton;

	public function new(onClick:HPPButton->Void = null, graphicId:String = null)
	{
		super();

		super.add(button = new HPPButton("", onClick, graphicId));

		button.onMouseOver = onMouseOver;
		button.onMouseOut = onMouseOut;
	}

	function onMouseOver()
	{
		scale.set(overScale, overScale);
	}

	function onMouseOut()
	{
		scale.set(1, 1);
	}

	override public function add(sprite:FlxSprite):FlxSprite
	{
		super.add(sprite);

		return sprite;
	}
}