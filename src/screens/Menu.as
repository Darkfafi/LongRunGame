package screens 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Menu extends Screen
	{
		public static const START_GAME : String = "startGameScreen";
		
		private var bg : MovieClip = new MenuBg();
		
		public function Menu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			addChild(bg);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.Z) {
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				//wegfade animation effect.
				dispatchEvent(new Event(START_GAME,true));
			}
		}
		
	}

}