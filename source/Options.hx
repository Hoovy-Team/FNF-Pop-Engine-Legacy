package;

import flixel.FlxG;
import flixel.util.FlxSave;
import Main;
import openfl.Lib;

class Options
{
	public static var save = new FlxSave();

	static public function optionsLoad()
	{
		save.bind("Options");
		try{
			if(save.data.options == null)
				save.data.options = new Array<String>();
				save.data.options[0] = "";
		}catch(e){
			trace("not work");
		}
	}
}
