/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Jun 3, 2015 5:46:20 PM			
 * ===================================
 */

package  
{
	import flash.external.ExternalInterface;
	
	public final class LogAcfun
	{
		/**
		 * 数字越大信息越多，0只输出error，1增加warn，2增加info，3增加log，4增加debug
		 */		
		public static var level:uint;
		/**
		 * 是否在flash平台trace日志 
		 */		
		public static var useTracer:Boolean = false;
		
		private static const LEVEL_TYPE:Array = ["DEBUG","LOG","INFO","WARN","ERROR"];
		
		public function LogAcfun()
		{
			
		}
		
		public static function debug(...value):void
		{
			level>=4&&out(LEVEL_TYPE[0],value);
		}
		
		public static function log(...value):void
		{
			level>=3&&out(LEVEL_TYPE[2],value);
		}
		
		public static function info(...value):void
		{
			level>=2&&out(LEVEL_TYPE[2],value);
		}
		
		public static function warn(...value):void
		{
			level>=1&&out(LEVEL_TYPE[3],value);
		}
		
		public static function error(...value):void
		{
			out(LEVEL_TYPE[4],value);
		}
		
		private static function out(type:String,...value):void
		{
			var t:Date = new Date();
			var format:String = "";
			
			if(ExternalInterface.available)
			{
				try{
					ExternalInterface.call("console."+type.toLowerCase(),format);
				}catch(e:Error){
					trace("~"+format);
					return;
				}
			}
			
			useTracer&&trace(format);
		}
		
	}
}