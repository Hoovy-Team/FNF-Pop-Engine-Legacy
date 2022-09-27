#if x86_system
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import WarmVar;

using StringTools;

class WarmSubState extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "IDK";

	override function create()
	{
        transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		super.create();
		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);
		var ver = "v" + Application.current.meta.get('version');
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"Hey You"
            + "\nYour Computer is using 32Bit System"
            + "\nSo you might want to edit the setting"
            + "\n"
            + "\nPress Space to Open Options Menu"
            + "\nOr Press Esc to Skip it",
			32);
		txt.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		txt.screenCenter();
		add(txt);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
            FlxTransitionableState.skipNextTransIn = true;
            FlxTransitionableState.skipNextTransOut = true;
            WarmVar.warmFirst = false;
			FlxG.switchState(new OptionsMenu());
		}
		if (controls.BACK)
		{
			WarmVar.warmFirst = false;
			FlxG.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}
}
#end