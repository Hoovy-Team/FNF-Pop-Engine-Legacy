package options.game;

import Alphabet;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.FlxSubState;

class GameSettingSubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['Kill One Miss', 'Hide Health Bar', 'Hide score info', 'Health Drain', 'Exit'];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<Alphabet>;

	var save = new FlxSave();

	public function new()
	{
		super();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);
		
		grpOptionsTexts = new FlxTypedGroup<Alphabet>();
		add(grpOptionsTexts);

		selector = new FlxSprite().makeGraphic(5, 5, FlxColor.RED);
		add(selector);

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "Game Setting State" + " | " + "Press Enter to enable setting", 12);
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
			var optionText:Alphabet = new Alphabet(20, 50 + (i * 100), textMenuItems[i], true, false);
			optionText.ID = i;
			optionText.isMenuItem = true;
			optionText.targetY = i;
			grpOptionsTexts.add(optionText);
		}
		// grpOptionsTexts.forEach(function(txt:Alphabet)
		// 	{				
		// 		if (txt.ID != 0)
		// 			txt.alpha = 0.6;
		// 	});
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
				case "Kill One Miss":
					if(!save.data.options.contains("Kill One Miss")){
						save.data.options.push("Kill One Miss");
					}else{
						save.data.options.remove("Kill One Miss");
					}
					trace("Kill One Miss change");
				case "Hide Health Bar":
					if(!save.data.options.contains("Hide Health Bar")){
						save.data.options.push("Hide Health Bar");
					}else{
						save.data.options.remove("Hide Health Bar");
					}
					trace("Hide Health Bar change");
				case "Hide score info":
					if(!save.data.options.contains("Hide score info")){
						save.data.options.push("Hide score info");
					}else{
						save.data.options.remove("Hide score info");
					}
					trace("Hide score info change");
				case "Health Drain":
					if(!save.data.options.contains("Health Drain")){
						save.data.options.push("Health Drain");
					}else{
						save.data.options.remove("Health Drain");
					}
					trace("Health Drain change");
				case "Exit":
					FlxG.state.closeSubState();
					FlxG.switchState(new FreeplayState());
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
