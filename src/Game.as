package
{
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import starling.display.Sprite;	
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.formatString;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	/**
	 * ...
	 * @author Garonna
	 */
	public class Game extends Sprite 
	{		
        private var board:GameWorld = new GameWorld();
		
        public function Game()
        {
			super();            
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);        
            
		}
		
		private function onAddedToStage(e:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            
            createGameBoard();
        }
		
		private function createGameBoard()
		{
			var game:InitGems = InitGems.instance();
			
			board = new GameWorld();			
			
			addChild(new Image(game.getAssetMgr().getTexture("bg")));
			addChild(board);
		}
		
	}
	
}