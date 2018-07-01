package hpp.util;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPServices
{
	public static function init(containerId:String, appId:String)
	{
		untyped __js__("window.HPPServices.init(containerId, appId);");
	}

	public static function open()
	{
		untyped __js__("window.HPPServices.open();");
	}

	public function close()
	{
		untyped __js__("window.HPPServices.close();");
	}
}