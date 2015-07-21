/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Jul 21, 2015 5:13:47 PM			
 * ===================================
 */

package
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	
	public class Blibli extends Sprite
	{
		private var player:IEventDispatcher;
		
		public function Blibli()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded)
		}
		
		protected function onAdded(event:Event):void
		{
			try
			{
				Log.level =4;
				Log.useTracer = true;
				Log.info("onAdded",this.loaderInfo.url);
				
				flash.system.Security.allowDomain("*");
				flash.system.Security.allowInsecureDomain("*");
				
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
				
				var lbox:Sprite = new Sprite();
				this.mouseEnabled = lbox.mouseEnabled = false;
				var url:String = "http://static.hdslb.com/miniloader.swf?";//"http://1.avfunapi.sinaapp.com/play_0.swf?"//
				
				if(stage.loaderInfo.parameters!=null)
				{
					var a:Array = [];
					for(var i:String in stage.loaderInfo.parameters)
					{
						a.push(i+"="+stage.loaderInfo.parameters[i]);
					}
					url+=a.join("&");
				}else{
					url+="cid=4052899&aid=2594889"
				}
				//url+="cid=4052899&aid=2594889"
				Log.info("loading",JSON.stringify(stage.loaderInfo.parameters),url);
				
				var loader:Loader = new Loader();
				var ins:Object = null;
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(e:Event):void
				{
					lbox.addChild(loader);
					var id:int = setInterval(function():void
					{
						try{
							var has:Boolean = loader.contentLoaderInfo.applicationDomain.hasDefinition("tv.bilibili.script.CommentScriptFactory");
							if(has)
							{
								var cls:Object = loader.contentLoaderInfo.applicationDomain.getDefinition("tv.bilibili.script.CommentScriptFactory");
								ins = cls["getInstance"]();
								clearInterval(id);
								setTimeout(getTime,200);
							}
						}catch(er:Error){
							Log.info(er);
							return;
						}
					},100);
				});
				
				var getTime:Function = function():void
				{
					if(ins.player!=null&&ins.player["model"]&&ins.player["model"]["media"]&&ins.player["model"]["media"]["display"])
					{
						Log.info("当前播放时间：",ins.player.state);
						player = ins.player;
						var media:Object = player["model"]["media"];
						var video:DisplayObject = player["model"]["media"]["display"] as DisplayObject;
						var config:Object = player["model"]["config"];
						var EXACTFIT:String = "exactfit";
						var FILL:String = "fill";
						var NONE:String = "none";
						var UNIFORM:String = "uniform";
						const DEFAULT:String = "default";
						const _4_3:String = "4:3";
						config.stretching = EXACTFIT;
						//video.opaqueBackground = 0xFF0000;
						addChild(video);
						media["play"]();
						media["resize"](stage.stageWidth,stage.stageHeight);
						player.addEventListener("jwplayerPlayerState",onjwplayerPlayerState);
						player.addEventListener("jwplayerMediaTime",ontimeUpdate);
						return;
					}
					setTimeout(getTime,200);
				}
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function():void
				{});
				loader.visible = false;
				stage.addChild(lbox);
				var ldr:LoaderContext = new LoaderContext();
				ldr.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
				//ldr.allowCodeImport = true;
				loader.load(new URLRequest(url),ldr);
			}catch(er:Error){
				Log.info(er);
			}
		}
		
		private function ontimeUpdate(e:Event):void
		{
			Log.info("当前播放时间：",e["position"]);
			callJS("timeUpdate",{"position":e["position"],"duration":e["duration"]});
		}
		
		private function onjwplayerPlayerState(e:Event):void
		{
			Log.info("当前播放:",e["newstate"]);
			callJS("playStatus",e["newstate"]);
			//this.url
		}
		
		private function callJS(name:String,args:* = null):void
		{
			if(ExternalInterface.available)
			{
				try{
					ExternalInterface.call(name,args);
				}catch(e:Error){}
			}
		}
	}
}