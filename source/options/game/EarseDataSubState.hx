package options.game;

import Alphabet;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import lime.utils.Assets;

class EarseDataSubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['EARSE ALL DATA', 'Exit'];

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

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "Earse State" + " | " + "Press Enter to delete data", 12);
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
			else if (txt.ID == 0)
				txt.color = FlxColor.RED;
			else if (txt.ID == 1)
				txt.color = FlxColor.GREEN;
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
				case "EARSE ALL DATA": //Finaly, done the earse data!!!!!!!!!!!!!!!!!!!!!
					trace('are you sure?');
					//Debug.displayAlert("THIS IS WILL BE EARSE ALL DATA YOU SET AND POINT!!!!!!!!!!!!");
					save.data.options.remove("Time Bar");
					save.data.options.remove("Accuracy");
					save.data.options.remove("Downscroll");
					save.data.options.remove("Ghost tap");
					save.data.options.remove("Watermark");
					save.data.options.remove("Kill One Miss");
					save.data.options.remove("Hide Health Bar");
					save.data.options.remove("Hide score info");
					save.data.options.remove("Health Drain");
					var save = new FlxSave();
					save.flush();
					sys.io.File.saveContent(Paths.txt('options/keybinds/left'), 'A');
					sys.io.File.saveContent(Paths.txt('options/keybinds/down'), 'S');
					sys.io.File.saveContent(Paths.txt('options/keybinds/up'), 'W');
					sys.io.File.saveContent(Paths.txt('options/keybinds/right'), 'D');
					FlxG.updateFramerate = 60;
					FlxG.drawFramerate = 60;
					//FlxG.updateFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
					//FlxG.drawFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
					trace('Earse all data done');
					//Debug.displayAlert("EARSE AND RESET ALL DONE!");
					//Sys.exit(0);
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
