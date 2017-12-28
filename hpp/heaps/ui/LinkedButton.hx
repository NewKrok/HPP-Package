package hpp.heaps.ui;

import h2d.Font;
import h2d.Tile;
import hpp.heaps.ui.BaseButton;
import hpp.util.Selector;

/**
 * ...
 * @author Krisztian Somoracz
 */
class LinkedButton extends BaseButton
{
	public var links:Array<LinkedButton>;

	public function new(parent = null, config:BaseButtonConfig = null)
	{
		super(parent, config);

		links = [];
		isSelectable = true;
		linkToButton(this);
		isSelected = Selector.firstNotNull([config.isSelected, false]);
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