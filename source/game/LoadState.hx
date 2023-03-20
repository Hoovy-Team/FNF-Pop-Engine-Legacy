package game;

import sys.FileSystem;
import flixel.FlxG;
import flixel.text.FlxText;

class LoadState extends MusicBeatState
{
    var txt:FlxText;

    override function create()
    {
        super.create();

        FileSystem.readDirectory("assets/");
        FlxG.sound.cacheAll();

        txt = new FlxText(0, 0, 0, "PLEASE WAIT\nLOADING STUFF", 32);
        txt.alignment = CENTER;
        txt.screenCenter();
        add(txt);
    }

	override function update(elapsed:Float)
    {
        super.update(elapsed);

        txt.text = "PLEASE WAIT\nLOADING STUFF";
        FlxG.switchState(new TitleState());
    }
}