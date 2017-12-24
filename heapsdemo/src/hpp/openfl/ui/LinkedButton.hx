package hpp.openfl.ui;

import openfl.display.DisplayObject;

/**
 * ...
 * @author Krisztian Somoracz
 */
class LinkedButton extends BaseButton
{
	public var links:Array<LinkedButton>;

	public function new(
		onClick:BaseButton->Void = null,
		text:String = "",
		baseGraphic:DisplayObject = null,
		overGraphic:DisplayObject = null,
		selectedGraphic:DisplayObject = null,
		font:String = "Verdana"
	)
	{
		super(onClick, text, baseGraphic, overGraphic, selectedGraphic, font);

		links = [];
		isSelectable = true;
		isSelected = false;
		linkToButton(this);
	}

	public function linkToButtonList(buttons:Array<LinkedButton>):Void
	{
		buttons.map(linkToButton);
	}

	public function linkToButton(button:LinkedButton):Void
	{
		links.push(button);
		button.onSelected = function(target:BaseButton)
		{
			if (target.isSelected)
			{
				target.isEnabled = false;

				for (activeButton in links)
				{
					if (activeButton != target)
					{
						activeButton.isSelected = false;
						activeButton.isEnabled = true;
					}
				}
			}
		}

		updateLinks();
	}

	function updateLinks()
	{
		for (button in links) if(button != this) button.links = links;
	}
}