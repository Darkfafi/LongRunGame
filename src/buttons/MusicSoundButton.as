package buttons 
{
	import flash.events.MouseEvent;
	import soundTools.SoundManager;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class MusicSoundButton extends ToggleButton
	{
		public function MusicSoundButton() :void{
			buttonArt = new MusicMuteButton();
		}
		override protected function toggleEvent(e:MouseEvent):void 
		{
			if (SoundManager.toggleMuteMusic()) {
				buttonArt.gotoAndStop(2);
			}else {
				buttonArt.gotoAndStop(1);
			}
		}
		
	}

}