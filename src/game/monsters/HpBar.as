package game.monsters 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class HpBar extends Sprite 
	{
		private var _maxHp : Number;
		private var barArt : Sprite = new Sprite();
		
		public function HpBar(hp : Number) 
		{
			_maxHp = hp;
			barArt.graphics.beginFill(0x00FF00);
			barArt.graphics.drawRect(0, 0, 80, 10);
			barArt.graphics.endFill();
			addChild(barArt);
		}
		
		public function scaleBar(newHp : Number) :void {
			barArt.scaleX = (newHp / _maxHp);
		}
		
		public function get maxHp():Number 
		{
			return _maxHp;
		}
		
	}

}