package game.interactiveObjects 
{
	import flash.display.Sprite;
	import game.mainObjects.Player;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class UpgradeScreen extends Sprite
	{
		protected var timesUpgraded : int = 0;
		protected var storedBricks : int;
		protected var upgradeCost : int;
		protected var screenBgArt : Sprite = new Sprite();
		protected var target : Player;
		
		public function UpgradeScreen() 
		{
			//menu with buttons and icons for upgrading etc etc. Here it will efect the player his stats
			screenBgArt.graphics.beginFill(0x696969, 1);
			screenBgArt.graphics.drawRect( -40, -50, 80, 50);
			screenBgArt.graphics.endFill();
			addChild(screenBgArt);
		}
		
		public function selectUpgradeTarget(player : Player) :void {
			target = player;
			upgradeCost = 10 + (timesUpgraded * 10);
		}
		public function buy() :void {
			//verwijdert gevraagd geld van speler en upgrade stats
			storedBricks += target.bricksCarrying;
			target.bricksCarrying = 0;
			
			if (storedBricks >= upgradeCost) {
				storedBricks -= upgradeCost;
				timesUpgraded ++;
				trace("bought Upgrade!");
			}
		}
	}

}