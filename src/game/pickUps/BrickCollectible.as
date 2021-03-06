package game.pickUps 
{
	import flash.display.Sprite;
	import gameControl.GameObject;
	import flash.utils.setInterval;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class BrickCollectible extends GameObject
	{
		private var destroyTime : int = 5000;
		
		private var art : Sprite = new Sprite();
		
		public function BrickCollectible() 
		{
			drawBrick();
		}
		
		private function drawBrick():void 
		{
			art = new BrickArt();
			addChild(art);
			
			//removes brick when it has been alive for to long.
			setInterval(removeObject, destroyTime);
		}
		
	}

}