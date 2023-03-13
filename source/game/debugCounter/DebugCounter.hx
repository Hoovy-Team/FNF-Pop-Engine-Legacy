package game.debugCounter;

import flixel.math.FlxMath;
import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.Memory;
import flixel.system.FlxAssets;

/**
 * Debug Text class extension to display debug text when build with debug mode
 */
class DebugCounter extends TextField
{
	public function new(inX:Float = 10.0, inY:Float = 10.0, inCol:Int = 0x000000)
	{
		super();

		x = inX;
		y = inY;
		selectable = false;
		defaultTextFormat = new TextFormat(FlxAssets.FONT_DEFAULT, 13, inCol);
		// defaultTextFormat = new TextFormat("_sans", 14, inCol);
		width = 1280;
		height = 720;
	}

	private function onEnter(_)
	{
		if (visible)
		{
			text = "\n\n\n\n!DEBUG MODE!";
		}
	}
}