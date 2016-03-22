package 
{
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Garonna
	 */
	public class Gem extends Sprite
	{
		private var img:Image;
		private var gemTextures:Array;
		
		public static const GEM_TOUCHED:String = "GemTouched";
		
		
		
		private var holder:Sprite = new Sprite();
		
		public function Gem() 
		{
			super();
			
			var game:InitGems = InitGems.instance();
			gemTextures = new Array(
			game.getAssetMgr().getTexture("gem1"),
			game.getAssetMgr().getTexture("gem2"),
			game.getAssetMgr().getTexture("gem3"));
			
			addChild(holder);
			
			this.gemType = randomNumber(0, 2);
			img = new Image(gemTextures[this.gemType]);
			
			holder.addChild(img);
			img.x = img.width / 2;
			img.y = img.height / 2;
			
			holder.x = img.width / 2;
			holder.y = img.height / 2;
			
			//this.alpha = 0;
			
			
		}
		
		
		private function randomNumber(min:Number, max:Number):Number 
		{
			return Math.floor(Math.random() * (1 + max - min) + min);
		}
		
		
		public function revive():void
		{
			this.alpha = holder.alpha = 1.0;
			this.marked = false;
			this.randomize();
			this.scaleX = this.scaleY = this.holder.scaleX = this.holder.scaleY = 1;
		}
		
		
		//----------------------------------------------
		private var _gemType:int;
		
		public function get gemType():int 
		{
			return _gemType;
		}
		
		public function set gemType(value:int):void 
		{
			_gemType = value;
		}
		
		private var _row:int;
		
		public function get row():int 
		{
			return _row;
		}
		
		public function set row(value:int):void 
		{
			_row = value;
		}
		
		
		private var _col:int;
		
		public function get col():int 
		{
			return _col;
		}
		
		public function set col(value:int):void 
		{
			_col = value;
		}
		
		private var _marked:Boolean = false;
		public function get marked():Boolean { return _marked; }
		
		public function set marked(value:Boolean):void
		{
			if (_marked == value)
				return;
			_marked = value;
		}
		
		
		public function cycle():void
		{
			if (this.gemType == 3) 
				this.gemType = 0;
			else 
				this.gemType++;
		}
		
		
		public function randomize():void
		{
			//1 in 16 chance for the wild card gem
			this.gemType = randomNumber(0, 2);		
			if (this.gemType == 3) trace ("3!!!!");
		}
		
		
		
		
	}

}