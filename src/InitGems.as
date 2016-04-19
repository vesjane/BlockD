package 
{
	import flash.display.Bitmap;
	import properties.Embed;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Garonna
	 */
	public class InitGems extends Sprite 
	{
		
		private var assetMgr:AssetManager;
		private static var _instance:InitGems = null;
		
		public static const MAX_COLS:int = 10;
		public static const MAX_ROWS:int = 14;
		
		
		public function InitGems() 
		{
			loadResources();
		}
		
		public function getAssetMgr():AssetManager
		{
			return assetMgr;
		}
		
		
		public static function instance():InitGems
		{
			if (!_instance)
			{
				_instance = new InitGems();
			}
			return _instance;
		}
		
		private function loadResources():void
		{
			var gem1:Bitmap = new Embed.Gem1 as Bitmap;
			var gem1_texture:Texture = Texture.fromBitmap(gem1);
			
			var gem2:Bitmap = new Embed.Gem2 as Bitmap;
			var gem2_texture:Texture = Texture.fromBitmap(gem2);
			
			var gem3:Bitmap = new Embed.Gem3 as Bitmap;
			var gem3_texture:Texture = Texture.fromBitmap(gem3);
			
			var bg:Bitmap = new Embed.bg as Bitmap;
			var bg_texture:Texture = Texture.fromBitmap(bg);
			
			assetMgr = new AssetManager();
			assetMgr.addTexture("gem1", gem1_texture);
			assetMgr.addTexture("gem2", gem2_texture);
			assetMgr.addTexture("gem3", gem3_texture);
			
			assetMgr.addTexture("bg", bg_texture);
		}
		
	}

}