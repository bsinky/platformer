package game;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxRandom;
/**
 * ...
 * @author Benjamin Sinkula
 */
class Enemy extends FlxSprite
{
	private var speed:Float;
	private var levelRef:Level;
	private var player:Player;
	
	static inline public var WIDTH:Int = 20;
	static inline public var HEIGHT:Int = 20;
	static inline public var B_SPEED:Float = 35;
	static inline public var JUMP_HEIGHT:Float = 150;
	
	public function new(X:Float, Y:Float, LevelRef:Level) 
	{
		super(X, Y);
		makeGraphic(WIDTH, HEIGHT, 0xff000000);
		
		this.levelRef = LevelRef;
		this.player = levelRef.player;
		
		speed = B_SPEED;
		
		maxVelocity.set(speed * 1.5, Reg.GRAVITY * 2);
		
		acceleration.y = Reg.GRAVITY;
	}
	override public function update():Void
	{
		// Move toward player
		velocity.x = player.x + player.width / 2 - x + width / 2;
			
		if (player.y + player.height < y + height)
			jump();
		
		super.update();
	}
	
	private function jump():Void
	{
		if (isTouching(FlxObject.FLOOR))
			velocity.y = -JUMP_HEIGHT;
	}
}