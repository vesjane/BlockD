package 
{
	import flash.desktop.NativeApplication;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import starling.core.Starling;
	
	/**
	 * ...
	 * @author Garonna
	 */
	[SWF(width="720", height="1280", frameRate="60")]
	public class App extends Sprite
	{
		 private var _starling:Starling;
        
		public function App() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;			
			stage.addEventListener(Event.DEACTIVATE, deactivate);  
			
			init();
            
			
		}
		
		private function init():void {
            // Create a new instance and pass our class and the stage
            _starling = new Starling(Game, stage);
            
            // Show debug stats
            _starling.showStats = true;
            
            // Define level of antialiasing, 
            _starling.antiAliasing = 1;
            
            _starling.start();
        }
		
		 private function deactivate(e:Event):void {
 
            NativeApplication.nativeApplication.exit();
        }
		
		
	}

}