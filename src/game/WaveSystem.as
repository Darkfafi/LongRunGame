package game 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import game.monsters.Golem;
	import game.monsters.Monster;
	import gameControl.GameController;
	import screens.Game;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class WaveSystem 
	{
		private var _game : Game;
		private var world : DisplayObjectContainer;
		private var wave : int;
		
		public function WaveSystem(_world : DisplayObjectContainer) 
		{
			world = _world;
			_game = _world as Game;
			
			world.addEventListener(Event.REMOVED_FROM_STAGE, objectRemoved,true);
			setWave(1);
		}
		
		public function setWave(waveInt : int):void 
		{
			wave = waveInt;
		}
		
		public function spawnWave() :void {
			
			var amount : int = 1 + (wave * 0.5)
			
			spawnMonsters(amount);
		}
		private function objectRemoved(e:Event):void 
		{
			var enemiesLeft : int = _game.gameController.lisOfObjectType(Monster).length;
			trace(enemiesLeft);
			if (enemiesLeft == 0) {
				startNextWave();
			}
		}
		
		private function startNextWave():void 
		{
			wave ++;
			spawnWave();
		}
		private function spawnMonsters(amount:int):void 
		{
			for (var i : int = 0; i < amount; i++) {
				var pos : int = Math.floor(Math.random() * 2);
				var monster : Monster = new Golem(wave, pos == 1 ? 1 : -1);
				
				world.addChild(monster);
				monster.x = ((pos == 1 ? 0 : 1) * 1200) + monster.width * i;
				monster.y = 555;
			}
		}
	}

}