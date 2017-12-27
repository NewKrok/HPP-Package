package hpp.heaps.ui;

import h2d.Text;
import h2d.col.Bounds;

/**
 * ...
 * @author Krisztian Somoracz
 */
class TextWithSize extends Text
{
	override public function getSize(?out:Bounds):Bounds
	{
		var result:Bounds = super.getSize(out);

		result.width = textWidth;
		result.height = textHeight;

		return result;
	}
}