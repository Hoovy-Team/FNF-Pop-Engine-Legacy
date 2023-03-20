package options.game;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class IntChangeSubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['Health Gain', 'Health Drain', 'Exit'];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<Alphabet>;

	var healthG:Float = Std.parseFloat(CoolUtil.coolTextFileString(Paths.txt('options/data/healthGain')));
    var healthD:Float = Std.parseFloat(CoolUtil.coolTextFileString(Paths.txt('options/data/healthDrain')));

    var text:FlxText;
    var textOptions:FlxText;

	public function new()
	{
		super();
		
		grpOptionsTexts = new FlxTypedGroup<Alphabet>();
		add(grpOptionsTexts);

		for (i in 0...textMenuItems.length)
		{
			var optionText:Alphabet = new Alphabet(0, 50 + (i * 100), textMenuItems[i], true, false);
			optionText.ID = i;
			optionText.isMenuItem = true;
			optionText.targetY = i;
			grpOptionsTexts.add(optionText);
		}

        text = new FlxText(800, 30, 0, "", 80);
		text.setFormat(Paths.font("vcr.ttf"), 80, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		text.scrollFactor.set();
		add(text);

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "Float Changer State" + " | " + "Hold LEFT or RIGHT to change Float Data", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

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

		if(controls.BACK)
        {
            FlxG.state.closeSubState();
			FlxG.state.openSubState(new MiscSubState());
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

		if (controls.ACCEPT)
		{
			switch (textMenuItems[curSelected])
			{	
				case "Exit":
                    FlxG.state.closeSubState();
                    FlxG.state.openSubState(new MiscSubState());
			}
		}

        switch(textMenuItems[curSelected])
        {
            case "Health Gain":
                text.text = Std.string(healthG);

            case "Health Drain":
                text.text = Std.string(healthD);

            case "Exit":
                text.text = "";
        }

		if(controls.LEFT){
			if(textMenuItems[curSelected] == "Health Gain" && healthG >= 0.51){
				healthG -= 0.01;
				sys.io.File.saveContent(Paths.txt('options/data/healthGain'), Std.string(healthG));
			}

            if(textMenuItems[curSelected] == "Health Drain" && healthD >= 0.51){
				healthD -= 0.01;
				sys.io.File.saveContent(Paths.txt('options/data/healthDrain'), Std.string(healthD));
			}
		}
    
		if(controls.RIGHT){
			if(textMenuItems[curSelected] == "Health Gain" && healthG <= 1.99){
				healthG += 0.01;
				sys.io.File.saveContent(Paths.txt('options/data/healthGain'), Std.string(healthG));
			}

            if(textMenuItems[curSelected] == "Health Drain" && healthD <= 1.99){
				healthD += 0.01;
				sys.io.File.saveContent(Paths.txt('options/data/healthDrain'), Std.string(healthD));
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

        switch(textMenuItems[curSelected])
        {
            case "Health Gain":
                text.text = Std.string(healthG);

            case "Health Drain":
                text.text = Std.string(healthD);

            case "Exit":
                text.text = "";
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