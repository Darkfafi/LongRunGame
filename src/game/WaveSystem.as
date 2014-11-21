package game 
{
	import events.HudEvent;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import game.monsters.Golem;
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
		
		public function WaveSystem(_world : DisplayObjectContainer) 
		{
			world = _world;
			_game = world as Game;
			
			world.addEventListener(Event.REMOVED_FROM_STAGE, objectRemoved,true);
		}
		
		public function setWave(waveInt : int):void 
		{
			_wave = waveInt - 1;
			
			startNextWave();
		}
		
		public function spawnWave() :void {
			
			var amount : int = 1 + (_wave * 0.2);
			if (amount > 5) {
				amount = 5;
			}
			spawnMonsters(amount);
		}
		private function objectRemoved(e:Event):void 
		{
			var enemiesLeft : int = _game.gameController.lisOfObjectType(Monster).length;
			
			if (enemiesLeft == 0) {
				startNextWave();
			}
		}
		
		private function startNextWave():void 
		{
			_wave ++;
			var hudEvent : HudEvent = new HudEvent(NEXT_WAVE, _wave, true);
			world.dispatchEvent(hudEvent);
			spawnWave();
		}
		private function spawnMonsters(amount:int):void 
		{
			for (var i : int = 0; i < amount; i++) {
				var pos : int = Math.floor(Math.random() * 2);
				var monster : Monster = new Golem(_wave, pos == 1 ? 1 : -1);
				
				world.addChild(monster);
				
				monster.x = (_game.backGround.x + (_game.backGround.width / 2 * -monster.dir)) + (monster.width * 2) * i;
				
				monster.y = 555;
			}
		}
		
		public function get wave():int 
		{
			return _wave;
		}
	}

}