package game.mainObjects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import gameControl.GameObject;
	import gameControl.HudTextField;
	import placeholderAssets.towerTiles.GroundTowerPlaceHolder;
	import placeholderAssets.towerTiles.TowerPlaceHolderTile;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Tower extends GameObject 
	{
		public static const GAME_WON : String = "gameWon";
		public static const GAME_LOST : String = "gameLost";
		
		private var tiles : Array = [];
		public var maxBricks : int;
		private var bricksPerStage : int;
		public var totalBricks : int;
		
		public function Tower(level : int) 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			interActive = true;
			bricksPerStage = level * 5;
			setMaxBricks(bricksPerStage * 10);
			buildTower();
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		
		}
		
		private function buildTower():void {
			totalBricks = bricksPerStage;
			drawTower();
		}
		public function setMaxBricks(_bricks : int) :void {
			maxBricks = _bricks;
		}
		
		public function addBricks(amount : int) :void {
			
			for (var i : int = 0; i < amount; i++) {
				totalBricks += 1;
				if (totalBricks % bricksPerStage == 0) {
					addLayer();
				}
				//voeg houd of steentjes op tower
			}
			if (totalBricks >= maxBricks) {
				totalBricks = maxBricks;
				parent.dispatchEvent(new Event(GAME_WON));
			}
		}
		private function addLayer():void {
			drawTower();
		}
		public function damageTower(dmg : int) :void {
			totalBricks -= dmg;
			if (totalBricks <= 0) {
				totalBricks = 0
				trace("GAME LOST");
			}
			//break sound
			drawTower();
		}
		private function drawTower() :void {
			var tilesToDraw : int;
			if(totalBricks >= bricksPerStage){
				tilesToDraw = totalBricks / bricksPerStage;
			}else if(totalBricks > 0){
				tilesToDraw = 1; 
			}
			var l : int = tiles.length;
			if(tilesToDraw <= l){
				for (var i : int = l - 1; i >= tilesToDraw; i--) {
					removeChild(tiles[i]);
					tiles.splice(i, 1);
				}
			}else{
				for (i = l; i < tilesToDraw; i++) {
					var tile : Sprite;
					if (i == 0) {
						tile = new GroundTowerPlaceHolder();
					}else {
						tile = new TowerPlaceHolderTile();
					}
					tiles.push(tile);
					tile.y = i * -tile.height;
					addChild(tile);
				}
			}
		}
		override public function onInteraction(InteractingObject : GameObject):void 
		{
			super.onInteraction(InteractingObject);
			if (InteractingObject is Player) {
				var player : Player = InteractingObject as Player;
				player.buildUpTower();
				addBricks(player.bricksCarrying);
				player.bricksCarrying = 0;
			}
		}
	}

}