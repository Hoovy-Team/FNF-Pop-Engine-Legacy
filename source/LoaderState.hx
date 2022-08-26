package;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import mloader.Loader;
import mloader.ImageLoader;
import mloader.XmlLoader;
import mloader.StringLoader;
import mloader.JsonLoader;
//import lime.utils.Assets;
//import lime.utils.AssetCache;
import lime.app.Application;
//import keyboard.Key;
//import keyboard.Keyboard;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Graphics;

using StringTools;

class LoaderState extends MusicBeatState
{
	var loaderCharTxt:StringLoader;
	var loaderIntroText:StringLoader;
	var loaderSongList:StringLoader;
	var loaderfpsText:StringLoader;

	var dia_senpai:StringLoader;
	var dia_senpai2:StringLoader;
	var dia_senpai3:StringLoader;

	var text:FlxText;
	var text_dia:FlxText;
	var text_offset:FlxText;
	var text_data:FlxText;
	var textDone:FlxText;

	// var loaderCharactersOffset:StringLoader;

	override public function create()
	{
		super.create();

		// Console.log('<b>Start Load</>');

		text = new flixel.text.FlxText(0, 0, 0, "Loading Game, Please wait");
		text.scrollFactor.set();
		text.setFormat("VCR OSD Mono", 64, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		text.screenCenter();
		add(text);

		loaderCharTxt = new StringLoader(LoadDir.assetsDir + "data/list/characterList.txt");
		loaderCharTxt.loaded.add(loaded);
		loaderCharTxt.load();
		
		loaderSongList = new StringLoader(LoadDir.assetsDir + "data/list/freeplaySonglist.txt");
		loaderSongList.loaded.add(loaded);
		loaderSongList.load();

		loaderfpsText = new StringLoader(LoadDir.assetsDir + "data/options/fps.txt");
		loaderfpsText.loaded.add(loaded);
		loaderfpsText.load();

		loaderIntroText = new StringLoader(LoadDir.assetsDir + "data/introText.txt");
		loaderIntroText.loaded.add(loaded);
		loaderIntroText.load();

		DialogueLoad();
	}

	function DialogueLoad(){

		text.visible = false;

		text_dia = new flixel.text.FlxText(0, 0, 0, "Loading Dialogue Game, Please wait");
		text_dia.scrollFactor.set();
		text_dia.setFormat("VCR OSD Mono", 64, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		text_dia.screenCenter();
		add(text_dia);

		dia_senpai = new StringLoader(LoadDir.assetsDir + "data/senpai/senpaiDialogue.txt");
		dia_senpai.loaded.add(loaded);
		dia_senpai.load();

		dia_senpai2 = new StringLoader(LoadDir.assetsDir + "data/roses/rosesDialogue.txt");
		dia_senpai2.loaded.add(loaded);
		dia_senpai2.load();

		dia_senpai3 = new StringLoader(LoadDir.assetsDir + "data/thorns/thornsDialogue.txt");
		dia_senpai3.loaded.add(loaded);
		dia_senpai3.load();

		LoadOffset();
	}

	var loaderBf_OffsetChar:StringLoader;
	var loaderBfcar_OffsetChar:StringLoader;
	var loaderBfchristmas_OffsetChar:StringLoader;
	var loaderBfpixel_OffsetChar:StringLoader;
	var loaderBfpixeldead_OffsetChar:StringLoader;

	var loaderDad_OffsetChar:StringLoader;

	var loaderGf_OffsetChar:StringLoader;
	var loaderGfcar_OffsetChar:StringLoader;
	var loaderGfchristmas_OffsetChar:StringLoader;
	var loaderGfpixel_OffsetChar:StringLoader;

	var loaderMom_OffsetChar:StringLoader;
	var loaderMomcar_OffsetChar:StringLoader;

	var loaderSenpai_OffsetChar:StringLoader;
	var loaderSenpaiangry_OffsetChar:StringLoader;
	var loaderSpirit_OffsetChar:StringLoader;

	var loaderMonster_OffsetChar:StringLoader;
	var loaderMonsterchristmas_OffsetChar:StringLoader;

	var parentsChristmas_OffsetsChar:StringLoader;

	var loaderPico_OffsetChar:StringLoader;

	var loaderSpooky_OffsetChar:StringLoader;

	function LoadOffset(){

		text_dia.visible = false;

		text_offset = new flixel.text.FlxText(0, 0, 0, 
		"Loading Offset Characters Game"
		+ "\nPlease wait");
		text_offset.scrollFactor.set();
		text_offset.setFormat("VCR OSD Mono", 64, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		text_offset.screenCenter();
		add(text_offset);

		loaderBf_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/bfOffsets.txt");
		loaderBf_OffsetChar.loaded.add(loaded);
		loaderBf_OffsetChar.load();

		loaderBfcar_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/bf-carOffsets.txt");
		loaderBfcar_OffsetChar.loaded.add(loaded);
		loaderBfcar_OffsetChar.load();

		loaderBfchristmas_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/bf-christmasOffsets.txt");
		loaderBfchristmas_OffsetChar.loaded.add(loaded);
		loaderBfchristmas_OffsetChar.load();

		loaderBfpixel_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/bf-pixelOffsets.txt");
		loaderBfpixel_OffsetChar.loaded.add(loaded);
		loaderBfpixel_OffsetChar.load();

		loaderBfpixeldead_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/bf-pixel-deadOffsets.txt");
		loaderBfpixeldead_OffsetChar.loaded.add(loaded);
		loaderBfpixeldead_OffsetChar.load();

		loaderDad_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/dadOffsets.txt");
		loaderDad_OffsetChar.loaded.add(loaded);
		loaderDad_OffsetChar.load();

		loaderGf_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/gfOffsets.txt");
		loaderGf_OffsetChar.loaded.add(loaded);
		loaderGf_OffsetChar.load();

		loaderGfcar_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/gf-carOffsets.txt");
		loaderGfcar_OffsetChar.loaded.add(loaded);
		loaderGfcar_OffsetChar.load();

		loaderGfchristmas_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/gf-christmasOffsets.txt");
		loaderGfchristmas_OffsetChar.loaded.add(loaded);
		loaderGfchristmas_OffsetChar.load();

		loaderGfpixel_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/gf-christmasOffsets.txt");
		loaderGfpixel_OffsetChar.loaded.add(loaded);
		loaderGfpixel_OffsetChar.load();

		loaderGfpixel_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/gf-pixelOffsets.txt");
		loaderGfpixel_OffsetChar.loaded.add(loaded);
		loaderGfpixel_OffsetChar.load();

		loaderGfpixel_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/gf-pixelOffsets.txt");
		loaderGfpixel_OffsetChar.loaded.add(loaded);
		loaderGfpixel_OffsetChar.load();

		loaderMom_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/momOffsets.txt");
		loaderMom_OffsetChar.loaded.add(loaded);
		loaderMom_OffsetChar.load();

		loaderMomcar_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/mom-carOffsets.txt");
		loaderMomcar_OffsetChar.loaded.add(loaded);
		loaderMomcar_OffsetChar.load();

		loaderSenpai_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/senpaiOffsets.txt");
		loaderSenpai_OffsetChar.loaded.add(loaded);
		loaderSenpai_OffsetChar.load();

		loaderSenpaiangry_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/senpai-angryOffsets.txt");
		loaderSenpaiangry_OffsetChar.loaded.add(loaded);
		loaderSenpaiangry_OffsetChar.load();

		loaderSpirit_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/spiritOffsets.txt");
		loaderSpirit_OffsetChar.loaded.add(loaded);
		loaderSpirit_OffsetChar.load();

		loaderMonster_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/monsterOffsets.txt");
		loaderMonster_OffsetChar.loaded.add(loaded);
		loaderMonster_OffsetChar.load();

		loaderMonsterchristmas_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/monster-christmasOffsets.txt");
		loaderMonsterchristmas_OffsetChar.loaded.add(loaded);
		loaderMonsterchristmas_OffsetChar.load();

		parentsChristmas_OffsetsChar = new StringLoader(LoadDir.assetsDir + "data/offset/parents-christmasOffsets.txt");
		parentsChristmas_OffsetsChar.loaded.add(loaded);
		parentsChristmas_OffsetsChar.load();

		loaderPico_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/picoOffsets.txt");
		loaderPico_OffsetChar.loaded.add(loaded);
		loaderPico_OffsetChar.load();

		loaderSpooky_OffsetChar = new StringLoader(LoadDir.assetsDir + "data/offset/spookyOffsets.txt");
		loaderSpooky_OffsetChar.loaded.add(loaded);
		loaderSpooky_OffsetChar.load();

		TxtLoad();
	}

	var leftkey:StringLoader;
	var downkey:StringLoader;
	var upkey:StringLoader;
	var rightkey:StringLoader;

	function TxtLoad(){
		leftkey = new StringLoader(LoadDir.keybindsDir + "left.txt");
		leftkey.loaded.add(loaded);
		leftkey.load();

		downkey = new StringLoader(LoadDir.keybindsDir + "down.txt");
		downkey.loaded.add(loaded);
		downkey.load();

		upkey = new StringLoader(LoadDir.keybindsDir + "up.txt");
		upkey.loaded.add(loaded);
		upkey.load();

		rightkey = new StringLoader(LoadDir.keybindsDir + "right.txt");
		rightkey.loaded.add(loaded);
		rightkey.load();

		MusicLoad();
	}

	function MusicLoad(){
		/*var bopeebo:StringLoader;

		bopeebo = new StringLoader(LoadDir.assetsDir + "songs/bopeebo/Inst.ogg");
		bopeebo.loaded.add(loaded);
		bopeebo.load();*/

		Week0jsonLoader();
	}
		/*MainImageLoader();
	}

	var mainmenuAssets:ImageLoader;
	var gfDanceTitle:ImageLoader;
	var alphabet:ImageLoader;
	var campaign_menu_UI:ImageLoader;

	public function MainImageLoader(){

		var queue = new LoaderQueue();
		queue.ignoreFailures = false;

		queue.add(new mloader.XmlLoader(LoadDir.assetsDir + "images/alphabet.xml"));
		queue.loaded.add(loaded);
		queue.load();
	}*/

	/*var xmlAlphabet:XmlLoader;

	function XMLLoad(){
		xmlAlphabet = new XmlLoader(LoadDir.assetsDir + "images/alphabet.xml");
		xmlAlphabet.loaded.add(loaded);
		xmlAlphabet.load();
	}*/

	var loadertutorial:JsonLoader<Dynamic>;

	function Week0jsonLoader(){

		text_offset.visible = false;

		text_data = new flixel.text.FlxText(0, 0, 0, "Loading Data Game, Please wait");
		text_data.scrollFactor.set();
		text_data.setFormat("VCR OSD Mono", 64, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		text_data.screenCenter();
		add(text_data);
		
		trace('load week 0');
		loadertutorial = new JsonLoader<Dynamic>(LoadDir.tutorialDir + "tutorial.json");
		loadertutorial.loaded.add(loaded);
		loadertutorial.load();

		Week1jsonLoader();
	}

	var loaderBopeebo:JsonLoader<Dynamic>;
	var loaderfresh:JsonLoader<Dynamic>;
	var loaderdadbattle:JsonLoader<Dynamic>;

	function Week1jsonLoader(){
		trace('load week 1');
		loaderBopeebo = new JsonLoader<Dynamic>(LoadDir.bopeeboDir + "bopeebo.json");
		loaderBopeebo.loaded.add(loaded);
		loaderBopeebo.load();

		loaderfresh = new JsonLoader<Dynamic>(LoadDir.freshDir + "fresh.json");
		loaderfresh.loaded.add(loaded);
		loaderfresh.load();

		loaderdadbattle = new JsonLoader<Dynamic>(LoadDir.dadbattleDir + "dadbattle.json");
		loaderdadbattle.loaded.add(loaded);
		loaderdadbattle.load();

		Week2jsonLoader();
	}

	var loaderspookeez:JsonLoader<Dynamic>;
	var loadersouth:JsonLoader<Dynamic>;
	var loadermonster:JsonLoader<Dynamic>;

	function Week2jsonLoader(){
		trace('load week 2');
		loaderspookeez = new JsonLoader<Dynamic>(LoadDir.spookeezDir + "spookeez.json");
		loaderspookeez.loaded.add(loaded);
		loaderspookeez.load();

		loadersouth = new JsonLoader<Dynamic>(LoadDir.southDir + "south.json");
		loadersouth.loaded.add(loaded);
		loadersouth.load();

		loadermonster = new JsonLoader<Dynamic>(LoadDir.monsterDir + "monster.json");
		loadermonster.loaded.add(loaded);
		loadermonster.load();

		Week3jsonLoader();
	}

	var loaderpico:JsonLoader<Dynamic>;
	var loaderphilly:JsonLoader<Dynamic>;
	var loaderblammed:JsonLoader<Dynamic>;

	function Week3jsonLoader(){
		trace('load week 3');
		loaderpico = new JsonLoader<Dynamic>(LoadDir.picoDir + "pico.json");
		loaderpico.loaded.add(loaded);
		loaderpico.load();

		loaderphilly = new JsonLoader<Dynamic>(LoadDir.phillyDir + "philly.json");
		loaderphilly.loaded.add(loaded);
		loaderphilly.load();

		loaderblammed = new JsonLoader<Dynamic>(LoadDir.blammedDir + "blammed.json");
		loaderblammed.loaded.add(loaded);
		loaderblammed.load();

		Week4jsonLoader();
	}

	var loadersatin_panties:JsonLoader<Dynamic>;
	var loaderhigh:JsonLoader<Dynamic>;
	var loadermilf:JsonLoader<Dynamic>;

	function Week4jsonLoader(){
		trace('load week 4');
		loadersatin_panties = new JsonLoader<Dynamic>(LoadDir.satin_pantiesDir + "satin-panties.json");
		loadersatin_panties.loaded.add(loaded);
		loadersatin_panties.load();

		loaderhigh = new JsonLoader<Dynamic>(LoadDir.highDir + "high.json");
		loaderhigh.loaded.add(loaded);
		loaderhigh.load();

		loadermilf = new JsonLoader<Dynamic>(LoadDir.milfDir + "milf.json");
		loadermilf.loaded.add(loaded);
		loadermilf.load();

		Week5jsonLoader();
	}

	var loadercocoa:JsonLoader<Dynamic>;
	var loadereggnog:JsonLoader<Dynamic>;
	var loaderwinter_horrorland:JsonLoader<Dynamic>;

	function Week5jsonLoader(){
		trace('load week 5');
		loadercocoa = new JsonLoader<Dynamic>(LoadDir.cocoaDir + "cocoa.json");
		loadercocoa.loaded.add(loaded);
		loadercocoa.load();

		loadereggnog = new JsonLoader<Dynamic>(LoadDir.eggnogDir + "eggnog.json");
		loadereggnog.loaded.add(loaded);
		loadereggnog.load();

		loaderwinter_horrorland = new JsonLoader<Dynamic>(LoadDir.winter_horrorlandDir + "winter-horrorland.json");
		loaderwinter_horrorland.loaded.add(loaded);
		loaderwinter_horrorland.load();

		Week6jsonLoader();
	}

	var loadersenpai:JsonLoader<Dynamic>;
	var loaderroses:JsonLoader<Dynamic>;
	var loaderthorns:JsonLoader<Dynamic>;

	function Week6jsonLoader(){
		trace('load week 6');
		loadersenpai = new JsonLoader<Dynamic>(LoadDir.senpaiDir + "senpai.json");
		loadersenpai.loaded.add(loaded);
		loadersenpai.load();

		loaderroses = new JsonLoader<Dynamic>(LoadDir.rosesDir + "roses.json");
		loaderroses.loaded.add(loaded);
		loaderroses.load();

		loaderthorns = new JsonLoader<Dynamic>(LoadDir.thornsDir + "thorns.json");
		loaderthorns.loaded.add(loaded);
		loaderthorns.load();

		// Week6jsonLoader();
	}

	/*static function Loadedxml(event:LoaderEvent<Xml>)
	{
		switch (event.xml)
		{
			case Complete:
				trace(event.target.content.firstElement());
				trace('done');
	
			case Fail(e):
				switch (e)
				{
					case Format(info): trace("Could not parse Xml: " + info);
					case IO(info): trace("URL could not be reached: " + info);
					default: trace(e);
					Sys.exit(0);
				}
		}
	}*/

	function loaded(event)
	{
		switch (event.type)
		{
			case Fail(error):
				trace(error);
				// trace('cant load game, exit now!');
				Sys.exit(0);

			case Complete:

				trace(event.target.content);

				text.visible = false;
				text_data.visible = false;

				textDone = new flixel.text.FlxText(0, 0, 0, "Done, open title state");
				textDone.scrollFactor.set();
				textDone.setFormat("VCR OSD Mono", 64, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				textDone.screenCenter();
				add(textDone);

				// trace(event.type + ":" + event.target.progress);

				// loader.url = Example.BASE_DIR + "not_a_real_url.txt";
				// loaderCharTxt.load();
				// loaderSongList.load();
				// loaderfpsText.load();
				// loaderIntroText.load();

				// loaderBf_xml.url = LoadDir.assetsDir + "shared/images/BOYFRIEND.xml";

				/*#if js
				js.Lib.document.body.appendChild(event.target.content);
				#elseif (flash || nme || openfl)
				var bitmap = new flash.display.Bitmap(event.target.content);
				flash.Lib.current.addChild(bitmap);
				#end*/

				trace('done');

				// Console.log('<b>Load Done, start game now!</>');

				FlxG.switchState(new TitleState());

			default:
				// trace(event.type);
		}
	}
}