package hpp.heaps.ui;

import h2d.Font;
import h2d.Tile;
import hpp.heaps.ui.BaseButton;

/**
 * ...
 * @author Krisztian Somoracz
 */
class LinkedButton extends BaseButton
{
	public var links:Array<LinkedButton>;

	public function new(
		parent = null,
		onClick:BaseButton->Void = null,
		text:String = "",
		baseGraphic:Tile = null,
		overGraphic:Tile = null,
		selectedGraphic:Tile = null,
		disabledGraphic:Tile = null,
		font:Font = null
	){
		super(parent, onClick, text, baseGraphic, overGraphic, selectedGraphic, disabledGraphic, font);

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