package 
{
	import flash.desktop.NativeApplication;
    import flash.display.Sprite;
	import flash.display.Stage;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
	import flash.geom.Rectangle;
    import starling.core.Starling;
	
	/**
	 * ...
	 * @author Garonna
	 */
	
	public class App extends Sprite
	{
		// Растягивает картинку без учёта соотношения сторон, заполняя весь экран
		public static const STRATCH:String = "ScaleMode.Stratch";
		// Сохраняет пропорции и центрирует картинку, оставляет полоски
		public static const LETTERBOX:String = "ScaleMode.LetterBox";
		// Сохраняет пропорции и увеличивает картинку пока она влезает в экран, оставляет полоски
		public static const ZOOM:String = "ScaleMode.Zoom";
		// Подстраивает размер картинки под размер экрана, "резиновый" дизайн
		public static const SMART:String = "ScaleMode.Smart";

		private var _starling:Starling;
		
		public static const WIDTH:int = 480;
		public static const HEIGHT:int = 800;
        
		public function App() 
		{
			init();
			Starling.current.viewPort = new Rectangle(0, 0, WIDTH, HEIGHT);
			stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;			
			stage.addEventListener(Event.DEACTIVATE, deactivate);  
			stage.addEventListener(flash.events.Event.RESIZE, resize);
			
			
            
			
		}
		
	public function resize(event:Event):void
    {
		this.stage.removeEventListener(flash.events.Event.RESIZE, resize);		
		setScaleMode(SMART, WIDTH, HEIGHT);	
			
		
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
		
		public function setScaleMode(value:String, width:int = 640, height:int = 1136):void {
        if (value != STRATCH && value != LETTERBOX && value != ZOOM && value != SMART) {
                if (value != "") {
                        trace("Scale mode '" + value + "' not found.");
                }
                return;
        }
        
        var starling:Starling = Starling.current;
        if (starling == null || !starling.isStarted)
        {
                return;
        }
        
        var stage:Stage = starling.nativeStage;
        
        switch(value) {
                case STRATCH:
                        starling.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
                        break;
                case LETTERBOX:
                        var k:Number = Math.min(int(stage.stageWidth / width), int(stage.stageHeight / height));
                        var w:int = width * k;
                        var h:int = height * k;
                        var x:int = (stage.stageWidth - w) * 0.5;
                        var y:int = (stage.stageHeight - h) * 0.5;
                        starling.viewPort = new Rectangle(x, y, w, h);
                        break;
                case ZOOM:
                        k = Math.min(stage.stageWidth / width, stage.stageHeight / height);
                        w = width * k;
                        h = height * k;
                        x = (stage.stageWidth - w) * 0.5;
                        y = (stage.stageHeight - h) * 0.5;
                        starling.viewPort = new Rectangle(x, y, w, h);
                        break;
                case SMART:
                        if (stage.stageWidth / width > stage.stageHeight / height) {
                                var s:Number = stage.stageWidth / width;
                                k = stage.stageWidth / stage.stageHeight;
                                starling.stage.stageWidth = stage.stageHeight * k / s;
                                starling.stage.stageHeight = stage.stageHeight / s;
                        } else {
                                s = stage.stageHeight / height;
                                k = stage.stageHeight / stage.stageWidth;
                                starling.stage.stageWidth = stage.stageWidth / s;
                                starling.stage.stageHeight = stage.stageWidth * k / s;
                        }
						trace(stage.stageWidth, stage.stageHeight);
                        starling.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
                        break;
        }
}
		
		
	}

}