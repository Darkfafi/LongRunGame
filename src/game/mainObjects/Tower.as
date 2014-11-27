package game.mainObjects 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import gameControl.GameObject;
	import gameControl.HudTextField;
	import placeholderAssets.PlayerAttackPlaceHolder;
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
		
		private var totalTiles : int = 6;
		
		private var tiles : Array = [];
		
		public var maxBricks : int;
		private var bricksPerStage : int;
		public var totalBricks : int;
		
		private var topTile : MovieClip;
		
		public function Tower(level : int) 
		{
			interActive = true;
			bricksPerStage = level * 5;
			setMaxBricks(bricksPerStage * totalTiles);
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
			}
			if (totalBricks >= maxBricks) {
				totalBricks = maxBricks;
				//play canon animation then after canon animation a white screen fading away and after that all monsters on screen are dying/dead and next level starts.
				collider = false;
				topTile.play();
				addEventListener(Event.ENTER_FRAME, checkDoneAnim);
			}
		}
		
		private function checkDoneAnim(e:Event):void 
		{
			if (topTile.currentFrame == topTile.totalFrames) {
				removeEventListener(Event.ENTER_FRAME, checkDoneAnim);
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
				parent.dispatchEvent(new Event(GAME_LOST));
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
					if(tiles.length < totalTiles){
						var tile : MovieClip;
						if (i == 0) {
							tile = new GroundTowerPieceArtL();
						}else if(tiles.length < totalTiles - 1) {
							tile = new TowerPieceOneArtL();
							tile.y = tiles[i - 1].y - tiles[i - 1].height;
						}else {
							tile = new TowerPieceTop();
							topTile = tile;
							topTile.stop();
							tile.y = tiles[i - 1].y - tiles[i - 1].height;
						}
						tile.scaleX = 1.5;
						tile.scaleY = 1.5;
						
						tiles.push(tile);
						addChild(tile);
					}
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