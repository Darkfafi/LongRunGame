package events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class HudEvent extends Event
	{
		public var info : int;
		public function HudEvent(strng : String, information : int, bub : Boolean) 
		{
			super(strng, bub);
			info = information;
		}
		
	}

}