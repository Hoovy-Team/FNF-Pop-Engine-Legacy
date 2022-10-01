package listUpdate;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import sys.io.File;

using StringTools;

class ListSubStateUpdate extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = [];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<FlxText>;

	public function new()
	{
		super();

		grpOptionsTexts = new FlxTypedGroup<FlxText>();
		textMenuItems = CoolUtil.coolTextFile(Paths.txt('updateList/updateList'));
		add(grpOptionsTexts);

		// selector = new FlxSprite().makeGraphic(5, 5, FlxColor.RED);
		// add(selector);

		for (i in 0...textMenuItems.length)
		{
			var optionText:FlxText = new FlxText(20, 20 + (i * 100), 0, textMenuItems[i], 32);
			optionText.ID = i;
			grpOptionsTexts.add(optionText);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UP_P)
			curSelected -= 1;

		if (controls.DOWN_P)
			curSelected += 1;

		if (controls.LEFT_P)
			textMenuItems = CoolUtil.coolTextFile(Paths.txt('updateList/updateList_0_0_4'));

		if (controls.RIGHT_P)
			textMenuItems = CoolUtil.coolTextFile(Paths.txt('updateList/updateList'));
		
		if (controls.BACK)
			FlxG.switchState(new MainMenuState());

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;

		if (curSelected >= textMenuItems.length)
			curSelected = 0;

		grpOptionsTexts.forEach(function(txt:FlxText)
		{
			txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
		});

		if (controls.ACCEPT)
		{
		}
	}
}