package options;

import Alphabet;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.FlxSubState;

class PerferncesSubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['Ghost tap', 'Downscroll', 'Accuracy', 'Time Bar', 'NPS Display', 'Exit'];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<Alphabet>;

	var save = new FlxSave();

	public function new()
	{
		super();

		grpOptionsTexts = new FlxTypedGroup<Alphabet>();
		add(grpOptionsTexts);

		selector = new FlxSprite().makeGraphic(5, 5, FlxColor.RED);
		add(selector);

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "Perfernces State | Press Enter to enable setting", 12);
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
		grpOptionsTexts.forEach(function(txt:Alphabet)
			{				
				if (txt.ID != 0)
					txt.alpha = 0.6;
			});
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
				case "Ghost tap":
					if(!save.data.options.contains("Ghost tap")){
						save.data.options.push("Ghost tap");
					}else{
						save.data.options.remove("Ghost tap");
					}
					trace("Ghost tap change");
				case "Downscroll":
					if(!save.data.options.contains("Downscroll")){
						save.data.options.push("Downscroll");
					}else{
						save.data.options.remove("Downscroll");
					}
					trace("Downscroll change");
				case "Accuracy":
					if(!save.data.options.contains("Accuracy")){
						save.data.options.push("Accuracy");
					}else{
						save.data.options.remove("Accuracy");
					}
					trace("Accuracy change");
				case "Time Bar":
					if(!save.data.options.contains("Time Bar")){
						save.data.options.push("Time Bar");
					}else{
						save.data.options.remove("Time Bar");
					}
					trace("Time Bar change");
				case "NPS Display":
					if(!save.data.options.contains("NPS Display")){
						save.data.options.push("NPS Display");
					}else{
						save.data.options.remove("NPS Display");
					}
					trace("NPS Display change");
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
