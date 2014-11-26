package game.interactiveObjects.capacityUpgrade 
{
	import game.interactiveObjects.UpgradeScreen;
	import game.mainObjects.Player;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class CapacityUpgradeScreen extends UpgradeScreen 
	{
		
		public function CapacityUpgradeScreen() 
		{
			super();
			
		}
		override public function selectUpgradeTarget(player:Player):void 
		{
			super.selectUpgradeTarget(player);
			effectText.changeText(player.brickCapacity + " +  5");
		}
		override protected function upgradePlayer():void 
		{
			super.upgradePlayer();
			target.brickCapacity += 5;
			effectText.changeText(target.brickCapacity + " +  5 <br> UPGRADED!");
		}
		
	}

}