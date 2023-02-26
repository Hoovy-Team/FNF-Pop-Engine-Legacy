package options;

import Alphabet;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.FlxSubState;
import OptionsMenu;

class PerferncesSubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['Ghost tap', 'Downscroll', 'Accuracy', 'Time Bar', 'NPS Display', 'Note Glow', 'More GUI', 'Note Splash', 'Exit'];

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
				case "Note Glow":
					if(!save.data.options.contains("Note Glow")){
						save.data.options.push("Note Glow");
					}else{
						save.data.options.remove("Note Glow");
					}
					trace("Note Glow change");
				case "More GUI":
					if(!save.data.options.contains("More GUI")){
						save.data.options.push("More GUI");
					}else{
						save.data.options.remove("More GUI");
					}
					trace("More GUI change");
				case "Note Splash":
					if(!save.data.options.contains("Note Splash")){
						save.data.options.push("Note Splash");
					}else{
						save.data.options.remove("Note Splash");
					}
					trace("Note Splash change");
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
			case "Ghost tap":
				textOptions.text = "Help you play less miss";
			case "Downscroll":
				textOptions.text = "Change the layout from up to down";
			case "Accuracy":
				textOptions.text = "Add the accuracy system and more";
			case "Time Bar":
				textOptions.text = "See how long the songs will play";
			case "NPS Display":
				textOptions.text = "Like KPS, NPS working like this";
			case "Note Glow":
				textOptions.text = "Add note glow for player 2 note";
			case "More GUI":
				textOptions.text = "Add sicks, goods, bads and shits on display";
			case "Note Splash":
				textOptions.text = "Enable it, when hit sicks, the splash will show";
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
