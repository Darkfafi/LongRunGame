package game.interactiveObjects.capacityUpgrade 
{
	import game.interactiveObjects.UpgradeObject;
	import placeholderAssets.PlayerAttackPlaceHolder;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class CapacityUpgradeObject extends UpgradeObject 
	{
		
		public function CapacityUpgradeObject() 
		{
			art = new CapFornuisArt();
			super();
		}
		
		override protected function selectUpgradeScreen():void 
		{
			upgradeScreen = new CapacityUpgradeScreen();
			super.selectUpgradeScreen();
		}
		
	}

}