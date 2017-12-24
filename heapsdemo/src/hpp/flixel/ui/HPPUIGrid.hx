package hpp.flixel.ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPUIGrid extends FlxSpriteGroup
{
	var gridSize( default, set ):FlxPoint;
	var gridSizeForCalculation:FlxPoint;
	
	var verticalGap( default, set ):Float;
	var horizontalGap( default, set ):Float;
	
	var drawedRow:Int;
	var drawedCol:Int;
	
	var col(default, set):UInt;
	
	var isInitProcessEnded:Bool;
	
	public function new( col:UInt, gap:Float = 0, gridSize:FlxPoint = null ) 
	{
		super();
		
		isInitProcessEnded = false;
		
		this.col = col;
		this.gridSize = gridSize;
		this.verticalGap = gap;
		this.horizontalGap = gap;
		
		isInitProcessEnded = true;
	}
	
	override public function add( child:FlxSprite ):FlxSprite
	{
		super.add( child );
		
		orderElements();
		
		return child;
	}
	
	function orderElements():Void
	{
		if ( isInitProcessEnded )
		{
			if ( gridSize == null && group.members.length > 0 )
			{
				var firstChild:FlxSprite = group.members[0];
				gridSizeForCalculation = new FlxPoint( firstChild.width, firstChild.height );
			}
			
			var currentCol:Int = 0;
			var currentRow:Int = 0;

			for ( child in group )
			{	
				child.x = getColPositionByIndex( currentCol ) + gridSizeForCalculation.x / 2 - child.width / 2;
				child.y = getRowPositionByIndex( currentRow ) + gridSizeForCalculation.y / 2 - child.height / 2;
				
				currentCol++;
				if ( currentCol == col )
				{
					currentCol = 0;
					currentRow++;
				}
			}
			
			drawedRow = currentRow;
			drawedCol = currentCol;
		}
	}
	
	function getRowPositionByIndex( index:UInt ):Float
	{
		return index * gridSizeForCalculation.y + index * verticalGap;
	}
	
	function getColPositionByIndex( index:UInt ):Float
	{
		return index * gridSizeForCalculation.x + index * horizontalGap;
	}
	
	function set_gridSize( value:FlxPoint ):FlxPoint 
	{
		gridSize = value;
		gridSizeForCalculation = value;
		
		orderElements();
		
		return gridSize;
	}
	
	function set_verticalGap( value:Float ):Float 
	{
		verticalGap = value;
		
		orderElements();
		
		return verticalGap;
	}
	
	function set_horizontalGap( value:Float ):Float 
	{
		horizontalGap = value;
		
		orderElements();
		
		return horizontalGap;
	}
	
	function set_col( value:UInt ):UInt 
	{
		col = value;
		
		orderElements();
		
		return col;
	}
}