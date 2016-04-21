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
		public static const MAX_ROWS:int = 12;
		
		
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
			
			//инициализация главного меню
			var btn1:Bitmap = new Embed.btn1 as Bitmap;
			var btn1_texture:Texture = Texture.fromBitmap(btn1);
			
			var btn2:Bitmap = new Embed.btn2 as Bitmap;
			var btn2_texture:Texture = Texture.fromBitmap(btn2);
			
			var btn3:Bitmap = new Embed.btn3 as Bitmap;
			var btn3_texture:Texture = Texture.fromBitmap(btn3);
			
			var brand:Bitmap = new Embed.brand as Bitmap;
			var brand_texture:Texture = Texture.fromBitmap(brand);	
			
			var menuBack:Bitmap = new Embed.menuBack as Bitmap;
			var menuBack_texture:Texture = Texture.fromBitmap(menuBack);			
		
			
			
			assetMgr = new AssetManager();
			assetMgr.addTexture("gem1", gem1_texture);
			assetMgr.addTexture("gem2", gem2_texture);
			assetMgr.addTexture("gem3", gem3_texture);
			
			assetMgr.addTexture("bg", bg_texture);
			
			
			assetMgr.addTexture("btn1", btn1_texture);
			assetMgr.addTexture("btn2", btn2_texture);
			assetMgr.addTexture("btn3", btn3_texture);
			
			assetMgr.addTexture("brand", brand_texture);
			
			assetMgr.addTexture("menuBack", menuBack_texture);		
		
		}
		
	}

}