package options.development;

import Alphabet;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.FlxSubState;
import OptionsMenu;

// in progress

class DevelopmentSubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['Always Full Health', 'Always Low Health', 'Disable Gain Health', 'Disable Drain Health', 'Enable CHEAT Key', 'Exit'];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<Alphabet>;

	var save = new FlxSave();

	var textOptions:FlxText;

	public function new()
	{
		super();

		grpOptionsTexts = new FlxTypedGroup<Alphabet>();
		add(grpOptionsTexts);

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "Development State | Press Enter to enable setting", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		save.bind("Options");
		try{
			if(save.data.options == null)
				save.data.options = new Array<String>();
				save.data.options[0] = "";
		}catch(e){
			trace("not work");
		}

		for (i in 0...textMenuItems.length)
		{
			var optionText:Alphabet = new Alphabet(0, 50 + (i * 100), textMenuItems[i], true, false);
			optionText.ID = i;
			optionText.isMenuItem = true;
			optionText.targetY = i;
			grpOptionsTexts.add(optionText);
		}
		// grpOptionsTexts.forEach(function(txt:Alphabet)
		// {				
		// 	if (txt.ID != 0)
		// 		txt.alpha = 0.6;
		// });
		textOptions = new FlxText(0, FlxG.height * 0.9 + 0, FlxG.width, "Help you play less miss", 35);
		textOptions.scrollFactor.set();
		textOptions.setFormat(Paths.ttffont("phantommuffin"), 35, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(textOptions);	

		changeSelection();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UP_P)
			changeSelection(-1);

		if (controls.DOWN_P)
			changeSelection(1);

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;

		if (curSelected >= textMenuItems.length)
			curSelected = 0;

		grpOptionsTexts.forEach(function(txt:Alphabet)
		{
			txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected && save.data.options.contains(txt.text))
				txt.color = FlxColor.GREEN;
			else if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
			else
				txt.color = FlxColor.WHITE;
				
		});

		if(controls.BACK)
		{
			FlxG.state.closeSubState();
			FlxG.state.openSubState(new OptionsSubState());
		}

		if (controls.ACCEPT)
		{
			switch (textMenuItems[curSelected])
			{

				case "Exit":
					FlxG.state.closeSubState();
					FlxG.state.openSubState(new OptionsSubState());
			}
		}
	}

	function changeSelection(change:Int = 0)
	{
		if (change != 0)
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;
		else if (curSelected >= textMenuItems.length)
			curSelected = 0;

		var stuff:Int = 0;

		switch (textMenuItems[curSelected]){

			case "Exit":
				textOptions.text = "Return Options Menu";
		}

		for (item in grpOptionsTexts.members)
		{
			item.targetY = stuff - curSelected;
			stuff ++;

			item.alpha = 0.6;

			if (item.targetY == 0)
				item.alpha = 1;
		}

	}
}