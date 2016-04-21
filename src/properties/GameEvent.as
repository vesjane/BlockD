package properties 
{
	import starling.events.Event;
	import starling.events.TouchEvent;
	/**
	 * ...
	 * @author Garonna
	 */
	public class GameEvent extends Event 
	{
		
		public static const GAME_OVER:String = "gameOver";
		public static const EXIT_GAME:String = "exitgame";
		
		 public function GameEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		 { 
            super(type, bubbles, cancelable);
		 } 
                
       
		
	}

}