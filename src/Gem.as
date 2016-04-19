package 
{
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	/**
	 * ...
	 * @author Garonna
	 */
	public class Gem extends Sprite
	{
		private var img:Image;
		private var gemTextures:Array;
		private var tween:Tween;
		
		public static const GEM_TOUCHED:String = "GemTouched";
		
		public static const DISAPPEAR_DELAY:Number = 0.5;
		public static const MOVE_DELAY:Number = 0.2;
		
		
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
			
			this.addEventListener(TouchEvent.TOUCH, onTouch);		
			
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
			img.texture = gemTextures[this.gemType] as Texture;
			this.scaleX = this.scaleY = this.holder.scaleX = this.holder.scaleY = 1;
			
		}
		
		public function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if (touch && touch.phase == TouchPhase.ENDED)
			{
				this.dispatchEventWith(GEM_TOUCHED);
				
			}
			
		}
		
		public function moveTo(x:Number, y:Number, needCallback:Boolean = false):void
		{
			tween = new Tween(this, MOVE_DELAY, Transitions.EASE_IN);
			tween.moveTo(x, y);
			tween.fadeTo(1);
			if (needCallback) tween.onComplete = animationComplete;
			Starling.juggler.add(tween);
		}
		
		private function animationComplete():void
		{
			//this.dispatchEventWith(GEM_MOVED);
		}
		
		//----------------------------------------------
		private var _gemType:int;
		
		public function get gemType():int 
		{
			return _gemType;
		}
		
		public function set gemType(value:int):void 
		{
			if (_gemType == value)
				return;
			_gemType = value;	
			if (img)
				img.texture = gemTextures[_gemType] as Texture;
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
			if (this.gemType == 3) trace ("3!");
		}
		
		
		
		
	}

}