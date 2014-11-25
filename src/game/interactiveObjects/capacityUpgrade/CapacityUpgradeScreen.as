package game.interactiveObjects.capacityUpgrade 
{
	import game.interactiveObjects.UpgradeScreen;
	
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
		override protected function upgradePlayer():void 
		{
			super.upgradePlayer();
			target.brickCapacity += 5;
		}
		
	}

}