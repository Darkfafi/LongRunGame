package game.monsters 
{
	import flash.events.Event;
	import placeholderAssets.MonsterWalkingPlaceHolder;
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
			preAnim = [new GolemWalkAnim, new GolemAttackAnim, new PlayerMovePlaceHolder];
			
			super(wave, direction);
			
			//animations of Golem
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			hitBox.width = hitBox.width / 4;
		}
		override protected function setStats(wave : int):void 
		{
			//stats of Golem
			health = 150;
			attackDmg = 5;
			_speed = 0.7;
			
			super.setStats(wave);
		}
	}

}