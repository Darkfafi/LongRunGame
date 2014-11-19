package game 
{
	import flash.display.Sprite;
	import gameControl.GameObject;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class BackGround extends GameObject
	{
		
		public function BackGround() 
		{
			collider = false;
			
			graphics.beginFill(0x00FFFF, 1);
			graphics.drawRect(-600, 0, 1200, 600);
			graphics.endFill();
			graphics.beginFill(0xff0000, 1);
			graphics.drawRect(-400, 500, 20, 100);
			graphics.drawRect(400, 500, 20, 100);
			graphics.endFill();
		}
		
	}

}