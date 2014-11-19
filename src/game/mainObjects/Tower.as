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
			interActive = true;
			bricksPerStage = level * 10;
			setMaxBricks(bricksPerStage * 10);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			buildTower();
		}
		
		private function buildTower():void {
			totalBricks = 40;
			drawTower();
		}
		
		public function setMaxBricks(_bricks : int) :void {
			maxBricks = _bricks;
		}
		
		public function addBricks(amount : int) :void {
			trace(amount);
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
		public function damageTower(dmg : int) :void {
			totalBricks -= dmg;
			//break sound
			drawTower();
		}
		private function drawTower() :void {
			var tilesToDraw : int = totalBricks / bricksPerStage;
			var l : int = tiles.length;
			trace(tilesToDraw +" "+ l);
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
				addBricks(player.bricksCarrying);
			}
		}
	}

}