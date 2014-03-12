package game;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

/**
 * ...
 * @author Benjamin Sinkula
 */
class Player extends FlxSprite
{
	private var levelRef:Level;
	private var speed:Float;
	
	static inline public var WIDTH:Int = 20;
	static inline public var HEIGHT:Int = 30;
	static inline public var JUMP_HEIGHT:Float = 175.0;
	static inline public var B_SPEED:Float = 50.0;
	
	public function new(X:Float, Y:Float, LevelRef:Level) 
	{
		super(X, Y);
		makeGraphic(WIDTH, HEIGHT, 0xffff0000);
		
		levelRef = LevelRef;
		speed = B_SPEED;
		
		maxVelocity.set(speed * 2.5, Reg.GRAVITY);
		
		acceleration.y = Reg.GRAVITY;
	}
	override public function update():Void
	{
		velocity.x = 0; // Stops if no keys pressed
		
		#if !FLX_NO_KEYBOARD
		// Input
		if (FlxG.keys.anyJustPressed(Reg.UP()))
			jump();
			
		if (FlxG.keys.anyPressed(Reg.LEFT()))
			velocity.x -= speed;
			
		if (FlxG.keys.anyPressed(Reg.RIGHT()))
			velocity.x += speed;
		#end
		
		// Call update after checking for jumps, to use touching flags from last update
		super.update();
		
		// Keep in level bounds
		if(x + width < levelRef.map.x)
			kill();
		else if ( x > levelRef.map.width)
			kill();
		if (y + height > levelRef.map.height)
			kill();
	}
	
	private function jump():Void
	{
		trace("in jump");
		
		if (isTouching(FlxObject.FLOOR))
		{
			velocity.y -= JUMP_HEIGHT;
			trace("JUMPED!");
		}
		
		trace("end jump");
	}
}