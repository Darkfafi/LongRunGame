package screens 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import soundTools.SoundManager;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Menu extends Screen
	{
		public static const START_GAME : String = "startGameScreen";
		
		private var bg : MovieClip = new MenuBg();
		private var instructions : Sprite = new InstructionsArt();
		
		public function Menu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			addChild(bg);
			addChild(instructions);
			instructions.alpha = 0.8;
			instructions.visible = false;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			SoundManager.playMusic(SoundManager.MENU_MUSIC);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.Z) {
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				//wegfade animation effect.
				dispatchEvent(new Event(START_GAME,true));
			}else if (e.keyCode == Keyboard.X) {
				if (instructions.visible) {
					instructions.visible = false;
				}else {
					instructions.visible = true;
				}
			}
		}
		
	}

}