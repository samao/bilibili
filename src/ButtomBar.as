/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	May 6, 2015 5:13:46 PM			
 * ===================================
 */

package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	public class ButtomBar extends Sprite implements IView
	{
		/**
		 * 播放器底栏高度 
		 */		
		static public const BUTTON_H:int = 30;
		private var fullBut:TextField;
		private var _pro:Shape;
		private var _timeTxt:TextField;
		
		private var _proBglayer:Sprite;
		
		public function ButtomBar()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			_pro ||= new Shape();
			this.addChild(_pro);
			fullBut ||= new TextField();
			//fullBut.opaqueBackground = 0x000000;
			fullBut.selectable = false;
			fullBut.defaultTextFormat = new TextFormat("微软雅黑,宋体",12,0xffffff,true);
			fullBut.autoSize = "left";
			fullBut.text = "FULL";
			addChild(fullBut);
			
			_timeTxt ||= new TextField();
			_timeTxt.mouseEnabled = false;
			_timeTxt.defaultTextFormat = fullBut.defaultTextFormat;
			_timeTxt.autoSize = "left";
			addChild(_timeTxt);
			
			_proBglayer ||= new Sprite();
			_proBglayer.graphics.beginFill(0x00FF00,.5);
			_proBglayer.graphics.drawRect(0,0,stage.stageWidth,4);
			_proBglayer.graphics.endFill();
			_proBglayer.buttonMode = true;
			this.addChild(_proBglayer);
			
			_proBglayer.addEventListener(MouseEvent.CLICK,function():void
			{
				dispatchEvent(new Event("toSeek"));
			});
			
			fullBut.addEventListener(MouseEvent.CLICK,function():void
			{
				if(stage.displayState == flash.display.StageDisplayState.NORMAL)
				{
					stage.displayState = StageDisplayState.FULL_SCREEN;
					fullBut.text = "NORMAL";
				}else{
					stage.displayState = StageDisplayState.NORMAL;
					fullBut.text = "FULL";
				}
				fullBut.x = stage.stageWidth - fullBut.width - 5;
				fullBut.y = BUTTON_H - fullBut.height>>1;
			});
			
			resize();
			progress = 0;
		}
		
		public function set progress(value:Number):void
		{
			if(isNaN(value))return;
			_pro.graphics.clear();
			var w:Number = value*this.width;
			_pro.graphics.beginFill(0xFFFFFF,1);
			_pro.graphics.drawRect(0,0,w,4);
			_pro.graphics.endFill();
		}
		
		public function get progress():Number
		{
			return mouseX/_proBglayer.width;
		}
		
		public function setCT(c:Number,t:Number):void
		{
			this._timeTxt.text = this.digits(c)+" / "+this.digits(t);
			this._timeTxt.y = BUTTON_H - this._timeTxt.height>>1;
			this._timeTxt.x = 5;
		}
		
		public function digits(nbr:Number):String {
			var str:String = nbr<0?"-":"";
			nbr = int(Math.abs(nbr));
			var min:Number = Math.floor(nbr / 60);
			var sec:Number = Math.floor(nbr % 60);
			str += zeroPad(min) + ':' + zeroPad(sec);
			return str;
		}
		
		public function zeroPad(number:*, width:int = 2):String {
			var ret:String = "" + number;
			while( ret.length < width )
				ret="0" + ret;
			return ret;
		}
		
		private function draw():void
		{
			this.graphics.clear();
			graphics.clear();
			graphics.beginFill(0x0000FF,.1);
			graphics.drawRect(0,0,stage.stageWidth,BUTTON_H);
			graphics.endFill();
		}
		
		private function algin():void
		{
			fullBut.x = stage.stageWidth - fullBut.width - 5;
			fullBut.y = BUTTON_H - fullBut.height>>1;
			_proBglayer.width = stage.stageWidth;
			y = stage.stageHeight - BUTTON_H;
		}
		
		public function resize():void
		{
			if(stage)
			{
				draw();
				algin();
			}
		}
	}
}