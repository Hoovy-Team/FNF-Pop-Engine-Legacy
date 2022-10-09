package;

import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
// import Alphabet;
import flixel.addons.transition.FlxTransitionableState;

class CreditsState extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	// var creditsPeople:Array<String> = ['Creator', 'Twingamerdudes', 'KadeDev', 'l1ttleO', 'ninjamuffin99', 'PhantomArcade3K', 'Evilsk8r', 'Kawaisprite'];
	var creditsPeople = CoolUtil.coolTextFile(Paths.txt('creditsList'));
	// var titleCredits:Array<String> = ['Pop Engine', 'Some Code', 'OG Develop'];

	var creditsText:FlxText;
	var textHint:FlxText;
	var titleText:FlxText;

	private var grpControls:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<HealthIcon> = [];

	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		// creditsPeople = CoolUtil.coolTextFile(Paths.txt('controls'));
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		// grpControls.setFormat("Muff99");
		add(grpControls);

		for (i in 0...creditsPeople.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, creditsPeople[i], true, false);
			// controlLabel.screenCenter();
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			// grpControls.screenCenter();
			grpControls.add(controlLabel);

			//var icon:HealthIcon = new HealthIcon(creditsPeople[i]);
			//icon.sprTracker = controlLabel;
//
			//// using a FlxGroup is too much fuss!
			//iconArray.push(icon);
			//add(icon);
		}

		grpControls.forEach(function(txt:Alphabet)
		{				
			if (txt.ID != 0)
				txt.alpha = 0.6;
		});

		super.create();

		textShow();

		// changeSelection();

		// FlxG.state.openSubState(new options.OptionsSubState());
	}

	function textShow() 
	{
		titleText = new FlxText(0, FlxG.height * 0.9 + -600, FlxG.width, "Credits - Shoutouts", 40);
		titleText.scrollFactor.set();
		titleText.setFormat(Paths.ttffont("phantommuffin"), 40, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(titleText);

		creditsText = new FlxText(50, FlxG.height + -75 - 25, 1180, "(Huy1234th) Main of the Pop Engine", 35);
		creditsText.scrollFactor.set();
		creditsText.setFormat(Paths.ttffont("phantommuffin"), 35, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(creditsText);

		textHint = new FlxText(5, FlxG.height - 18, 0, "Press Enter to open the account", 12);
		textHint.scrollFactor.set();
		textHint.setFormat(Paths.ttffont("phantommuffin"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(textHint);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		grpControls.forEach(function(txt:Alphabet)
		{
			txt.color = FlxColor.WHITE;
	
			if (txt.ID == curSelected)
				txt.color = FlxColor.GREEN;
			else if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
			else
				txt.color = FlxColor.WHITE;
				
		});

		if (controls.ACCEPT)
		{
			// changeBinding();
			switch (creditsPeople[curSelected]){
				case "Creator":
					FlxG.openURL("https://gamebanana.com/members/1965608");
				case "KadeDev":
					creditsText.text = "Sorry But we can't find!";
				case "Rozebud":
					FlxG.openURL("https://twitter.com/helpme_thebigt");
				case "Twingamerdudes":
					FlxG.openURL("https://www.youtube.com/c/Twingamerdudes");
				case "l1ttleO":
					FlxG.openURL("https://twitter.com/l1ttleO");
				case "ninjamuffin99":
					FlxG.openURL("https://twitter.com/ninja_muffin99");
				case "PhantomArcade3K":
					FlxG.openURL("https://twitter.com/phantomarcade3k");
				case "Evilsk8r":
					FlxG.openURL("https://twitter.com/evilsk8r");
				case "Kawaisprite":
					FlxG.openURL("https://twitter.com/kawaisprite");
			}
		}
		if (controls.BACK)
			FlxG.switchState(new MainMenuState());
		if (controls.UP_P)
			changeSelection(-1);
		if (controls.DOWN_P)
			changeSelection(1);
	}

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end

		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;
		
		switch (creditsPeople[curSelected]){
			case "Creator":
				creditsText.text = "(Huy1234th) Main of the Pop Engine";
			case "Twingamerdudes":
				creditsText.text = "The guy who teach how to make a options using substate";
			case "KadeDev":
				creditsText.text = "Main of Kade Engine\n(With some code i use)";
			case "Rozebud":
				creditsText.text = "Main of FPS Plus Engine\n(With some code i use too)";
			case "l1ttleO":
				creditsText.text = "Note glow from ProjectFNF";
			case "ninjamuffin99":
				creditsText.text = "Programmer of FNF";
			case "PhantomArcade3K":
				creditsText.text = "Art of FNF";
			case "Evilsk8r":
				creditsText.text = "Art of FNF";
			case "Kawaisprite":
				creditsText.text = "Musician of FNF";
		}

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}