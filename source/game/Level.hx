package game;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import openfl.Assets;

/**
 * ...
 * @author Benjamin Sinkula
 */
class Level extends FlxGroup
{
	public var player:Player;
	public var enemies:FlxTypedGroup<Enemy>;
	public var map:FlxTilemap;
	
	inline static public var T_W:Int = 16;
	inline static public var T_H:Int = 16;
	
	public function new(MapToUse:String) 
	{
		super();
		
		// Create tilemap
		map = new FlxTilemap();
		map.loadMap(Assets.getText(MapToUse), "assets/images/tileset.png", T_W, T_H, FlxTilemap.OFF, 0, 0, 1);
		
		// Create Player
		player = new Player(10, 10, this);
		
		// create enemies
		enemies = new FlxTypedGroup<Enemy>();
		enemies.add(new Enemy(50, 100, this));
		
		// Add objects to level
		add(map);
		add(enemies);
		add(player);
		
		// Initialize camera
		FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
		FlxG.camera.setBounds(map.x, map.y, map.width, map.height, true);
		
	}
	override public function destroy():Void
	{
		super.destroy();
	}
	override public function update():Void
	{
		
		if (!player.alive)
			FlxG.resetState();
			
		super.update();
		
		collide();
	}
	
	private function collide():Void
	{
		FlxG.collide(map, player);
		FlxG.collide(map, enemies);
		FlxG.overlap(enemies, player, enemyHitPlayer);
	}
	
	private function enemyHitPlayer(enemy:Enemy, player:Player):Void
	{
		// TODO: add functionality
	}
}