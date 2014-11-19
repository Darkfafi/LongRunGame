package game.mainObjects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import gameControl.GameObject;
	import placeholderAssets.towerTiles.GroundTowerPlaceHolder;
	import placeholderAssets.towerTiles.TowerPlaceHolderTile;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Tower extends GameObject 
	{
		
		private var tiles : Array = [];
		private var maxBricks : int;
		private var bricksPerStage : int;
		private var totalBricks : int;
		
		public function Tower(level : int) 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			bricksPerStage = level * 10;
			setMaxBricks(bricksPerStage * 10);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			buildTower();
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
				trace("GAME WON! END GAME");
			}
		}
		private function addLayer():void {
			drawTower();
		}
		private function damageTower(dmg : int) :void {
			totalBricks -= dmg;
			drawTower();
		}
		private function drawTower() :void {
			for (var i : int = 0; i < tiles.length; i++) {
				removeChild(tiles[i]);
				tiles.splice(i, 1);
			}
			var tilesToDraw : int = totalBricks / bricksPerStage;
			
			for (i = 0; i < tilesToDraw; i++) {
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

}