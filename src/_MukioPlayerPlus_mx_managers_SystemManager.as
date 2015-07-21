package 
{
    import flash.system.ApplicationDomain;
    import flash.system.Security;
    import flash.utils.Dictionary;
    
    import mx.core.IFlexModule;
    import mx.core.IFlexModuleFactory;
    import mx.managers.SystemManager;
    
    import flashx.textLayout.compose.ISWFContext;

    public class _MukioPlayerPlus_mx_managers_SystemManager extends SystemManager implements IFlexModuleFactory, ISWFContext
    {
        private var _preloadedRSLs:Dictionary;

        public function _MukioPlayerPlus_mx_managers_SystemManager()
        {
			flash.system.Security.allowDomain("*");
			flash.system.Security.allowInsecureDomain("*");
            return;
        }// end function

        override public function callInContext(param1:Function, param2:Object, param3:Array, param4:Boolean = true):*
        {
            if (param4)
            {
                return param1.apply(param2, param3);
            }
            param1.apply(param2, param3);
            return;
        }// end function

        override public function create(... args) : Object
        {
            if (args.length > 0 && !(args[0] is String))
            {
                return super.create.apply(this, args);
            }
            var cls:String = args.length == 0 ? ("MukioPlayerPlus") : (String(args[0]));
            var _loc_3:* = Class(getDefinitionByName(cls));
            if (!_loc_3)
            {
                return null;
            }
            var _loc_4:* = new _loc_3;
            if (new _loc_3 is IFlexModule)
            {
                IFlexModule(_loc_4).moduleFactory = this;
            }
            return _loc_4;
        }// end function

        override public function info() : Object
        {
            return {addedToStage:"application1_addedToStageHandler(event)", applicationComplete:"application1_applicationCompleteHandler(event)", backgroundColor:"0xFFFFFF", cdRsls:[{rsls:["http://static.hdslb.com/RSL/textLayout_1.1.0.604.swz", "http://fpdownload.adobe.com/pub/swz/tlf/1.1.0.604/textLayout_1.1.0.604.swz", "http://static.hdslb.com/RSL/textLayout_1.1.0.604.swf"], policyFiles:["http://static.hdslb.com/swz_crossdomain.xml", "http://fpdownload.adobe.com/pub/swz/crossdomain.xml", "http://static.hdslb.com/swz_crossdomain.xml"], digests:["381814f6f5270ffbb27e244d6138bc023af911d585b0476fe4bd7961bdde72b6", "381814f6f5270ffbb27e244d6138bc023af911d585b0476fe4bd7961bdde72b6", ""], types:["SHA-256", "SHA-256", "SHA-256"], isSigned:[true, true, false]}, {rsls:["http://static.hdslb.com/RSL/framework_4.1.0.21490.swz", "http://fpdownload.adobe.com/pub/swz/flex/4.1.0.16076/framework_4.1.0.21490.swz", "http://static.hdslb.com/RSL/framework_4.1.0.21490.swf"], policyFiles:["http://static.hdslb.com/swz_crossdomain.xml", "http://fpdownload.adobe.com/pub/swz/crossdomain.xml", "http://static.hdslb.com/swz_crossdomain.xml"], digests:["f78f74378b1552ff9a1725155d1b43ba54be909497131c02b37bec561dfab9db", "f78f74378b1552ff9a1725155d1b43ba54be909497131c02b37bec561dfab9db", ""], types:["SHA-256", "SHA-256", "SHA-256"], isSigned:[true, true, false]}, {rsls:["http://static.hdslb.com/RSL/spark_4.1.0.16076.swz", "http://fpdownload.adobe.com/pub/swz/flex/4.1.0.16076/spark_4.1.0.16076.swz", "http://static.hdslb.com/RSL/spark_4.1.0.16076.swf"], policyFiles:["http://static.hdslb.com/swz_crossdomain.xml", "http://fpdownload.adobe.com/pub/swz/crossdomain.xml", "http://static.hdslb.com/swz_crossdomain.xml"], digests:["6344dcc80a9a6a3676dcea0c92c8c45efd2f3220b095897b0918285bbaef761d", "6344dcc80a9a6a3676dcea0c92c8c45efd2f3220b095897b0918285bbaef761d", ""], types:["SHA-256", "SHA-256", "SHA-256"], isSigned:[true, true, false]}, {rsls:["http://static.hdslb.com/RSL/sparkskins_4.1.0.16076.swz", "http://fpdownload.adobe.com/pub/swz/flex/4.1.0.16076/sparkskins_4.1.0.16076.swz", "http://static.hdslb.com/RSL/sparkskins_4.1.0.16076.swf"], policyFiles:["http://static.hdslb.com/swz_crossdomain.xml", "http://fpdownload.adobe.com/pub/swz/crossdomain.xml", "http://static.hdslb.com/swz_crossdomain.xml"], digests:["440ae73b017a477382deff7c0dbe4896fed21079000f6af154062c592a0c4dff", "440ae73b017a477382deff7c0dbe4896fed21079000f6af154062c592a0c4dff", ""], types:["SHA-256", "SHA-256", "SHA-256"], isSigned:[true, true, false]}, {rsls:["http://static.hdslb.com/RSL/rpc_4.1.0.16076.swz", "http://fpdownload.adobe.com/pub/swz/flex/4.1.0.16076/rpc_4.1.0.16076.swz", "http://static.hdslb.com/RSL/rpc_4.1.0.16076.swf"], policyFiles:["http://static.hdslb.com/swz_crossdomain.xml", "http://fpdownload.adobe.com/pub/swz/crossdomain.xml", "http://static.hdslb.com/swz_crossdomain.xml"], digests:["6ddb94ae3365798230849fa0f931ac132fe417d1cab1d2f47d334f8a47d097a7", "6ddb94ae3365798230849fa0f931ac132fe417d1cab1d2f47d334f8a47d097a7", ""], types:["SHA-256", "SHA-256", "SHA-256"], isSigned:[true, true, false]}], compiledLocales:["zh_CN"], compiledResourceBundleNames:["SharedResources", "collections", "components", "containers", "controls", "core", "effects", "formatters", "layout", "logging", "messaging", "rpc", "skins", "sparkEffects", "styles", "textLayout"], currentDomain:ApplicationDomain.currentDomain, mainClassName:"MukioPlayerPlus", mixins:["_MukioPlayerPlus_FlexInit", "_MukioPlayerPlus_Styles", "mx.messaging.config.LoaderConfig", "mx.managers.systemClasses.ActiveWindowManager"]};
        }// end function

        override public function get preloadedRSLs() : Dictionary
        {
            if (this._preloadedRSLs == null)
            {
                this._preloadedRSLs = new Dictionary(true);
            }
            return this._preloadedRSLs;
        }// end function

        override public function allowDomain(... args) : void
        {
            //args = null;
			trace("FFFFFFFKKKKK_MukioPlayerPlus_mx_managers_SystemManager");
            Security.allowDomain(args);
            return;
        }// end function

        override public function allowInsecureDomain(... args) : void
        {
           // args = null;
			trace("FFFFFFFKKKKK_MukioPlayerPlus_mx_managers_SystemManager");
            Security.allowInsecureDomain(args);
            return;
        }// end function

    }
}
