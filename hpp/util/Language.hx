package hpp.util;

import haxe.ds.Map;

/**
 * ...
 * @author Krisztian Somoracz
 */
class Language
{
	static var data:Map<String, String> = new Map<String, String>();
	static var textHolders:Map<TextHolder, TextData> = new Map<TextHolder, TextData>();

	public static function setLang(data:Map<String, String>)
	{
		Language.data = data;

		for (key in textHolders.keys())
		{
			var textData:TextData = textHolders.get(key);
			key.set_text(Language.get(textData.text, textData.params));
		}
	}

	public static function get(key:String, params:Map<String, Dynamic> = null):String
	{
		var result = Language.data.get(key);

		if (params != null)
			for (key in params.keys())
				result = StringTools.replace(result, key, params.get(key));

		return result;
	}

	public static function registerTextHolder(textHolder:TextHolder, textKey:String, params:Map<String, Dynamic> = null):Void
	{
		if (!textHolders.exists(textHolder))
		{
			textHolders.set(textHolder, { text: textKey, params: params });
			textHolder.set_text(Language.get(textKey, params));
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

		textHolders = new Map<TextHolder, TextData>();
	}
}

typedef TextHolder =
{
	var set_text:String->Void;
}

typedef TextData =
{
	var text:String;
	var params:Map<String, Dynamic>;
}