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

class FPSSubState extends FlxSubState
{
	var textMenuItems:Array<String> = ['FPS', 'Exit'];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<Alphabet>;


	var botplayOptionsEnabledTxt:Alphabet;
	var ghostTappingEnabledTxt:Alphabet;

    var fpsCounter:Alphabet;

	var FPS:Int = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
	var fpsText:FlxText;

	public static var MUSICBEATSTATE:MusicBeatState;
	
	public function new()
	{
		super();
		
		grpOptionsTexts = new FlxTypedGroup<Alphabet>();
		add(grpOptionsTexts);


		selector = new FlxSprite().makeGraphic(5, 5, FlxColor.RED);
		add(selector);

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "FPS State" + " | " + "Press Left or Right in fps Selected will be +1 or -1 fps", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		for (i in 0...textMenuItems.length)
		{
			var optionText:Alphabet = new Alphabet(20, 20 + (i * 100), textMenuItems[i], true, false);
			optionText.ID = i;

			optionText.isMenuItem = true;
			optionText.targetY = i;
			
            trace(optionText.text);
			grpOptionsTexts.add(optionText);
		}
		fpsText = new FlxText(800, 30, 0, Std.string(FPS), 80);
		fpsText.setFormat(Paths.font("vcr.ttf"), 80, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		fpsText.scrollFactor.set();
		add(fpsText);
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
						//FlxG.sound.play(Paths.sound('confirmMenu'));
						FlxG.state.openSubState(new OptionsSubState());
				}
			}
			fpsText.text = "FPS: " + Std.string(FPS);
			if(MUSICBEATSTATE.controls.LEFT){
				if(textMenuItems[curSelected] == "FPS" && FPS >= 59){
					FPS -= 1;
					sys.io.File.saveContent(Paths.txt('options/fps'), Std.string(FPS));
					FlxG.updateFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
					FlxG.drawFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
					
				}
			}
			if(MUSICBEATSTATE.controls.RIGHT){
				if(textMenuItems[curSelected] == "FPS" && FPS <= 239){
					FPS += 1;
					sys.io.File.saveContent(Paths.txt('options/fps'), Std.string(FPS));
					FlxG.updateFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
					FlxG.drawFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
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