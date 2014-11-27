package game.interactiveObjects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import game.mainObjects.Player;
	import gameControl.HudTextField;
	import soundTools.SoundManager;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class UpgradeScreen extends Sprite
	{
		//textFields
		protected var costText : HudTextField = new HudTextField("Payed/TotalCost",14);
		protected var effectText : HudTextField = new HudTextField("Current/Effect", 14);
		
		protected var timesUpgraded : int = 0;
		protected var storedBricks : int;
		protected var upgradeCost : int;
		protected var screenBgArt : Sprite = new Sprite();
		protected var target : Player;
		
		public function UpgradeScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(screenBgArt);
			placeText();
		}
		
		private function placeText():void 
		{
			costText.x += 2;
			costText.y = -85;
			effectText.x = costText.x;
			effectText.y = costText.y + 25;
			addChild(costText);
			addChild(effectText);
		}
		
		public function selectUpgradeTarget(player : Player) :void {
			target = player;
			upgradeCost = 10 + (timesUpgraded * 10);
			costText.changeText(storedBricks + " / " + upgradeCost);
		}
		public function buy() :void {
			//verwijdert gevraagd geld van speler en upgrade stats
			storedBricks += target.bricksCarrying;
			target.bricksCarrying = 0;
			
			if (storedBricks >= upgradeCost) {
				//buy sound
				storedBricks -= upgradeCost;
				upgradePlayer();
				timesUpgraded ++;
			}
			costText.changeText(storedBricks + " / " + upgradeCost);
		}
		
		protected function upgradePlayer():void 
		{
			SoundManager.playSound(SoundManager.UPGRADE_SOUND);
			//voor elk fornuis anders
			//bijv : target.attackDmg += 5;
		}
	}

}