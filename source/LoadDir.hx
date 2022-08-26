package;

class LoadDir
{
	static public var assetsDir:String = "assets/";

	static public var sharedDir:String = "assets/shared/images/";

	// static public var week6Dir:String = "assets/week6/images/";

	// static public var bfxml:String = "assets/shared/images/BOYFRIEND.xml";

	static public var keybindsDir:String = "assets/data/options/keybinds/";

	static public var tutorialDir:String = "assets/data/tutorial/";
	//Week 1 dir
	static public var bopeeboDir:String = "assets/data/bopeebo/";
	static public var freshDir:String = "assets/data/fresh/";
	static public var dadbattleDir:String = "assets/data/dadbattle/";
	//Week 2 dir
	static public var spookeezDir:String = "assets/data/spookeez/";
	static public var southDir:String = "assets/data/south/";
	static public var monsterDir:String = "assets/data/monster/";
	//Week 3 dir
	static public var picoDir:String = "assets/data/pico/";
	static public var phillyDir:String = "assets/data/philly/";
	static public var blammedDir:String = "assets/data/blammed/";
	//Week 4 dir
	static public var satin_pantiesDir:String = "assets/data/satin-panties/";
	static public var highDir:String = "assets/data/high/";
	static public var milfDir:String = "assets/data/milf/";
	//Week 5 dir
	static public var cocoaDir:String = "assets/data/cocoa/";
	static public var eggnogDir:String = "assets/data/eggnog/";
	static public var winter_horrorlandDir:String = "assets/data/winter-horrorland/";
	//Week 6 dir
	static public var senpaiDir:String = "assets/data/senpai/";
	static public var rosesDir:String = "assets/data/roses/";
	static public var thornsDir:String = "assets/data/thorns/";

	public static function main() { new LoadDir(); }

	public function new()
	{
		// Console.start();
		new LoaderState();
	}
}
