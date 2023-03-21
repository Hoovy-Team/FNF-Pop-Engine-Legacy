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

class MiscSubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = [
		'Size', 
		'Float Changer',
		'Window Size',
		'Color Text',  
		'Watermark', 
		'Count down note', 
		'Health text', 
		'Botplay', 
		'Reset Key',
		// 'Hey Animation',
		'Exit'
	];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<Alphabet>;

	var textOptions:FlxText;

	var save = new FlxSave();

	public function new()
	{
		super();

		save.bind("Options");
		try{
			if(save.data.options == null)
				save.data.options = new Array<String>();
				save.data.options[0] = "";
		}catch(e){
			trace("not work");
		}

		grpOptionsTexts = new FlxTypedGroup<Alphabet>();
		add(grpOptionsTexts);

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "Misc State" + " | " + "Press Enter to enable setting", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		for (i in 0...textMenuItems.length)
		{
			var optionText:Alphabet = new Alphabet(0, 50 + (i * 100), textMenuItems[i], true, false);
			optionText.ID = i;
			optionText.isMenuItem = true;
			optionText.targetY = i;
			grpOptionsTexts.add(optionText);
		}

		textOptions = new FlxText(0, FlxG.height * 0.9 + 0, FlxG.width, "", 35);
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

			if (save.data.options.contains(txt.text))
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
				case "Size":
					FlxG.state.closeSubState();
					FlxG.state.openSubState(new SizeSubState());	
				case "Float Changer":
					FlxG.state.closeSubState();
					FlxG.state.openSubState(new options.game.IntChangeSubState());		
				case "Window Size":
					FlxG.state.closeSubState();
					FlxG.state.openSubState(new options.game.WindowSizeSubState());			
				case "Color Text":
					if(!save.data.options.contains("Color Text")){
						save.data.options.push("Color Text");
					}else{
						save.data.options.remove("Color Text");
					}
					trace("Color Text change");		
				case "Watermark":
					if(!save.data.options.contains("Watermark")){
						save.data.options.push("Watermark");
					}else{
						save.data.options.remove("Watermark");
					}
					trace("Watermark change");
				case "Count down note":
					if(!save.data.options.contains("Count down note")){
						save.data.options.push("Count down note");
					}else{
						save.data.options.remove("Count down note");
					}
					trace("Count down note change");
				case "Health text":
					if(!save.data.options.contains("Health text")){
						save.data.options.push("Health text");
					}else{
						save.data.options.remove("Health text");
					}
					trace("Health text change");
				case "Botplay":
					if(!save.data.options.contains("Botplay")){
						save.data.options.push("Botplay");
					}else{
						save.data.options.remove("Botplay");
					}
					trace("Botplay change");
				case "Reset Key":
					if(!save.data.options.contains("Reset Key")){
						save.data.options.push("Reset Key");
					}else{
						save.data.options.remove("Reset Key");
					}
				// case "Hey Animation":
				// 	if(!save.data.options.contains("Hey Animation")){
				// 		save.data.options.push("Hey Animation");
				// 	}else{
				// 		save.data.options.remove("Hey Animation");
				// 	}					
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

		switch (textMenuItems[curSelected]){
			case "Size":
				textOptions.text = "Change Int of Text size\nIn Gameplay";
			case "Float Changer":
				textOptions.text = "Change Float of the game like gain health, drain health...";
			case "Window Size":
				textOptions.text = "Change Window Size of Game";
			case "Color Text":
				textOptions.text = "When Hit a note, all the text on screen will change\nWhen Miss a note, all text in the screen will change";
			case "Watermark":
				textOptions.text = "Disable or Enable\nPop Engine Watermark";
			case "Count down note":
				textOptions.text = "Display Count Down Note text";
			case "Health text":
				textOptions.text = "Display Health text";
			case "Botplay":
				textOptions.text = "This will help you\nshowcase your chart";
			case "Reset Key":
				textOptions.text = "Press reset key to\nquick dead";
			// case "Hey Animation":
			// 	textOptions.text = "In Blammed Song, GF will do a cheer animation on hey sounds";
			case "Exit":
				textOptions.text = "Return Options Menu";
		}

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
