package gameControl 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import game.mainObjects.Player;
	import placeholderAssets.BackGround;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GameController 
	{
		private var collisionSystem : CollisionSystem = new CollisionSystem();
		
		private var camera : Rectangle;
		private var player : Player;
		private var background : BackGround;
		
		private var _world : DisplayObjectContainer;
		private var gameObjects : Array = [];
		
		public function GameController(world : DisplayObjectContainer) 
		{
			_world = world;
			_world.addEventListener(Event.ADDED_TO_STAGE, objectAdded, true);
			_world.addEventListener(Event.REMOVED_FROM_STAGE, objectRemoved, true);
		}
		
		private function objectRemoved(e:Event):void 
		{
			if (e.target is GameObject) {
				var object : GameObject = e.target as GameObject;
				var index : int = gameObjects.indexOf(object);
				gameObjects.splice(index, 1);
			}
		}
		
		private function objectAdded(e:Event):void 
		{
			if (e.target is GameObject) {
				var object : GameObject = e.target as GameObject;
				gameObjects.push(object);
			}
			if (e.target is BackGround) {
				background = e.target  as BackGround;
			}
			if (e.target is Player) {
				player = e.target as Player;
			}
		}
		
		public function update() :void {
			collisionSystem.checkCollision(gameObjects,_world, player, background);
			cameraMovement();
			var l : int = gameObjects.length;
			for (var i : int = l - 1; i >= 0; i--) {
				if (gameObjects[i] is MovingGameObject) {
					gameObjects[i].update();
				}
			}
		}
		
		private function cameraMovement():void 
		{
			var check : Rectangle = new Rectangle(player.x - _world.stage.stageWidth / 2,0,_world.stage.stageWidth, _world.stage.stageHeight);
			if (check.x > 0 - background.width / 6 && check.x < background.width / 6) {
				camera = check;
				_world.root.scrollRect = camera;
			}
		}
	}
}