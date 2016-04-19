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
        private var board:GameWorld;
		
        public function Game()
        {
			super();            
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);        
            
		}
		
		private function onAddedToStage(e:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            
            createGameBoard();
        }
		
		private function createGameBoard():void
		{
			var game:InitGems = InitGems.instance();
			
			board = new GameWorld();	
			var img:Image = new Image(game.getAssetMgr().getTexture("bg"));
			
			addChild(img);
			placeBackground(img);
			addChild(board);
			
		}
		
		private function placeBackground(scaledObject:Image):void {
                        scaledObject.scaleX = scaledObject.scaleY = 1;
                        var scale:Number;
                        if (scaledObject.width / scaledObject.height > stage.stageWidth / stage.stageHeight){
                                scale = stage.stageHeight / scaledObject.height;
                        }
                        else {
                                scale = stage.stageWidth / scaledObject.width;
                        }
                        scaledObject.scaleX = scaledObject.scaleY = scale;
                        scaledObject.x = (stage.stageWidth - scaledObject.width) / 2;
                        scaledObject.y = (stage.stageHeight - scaledObject.height) / 2;
                }
		
	}
	
}