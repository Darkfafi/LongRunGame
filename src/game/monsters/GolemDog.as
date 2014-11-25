package game.monsters 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GolemDog extends Monster 
	{
		
		public function GolemDog(wave:int, direction:int) 
		{
			preAnim = [new GolemDogMovementAnim, new GolemDogAttack, new GolemDogDeathAnim];
			
			super(wave, direction);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			hitBox.width = hitBox.width / 2;
		}	
		
		override protected function setStats(wave : int):void 
		{
			//stats of Golem
			health = 50;
			attackDmg = 2;
			_speed = 2.5;
			
			super.setStats(wave);
		}
	}

}