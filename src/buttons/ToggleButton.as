package buttons
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class ToggleButton extends Sprite
	{
		private var hitbox : Sprite = new Sprite();
		protected var buttonArt : MovieClip = new MovieClip();
		
		public function ToggleButton() 
		{
			addEventListener(MouseEvent.CLICK, toggleEvent);
			addEventListener(Event.ADDED_TO_STAGE,init)
		}
		
		protected function toggleEvent(e:MouseEvent):void 
		{
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			hitbox.graphics.beginFill(0x000000, 1);
			hitbox.graphics.drawRect(0, 0, 35, 40);
			hitbox.graphics.endFill();
			
			addChild(hitbox);
			drawButton();
		}
		
		private function drawButton():void 
		{
			addChild(buttonArt);
			buttonArt.gotoAndStop(1);
		}
	}

}