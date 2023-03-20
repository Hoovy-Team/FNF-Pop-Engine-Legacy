package game.data;

import flixel.util.FlxSave;
import flixel.FlxG;
import flixel.input.keyboard.FlxKey;
// global file
class Called
{
    public static var save = new FlxSave();
    public var firstChecker:Bool = true;

    public static var _s:FlxSave;
    public static var _k:FlxKey;

    public static function saveOpt()
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

    public static function firstPlay()
    {
        saveOpt();

        if (!FlxG.save.data.firstPlay)
        {
            trace('you already play it before!');
        }else{
            save.data.options.push("Ghost tap");
            save.data.options.push("Accuracy");
            save.data.options.push("Time Bar");
            save.data.options.push("Note Glow");
            save.data.options.push("Note Splash");
        }
    }

    // all some var
    // public static var healthGain:Float = Std.parseFloat(CoolUtil.coolTextFileString(Paths.txt("options/data/healthGain")));
    // public static var healthDrain:Float = Std.parseFloat(CoolUtil.coolTextFileString(Paths.txt("options/data/healthDrain")));
}