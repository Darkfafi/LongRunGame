package game 
{
	import events.HudEvent;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import game.mainObjects.Tower;
	import game.monsters.Golem;
	import game.monsters.GolemDog;
	import game.monsters.Monster;
	import gameControl.GameController;
	import screens.Game;
	import flash.utils.setInterval;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class WaveSystem 
	{
		public static const NEXT_WAVE : String = "nextWave";
		private var _game : Game;
		private var world : DisplayObjectContainer;
		private var _wave : int;
		private var canSpawn : Boolean = true;
		
		public function WaveSystem(_world : DisplayObjectContainer) 
		{
			world = _world;
			_game = world as Game;
			
			world.addEventListener(Event.REMOVED_FROM_STAGE, objectRemoved, true);
		}
		
		public function dontSpawn():void 
		{
			canSpawn = false;
		}
		
		public function setWave(waveInt : int):void 
		{
			_wave = waveInt - 1;
			
			startNextWave();
			
			if (!canSpawn) {
				canSpawn = true;
			}
		}
		
		public function spawnWave() :void {
			
			var amount : int = 1 + (_wave * (_game.level * 1));
			if (amount > 15) {
				amount = 15;
			}
			spawnMonsters(amount);
		}
		private function objectRemoved(e:Event):void 
		{
			var enemiesLeft : int = _game.gameController.lisOfObjectType(Monster).length;
			if(e.target is Monster){
				//trace(enemiesLeft);
				if (canSpawn && enemiesLeft == 0) {
					startNextWave();
				}
			}
		}
		
		private function startNextWave():void 
		{
			_wave ++;
			var hudEvent : HudEvent = new HudEvent(NEXT_WAVE, _wave, true);
			world.dispatchEvent(hudEvent);
			spawnWave();
			//if wave == 666 hen spawn boss
		}
		private function spawnMonsters(amount:int):void 
		{
			var monster : Monster;
			if (_wave % 5 == 0) {
				amount /= 2;
			}
			
			for (var i : int = 0; i < amount; i++) {
				var pos : int = Math.floor(Math.random() * 2);
				if(_wave%5 == 0){
					monster = new GolemDog(_wave, pos == 1 ? 1 : -1);
				}else {
					monster = new Golem(_wave, pos == 1 ? 1 : -1);
				}
				world.addChildAt(monster,4);
				
				monster.x = _game.backGround.x + ((_game.backGround.width / 2 + monster.width / 3) + (monster.width/2) * i) * -monster.dir;
				monster.y = 570;
			}
		}
		
		public function get wave():int 
		{
			return _wave;
		}
	}

}