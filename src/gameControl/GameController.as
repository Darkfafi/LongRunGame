package gameControl 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import game.BackGround;
	import game.mainObjects.Player;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GameController 
	{
		private var collisionSystem : CollisionSystem = new CollisionSystem();
		
		private var camera : Rectangle;
		private var player : Player;
		public var background : BackGround;
		
		private var _world : DisplayObjectContainer;
		private var gameObjects : Array = [];
		
		public function GameController(world : DisplayObjectContainer) 
		{
			_world = world;
			_world.addEventListener(GameObject.ADDED, objectAdded);
			_world.addEventListener(GameObject.REMOVED, objectRemoved);
		}
		
		private function objectRemoved(e:Event):void 
		{
			var object : GameObject = e.target as GameObject;
			var index : int = gameObjects.indexOf(object);
			gameObjects.splice(index, 1);
		}
		
		private function objectAdded(e:Event):void 
		{
			
			var object : GameObject = e.target as GameObject;
			gameObjects.push(object);
			
			if (e.target is BackGround) {
				background = e.target  as BackGround;
			}
			if (e.target is Player) {
				player = e.target as Player;
			}
		}
		public function lisOfObjectType(object : Class) :Array {
			var list : Array = [];
			for (var i : int =  gameObjects.length - 1; i >= 0; i--) {
				if (gameObjects[i] is object) {
					list.push(gameObjects[i]);
				}
			}
			return list;
		}
		public function update() :void {
			collisionSystem.checkCollision(gameObjects,_world, player, background);
			cameraMovement();
			var l : int = gameObjects.length;
			for (var i : int = l - 1; i >= 0; i--) {
				if (gameObjects[i] is MovingGameObject) {
					var object : MovingGameObject = gameObjects[i] as MovingGameObject;
					object.update();
				}
			}
		}
		private function cameraMovement():void 
		{
			var check : Rectangle = new Rectangle(player.x - _world.stage.stageWidth / 2,0,_world.stage.stageWidth, _world.stage.stageHeight);
			if (check.x > 0 - background.width / 6 && check.x < background.width / 4) {
				camera = check;
				_world.root.scrollRect = camera;
			}
		}
		
		public function getAllObjects() :Array {
			return gameObjects;
		}
		
		public function destroy() :void {
			for (var i : int = gameObjects.length - 1; i >= 0; i--) {
				gameObjects[i].removeObject();
			}
			_world.removeEventListener(GameObject.ADDED, objectAdded);
			_world.removeEventListener(GameObject.REMOVED, objectRemoved);
		}
	}
}