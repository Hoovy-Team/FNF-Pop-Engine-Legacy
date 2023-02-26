package;

import flixel.FlxG;
import flixel.util.FlxSave;
import Main;
import openfl.Lib;

class Options
{
	public static var masterVolume:Float = 1;

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

		// (cast (Lib.current.getChildAt(0), Main)).toggleFPS(save.data.options.contains("FPS Counter"));

		// (cast (Lib.current.getChildAt(0), Main)).toggleMem(save.data.options.contains("Memory Counter"));
	}
}
