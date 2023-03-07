package;


import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxEase;
import openfl.filters.ShaderFilter;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import lime.app.Application;
import flixel.FlxSprite;
import llua.Convert;
import llua.Lua;
import llua.State;
import llua.LuaL;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;

import Song.SwagSong;
// Almost code here from kade engine
class LuaCode
{
    var SONG:Song;
    public static var lua:State = LuaL.newstate();

    public function new()
    {
        // super();
        LuaL.openlibs(lua);
        Lua.init_callbacks(lua);

        LuaL.dofile(lua, Paths.lua(SONG.song.toLowerCase() + "/lua"));
        trace('lua file is run');

        setLua();
    }

    // from kade engine
    function changeDadCharacter(id:String)
	{				
        var olddadx = PlayState.dad.x;
        var olddady = PlayState.dad.y;
        PlayState.instance.removeObject(PlayState.dad);
        PlayState.dad = new Character(olddadx, olddady, id);
        PlayState.instance.addObject(PlayState.dad);
        PlayState.instance.iconP2.animation.play(id);
	}

    // from kade engine
	function changeBoyfriendCharacter(id:String)
	{				
        var oldboyfriendx = PlayState.boyfriend.x;
        var oldboyfriendy = PlayState.boyfriend.y;
        PlayState.instance.removeObject(PlayState.boyfriend);
        PlayState.boyfriend = new Boyfriend(oldboyfriendx, oldboyfriendy, id);
        PlayState.instance.addObject(PlayState.boyfriend);
        PlayState.instance.iconP2.animation.play(id);
	}

    // from kade engine
    public function setVar(var_name:String, object:Dynamic)
    {
		Lua.pushnumber(lua, object);
		Lua.setglobal(lua, var_name);
	}

    function setLua()
    {
        setVar('curBeat', 0);
        setVar('curStep', 0);
        setVar('score', 0);
        setVar('misses', 0);

        helperLua();
    }

    function helperLua()
    {
        Lua_helper.add_callback(lua, "changeDadCharacter", changeDadCharacter);
        Lua_helper.add_callback(lua, "changeBoyfriendCharacter", changeBoyfriendCharacter);
    }

    // from kade engine
    public static function callLua(func_name: String, args: Array<Dynamic>, ?type: String):Dynamic
	{
		var result: Any = null;

		Lua.getglobal(lua, func_name);

		for (arg in args){
		    Convert.toLua(lua, arg);
		}

		result = Lua.pcall(lua, args.length, 1, 0);
		var p = Lua.tostring(lua, result);

		if(result == null) {
			return null;
		}else{
			return convert(result, type);
		}
	}

	public static function convert(v : Any, type : String) : Dynamic { // I didn't write this lol
		if( Std.is(v, String) && type != null ) {
		var v : String = v;
		if( type.substr(0, 4) == 'array' ) {
			if( type.substr(4) == 'float' ) {
			var array : Array<String> = v.split(',');
			var array2 : Array<Float> = new Array();

			for( vars in array ) {
				array2.push(Std.parseFloat(vars));
			}

			return array2;
			} else if( type.substr(4) == 'int' ) {
			var array : Array<String> = v.split(',');
			var array2 : Array<Int> = new Array();

			for( vars in array ) {
				array2.push(Std.parseInt(vars));
			}

			return array2;
			} else {
			var array : Array<String> = v.split(',');
			return array;
			}
		} else if( type == 'float' ) {
			return Std.parseFloat(v);
		} else if( type == 'int' ) {
			return Std.parseInt(v);
		} else if( type == 'bool' ) {
			if( v == 'true' ) {
			return true;
			} else {
			return false;
			}
		} else {
			return v;
		}
		} else {
		return v;
		}
	}

    public static function runLuaCode():LuaCode
    {
        return new LuaCode();
    }
}