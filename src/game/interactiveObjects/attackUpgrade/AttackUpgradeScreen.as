package game.interactiveObjects.attackUpgrade 
{
	import game.interactiveObjects.UpgradeScreen;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class AttackUpgradeScreen extends UpgradeScreen 
	{
		
		public function AttackUpgradeScreen() 
		{
			super();
			
		}
		override protected function upgradePlayer():void 
		{
			super.upgradePlayer();
			target.attackDmg += 5;
			trace(target.attackDmg);
		}
		
	}

}