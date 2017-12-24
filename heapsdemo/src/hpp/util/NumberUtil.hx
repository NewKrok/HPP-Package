package hpp.util;

/**
 * ...
 * @author Krisztian Somoracz
 */
class NumberUtil 
{
	public static function formatNumber( number:Float, spacer:String = " " ):String
	{
		var fission:Int = 3;

		var resultNumber:String = Std.string( number );
		var resultRemainder:String = "";
		var dotIndex:Int = resultNumber.indexOf( "." );

		if ( dotIndex != -1 )
		{
			resultRemainder = resultNumber.substr( dotIndex, resultNumber.length );
			resultNumber = resultNumber.substr( 0, dotIndex );
		}
		
		if ( resultNumber.length <= fission )
		{
			return resultNumber + resultRemainder;
		}

		var spacerCount:Int = Math.floor( resultNumber.length / fission );
		var spacerIndex:Int = resultNumber.length - fission;

		for ( i in 0...spacerCount )
		{
			resultNumber = resultNumber.substring( 0, spacerIndex ) + spacer + resultNumber.substring( spacerIndex, resultNumber.length );
			spacerIndex -= fission;
		}

		return resultNumber + resultRemainder;
	}
}