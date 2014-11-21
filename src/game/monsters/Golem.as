package game.monsters 
{
	import placeholderAssets.PlayerAttackPlaceHolder;
	import placeholderAssets.PlayerIdlePlaceHolder;
	import placeholderAssets.PlayerMovePlaceHolder;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Golem extends Monster 
	{
		
		public function Golem(wave : int, direction:int) 
		{
			super(wave, direction);
			
			//animations of Golem
			preAnim = [new PlayerIdlePlaceHolder, new PlayerAttackPlaceHolder, new PlayerMovePlaceHolder];
		}
		override protected function setStats(wave : int):void 
		{
			//stats of Golem
			health = 35;
			attackDmg = 5;
			_speed = 0.5;
			
			super.setStats(wave);
		}
	}

}