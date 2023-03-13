package options;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class SizeSubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['Score text', 'Time text', 'Exit'];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<Alphabet>;

	var scoreTxt:Int = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/scoreTxt')));
    var timeTxt:Int = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/timeTxt')));

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
            case "Score text":
                text.text = Std.string(scoreTxt);

            case "Time text":
                text.text = Std.string(timeTxt);

            case "Exit":
                text.text = "";
        }

		if(controls.LEFT){
			if(textMenuItems[curSelected] == "Score text" && scoreTxt >= 11){
				scoreTxt -= 1;
				sys.io.File.saveContent(Paths.txt('options/scoreTxt'), Std.string(scoreTxt));
			}

            if(textMenuItems[curSelected] == "Time text" && timeTxt >= 11){
				timeTxt -= 1;
				sys.io.File.saveContent(Paths.txt('options/timeTxt'), Std.string(timeTxt));
			}
		}
    
		if(controls.RIGHT){
			if(textMenuItems[curSelected] == "Score text" && scoreTxt <= 21){
				scoreTxt += 1;
				sys.io.File.saveContent(Paths.txt('options/scoreTxt'), Std.string(scoreTxt));
			}

            if(textMenuItems[curSelected] == "Time text" && timeTxt <= 33){
				timeTxt += 1;
				sys.io.File.saveContent(Paths.txt('options/timeTxt'), Std.string(timeTxt));
			}
		}
	}

	function changeSelection(change:Int = 0)
	{
		if (change != 0)
			FlxG.sound.play(Paths.sound('scrollMenu', 'preload'), 0.4);

		curSelected += change;

        switch(textMenuItems[curSelected])
        {
            case "Score text":
                text.text = Std.string(scoreTxt);
                textOptions.text = "Change Size of Score Text";

            case "Time text":
                text.text = Std.string(timeTxt);
                textOptions.text = "Change Size of Time Text";

            case "Exit":
                text.text = "";
                textOptions.text = "Return Misc Options";
        }

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