package game.monsters 
{
	import flash.display.Sprite;
	import gameControl.HudTextField;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class HpBar extends Sprite 
	{
		private var hpText : HudTextField = new HudTextField("hp/maxHp", 10);
		private var _maxHp : Number;
		private var backBar : Sprite = new Sprite();
		private var barArt : Sprite = new Sprite();
		
		public function HpBar(hp : Number) 
		{
			_maxHp = hp;
			
			backBar.graphics.beginFill(0xFF2222,0.7);
			backBar.graphics.drawRect(0, 0, 80, 10);
			backBar.graphics.endFill();
			
			barArt.graphics.beginFill(0x00FF00);
			barArt.graphics.drawRect(0, 0, 80, 10);
			barArt.graphics.endFill();
			
			hpText.x += barArt.width / 3;
			hpText.width = barArt.width - barArt.width / 3;
			hpText.y -= 4;
			scaleBar(_maxHp);
			
			addChild(backBar);
			addChild(barArt);
			
			addChild(hpText);
			this.x -= this.width / 2;
		}
		
		public function scaleBar(newHp : Number) :void {
			barArt.scaleX = (newHp / _maxHp);
			hpText.changeText(newHp + " / " + _maxHp);
		}
		
		public function get maxHp():Number 
		{
			return _maxHp;
		}
		
	}

}