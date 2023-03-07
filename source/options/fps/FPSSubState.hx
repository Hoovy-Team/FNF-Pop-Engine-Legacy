package options.fps;

import Alphabet;
import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flixel.util.FlxSave;
import Options;
import openfl.Lib;

class FPSSubState extends FlxSubState
{
	var textMenuItems:Array<String> = ['Type A', 'Type B', 'Type C', 'Type D', 'Maximum Type', 'Exit'];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<Alphabet>;


	var botplayOptionsEnabledTxt:Alphabet;
	var ghostTappingEnabledTxt:Alphabet;

    var fpsCounter:Alphabet;

	var FPS:Int = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
	var fpsText:FlxText;

	public static var MUSICBEATSTATE:MusicBeatState;
	var textOptions:FlxText;
	
	public function new()
	{
		super();
		
		grpOptionsTexts = new FlxTypedGroup<Alphabet>();
		add(grpOptionsTexts);

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "FPS State" + " | " + "Press Left or Right in fps Selected will be +1 or -1 fps", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		for (i in 0...textMenuItems.length)
		{
			var optionText:Alphabet = new Alphabet(0, 20 + (i * 100), textMenuItems[i], true, false);
			optionText.ID = i;
			optionText.isMenuItem = true;
			optionText.targetY = i;
			grpOptionsTexts.add(optionText);
		}

		fpsText = new FlxText(800, 30, 0, Std.string(FPS), 80);
		fpsText.setFormat(Paths.font("vcr.ttf"), 80, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		fpsText.scrollFactor.set();
		add(fpsText);

		textOptions = new FlxText(0, FlxG.height * 0.9 + 0, FlxG.width, "FPS Cap to 60", 35);
		textOptions.scrollFactor.set();
		textOptions.setFormat(Paths.ttffont("phantommuffin"), 35, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(textOptions);

		changeSelection();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (MUSICBEATSTATE.controls.UP_P)
			changeSelection(-1);
			//curSelected -= 1;

		if (MUSICBEATSTATE.controls.DOWN_P)
			changeSelection(1);
			//curSelected += 1;

		if(MUSICBEATSTATE.controls.BACK){
			FlxG.state.openSubState(new OptionsSubState());
		}	

		fpsText.text = "FPS: " + Std.string(FPS);

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;

		if (curSelected >= textMenuItems.length)
			curSelected = 0;

		grpOptionsTexts.forEach(function(txt:Alphabet)
		{
			txt.color = FlxColor.WHITE;
			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
			else {
				txt.color = FlxColor.WHITE;
			}
		});	

		if (MUSICBEATSTATE.controls.ACCEPT)
		{
			switch (textMenuItems[curSelected])
			{	
				case "Exit":
					FlxG.state.openSubState(new OptionsSubState());

				case "Type A":
					FPS = 60;
					sys.io.File.saveContent(Paths.txt('options/fps'), Std.string(FPS));
					FlxG.updateFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
					FlxG.drawFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));

				case "Type B":
					FPS = 120;
					sys.io.File.saveContent(Paths.txt('options/fps'), Std.string(FPS));
					FlxG.updateFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
					FlxG.drawFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));

				case "Type C":
					FPS = 140;
					sys.io.File.saveContent(Paths.txt('options/fps'), Std.string(FPS));
					FlxG.updateFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
					FlxG.drawFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));

				case "Type D":
					FPS = 160;
					sys.io.File.saveContent(Paths.txt('options/fps'), Std.string(FPS));
					FlxG.updateFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
					FlxG.drawFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
			
				case "Maximum Type":
					Lib.current.stage.frameRate = 800;

			}
		}
	}

	function changeSelection(change:Int = 0)
	{
		if (change != 0)
			FlxG.sound.play(Paths.sound('scrollMenu', 'preload'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;
		else if (curSelected >= textMenuItems.length)
			curSelected = 0;

		var stuff:Int = 0;

		switch(textMenuItems[curSelected]){
			case "Type A":
				textOptions.text = "Cap to 60 FPS";
			case "Type B":
				textOptions.text = "Cap to 120 FPS";
			case "Type C":
				textOptions.text = "Cap to 140 FPS";
			case "Type D":
				textOptions.text = "Cap to 160 FPS";
			case "Maximum Type":
				textOptions.text = "Cap to 800 FPS (I Dont wanna crash game though)";
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