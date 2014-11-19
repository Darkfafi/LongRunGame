package game.pickUps 
{
	import flash.display.Sprite;
	import gameControl.GameObject;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class BrickCollectible extends GameObject
	{
		private var art : Sprite = new Sprite();
		
		public function BrickCollectible() 
		{
			drawBrick();
		}
		
		private function drawBrick():void 
		{
			art.graphics.beginFill(0x773355, 1);
			art.graphics.drawRect(0, 0, 10, 5);
			art.graphics.endFill();
			addChild(art);
		}
		
	}

}