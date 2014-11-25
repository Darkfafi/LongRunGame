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
			screenBgArt.graphics.beginFill(0x696969, 1);
			screenBgArt.graphics.drawRect( -55, -120, 110, 120);
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
				//buy sound
				trace("upgrade bought");
				storedBricks -= upgradeCost;
				upgradePlayer();
				timesUpgraded ++;
			}
		}
		
		protected function upgradePlayer():void 
		{
			//voor elk fornuis anders
			//bijv : target.attackDmg += 5;
		}
	}

}