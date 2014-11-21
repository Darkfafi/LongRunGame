package placeholderAssets.towerTiles 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class TowerPlaceHolderTile extends Sprite
	{
		
		public function TowerPlaceHolderTile() 
		{
			graphics.lineStyle(1, 0xff0000);
			graphics.beginFill(0x000000, 1);
			graphics.drawRect(0, -50, 109, 49);
			graphics.endFill();
		}
		
	}

}