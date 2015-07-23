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
	import flash.text.TextField;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.clearInterval;
	import flash.utils.getQualifiedClassName;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import profile.Monitor;
	
	[SWF(backgroundColor="#343434")]
	public class Blibli extends Sprite
	{
		private var player:IEventDispatcher;
		private var media:Object 
		private var total:Number = 0;

		private var bb:ButtomBar;
		
		public function Blibli()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded)
		}
		
		protected function onAdded(event:Event):void
		{
			var stus:TextField = new TextField();
			stus.autoSize="left";
			stus.textColor = 0xFFFFFF;
			
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
					if(a.length>0)
					{
						url+=a.join("&");
					}else{
						url+="cid=4062746&aid=2600384"
					}
				}
				//url+="cid=1402514&aid=970200"
				
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
						player = ins.player;
						media = player["model"]["media"];
						var video:DisplayObject = player["model"]["media"]["display"] as DisplayObject;
						var config:Object = player["model"]["config"];
						const EXACTFIT:String = "exactfit";
						const FILL:String = "fill";
						const NONE:String = "none";
						const UNIFORM:String = "uniform";
						const DEFAULT:String = "default";
						const _4_3:String = "4:3";
						config.stretching = EXACTFIT;
						//video.opaqueBackground = 0xFF0000;
						Log.info("播放器：",media.provider);
						var ready:Boolean = true;
						
						var onReady:Function = function():void
						{
							Log.info("获取视频成功:",flash.utils.getQualifiedClassName(video));
							try{
								//video.opaqueBackground = 0x00FF00;
								vBox.addChild(video);
								player.addEventListener("jwplayerPlayerState",onjwplayerPlayerState);
								player.addEventListener("jwplayerMediaTime",ontimeUpdate);
								Log.info("getTime：",player,video,media);
								stus.visible = false;
								bb.visible = true;
								media["play"]();
								media["resize"](stage.stageWidth,stage.stageHeight - ButtomBar.BUTTON_H);
							}catch(eo:Error){
								Log.error("播放错误：",eo.getStackTrace());
							}
						}
						if(media.provider=="letv-swf")
						{
							ready = false;
							var has:Boolean = loader.contentLoaderInfo.applicationDomain.hasDefinition("org.lala.event.EventBus");
							if(has)
							{
								var eventcls:Object = loader.contentLoaderInfo.applicationDomain.getDefinition("org.lala.event.EventBus");
								var ev:Object = eventcls["getInstance"]();
								ev.addEventListener("adSwitch",function(ec:Event):void
								{
									if(ec["data"].isAd!=false)
									{
										return;
									}
									var has:Boolean = loader.contentLoaderInfo.applicationDomain.hasDefinition("org.lala.plugins.CommentView");
									if(has)
									{
										var cls:Object = loader.contentLoaderInfo.applicationDomain.getDefinition("org.lala.plugins.CommentView");
										var cv:Object = cls["getInstance"]();
										video = cv.clip.parent.getChildAt(0).getChildAt(1);
										setTimeout(onReady,2000);
									}
								});
							}
						}else{
							onReady();
						}
						return;
					}
					setTimeout(getTime,200);
				}
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function():void
				{});
				lbox.visible = false;
				stage.addChild(lbox);
				var ldr:LoaderContext = new LoaderContext();
				ldr.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
				//ldr.allowCodeImport = true;
				loader.load(new URLRequest(url),ldr);
			}catch(er:Error){
				Log.info(er);
			}
			var vBox:Sprite = new Sprite();
			this.addChild(vBox);
			bb = new ButtomBar();
			bb.visible = false;
			this.addChild(bb);
			this.addChild(stus);
			bb.addEventListener("toSeek",function():void
			{
				if(media)
				{
					media.seek(total*bb.progress);
				}
			});

			stus.text="加载...";
			stus.x = stage.stageWidth - stus.width>>1;
			stus.y = stage.stageHeight - stus.height>>1;
			stage.addEventListener(Event.RESIZE,function():void
			{
				bb.resize();
				media&&media["resize"](stage.stageWidth,stage.stageHeight - ButtomBar.BUTTON_H);
				stus.x = stage.stageWidth - stus.width>>1;
				stus.y = stage.stageHeight - stus.height>>1;
			});
			var m:Monitor = new Monitor();
			//m.opaqueBackground = 0x0000FF;
			this.addChild(m);
			this.contextMenu = new ContextMenu();
			this.contextMenu.hideBuiltInItems();
			this.contextMenu.customItems = [new ContextMenuItem("ACFUN_SUPER",false,false)];
		}
		
		private function ontimeUpdate(e:Event):void
		{
			Log.info("当前播放时间：",e["position"]);
			callJS("timeUpdate",{"position":e["position"],"duration":e["duration"]});
			total = e["duration"];
			bb.progress = e["position"]/e["duration"];
			bb.setCT(e["position"],e["duration"]);
		}
		
		private function onjwplayerPlayerState(e:Event):void
		{
			Log.info("当前播放:",e["newstate"]);
			callJS("playStatus",e["newstate"]);
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