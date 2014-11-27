package game.mainObjects 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Explosion extends Sprite 
	{
		private var art : MovieClip = new ExplosionArt();
		public function Explosion() 
		{
			addEventListener(Event.ENTER_FRAME, checkDone);
			addChild(art);
		}
		
		private function checkDone(e:Event):void 
		{
			if (art.currentFrame == art.totalFrames) {
				removeEventListener(Event.ENTER_FRAME, checkDone);
				stage.removeChild(this);
			}
		}
	}
}