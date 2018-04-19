package hpp.util;

import haxe.ds.Map;

/**
 * ...
 * @author Krisztian Somoracz
 */
class Language
{
	static var data:Map<String, String> = new Map<String, String>();
	static var textHolders:Map<TextHolder, String> = new Map<TextHolder, String>();

	public static function setLang(data:Map<String, String>)
	{
		Language.data = data;

		for (key in textHolders.keys()) key.set_text(Language.get(textHolders.get(key)));
	}

	public static function get(key:String):String
	{
		return Language.data.get(key);
	}

	public static function registerTextHolder(textHolder:TextHolder, textKey:String):Void
	{
		if (!textHolders.exists(textHolder))
		{
			textHolders.set(textHolder, textKey);
			textHolder.set_text(Language.get(textKey));
		}
		else trace('Warning: Language registerTextHolder: $textKey');
	}

	public static function unregisterTextHolder(textHolder:TextHolder):Void
	{
		if (textHolders.exists(textHolder)) textHolders.remove(textHolder);
		else trace('Warning: Language unregisterTextHolder: ${textHolders.get(textHolder)}');
	}

	public static function disposeAllTextHolder():Void
	{
		for (key in textHolders.keys())
		{
			key.set_text("");
			textHolders.remove(key);
		}

		textHolders = new Map<TextHolder, String>();
	}
}

typedef TextHolder =
{
	var set_text:String->Void;
}

typedef TextHolderData =
{
	var textHolder:TextHolder;
	var text:String;
}