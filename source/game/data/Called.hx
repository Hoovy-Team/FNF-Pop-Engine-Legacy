package game.data;

import flixel.util.FlxSave;
import flixel.FlxG;

class Called
{
    var save = new FlxSave();

    function saveOpt()
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

    public static function recoverAnimation(obj:String)
    {
        if (obj == "bf")
        {
            PlayState.boyfriend.playAnim('idle', true);
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
}