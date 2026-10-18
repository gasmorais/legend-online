package
{
   import com.greensock.plugins.MotionBlurPlugin;
   import com.greensock.plugins.TransformAroundCenterPlugin;
   import com.greensock.plugins.TweenPlugin;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.MD5;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import loading.MaxLoading;
   import loading.SmallLoading;
   import manager.DesktopManager;
   import manager.ExternalInterfaceManager;
   import queue.LoginQueue;
   import queue.LoginQueueView;
   import utils.CrytoUtils;
   
   [SWF(width="1000", height="600", backgroundColor="#0e0805", frameRate="25")]
   public class Loading extends Sprite
   {
      
      private var _config:XML;
      
      private var _configURL:String = "config.xml";
      
      private var _configLoader:URLLoader;
      
      private var _flashSite:String = "";
      
      private var _requestPath:String;
      
      private var _user:String = "";
      
      private var _pass:String = "";
      
      private var _userInfo:Object;
      
      private var _site:String = "";
      
      private var _p2:String = "";
      
      private var _rid:String = "";
      
      private var _loginType:String = "1";
      
      private var _tip:TextField;
      
      private var _textFormat:TextFormat;
      
      private var _showRegisterLoading:Boolean = false;
      
      private var _queueView:LoginQueueView;
      
      public function Loading()
      {
         super();
         if(stage)
         {
            init();
         }
         else
         {
            addEventListener("addedToStage",init);
         }
      }
      
      private function init() : void
      {
         TweenPlugin.activate([TransformAroundCenterPlugin]);
         TweenPlugin.activate([MotionBlurPlugin]);
         removeEventListener("addedToStage",init);
         ExternalInterfaceManager.instance.isSafeFlash();
         stage.align = "TL";
         stage.scaleMode = "noScale";
         stage.addEventListener("resize",__stageResizeHandler);
         StageReferance.setup(stage);
         LayerManager.Instance.setup(stage);
         ExternalInterfaceManager.instance.setup();
         ExternalInterfaceManager.instance.setSelfAdapting();
         DesktopManager.Instance.checkIsDesktop();
         _tip = new TextField();
         _textFormat = new TextFormat("Arial",18,16769414,true,null,null,null,null,"center");
         _tip.defaultTextFormat = _textFormat;
         _tip.autoSize = "center";
         _tip.mouseEnabled = false;
         _tip.text = "";
         _tip.width = 1000;
         _userInfo = {};
         if(stage.loaderInfo.parameters["user"])
         {
            _user = stage.loaderInfo.parameters["user"];
         }
         if(stage.loaderInfo.parameters["key"])
         {
            _pass = stage.loaderInfo.parameters["key"];
         }
         if(stage.loaderInfo.parameters["site"])
         {
            _site = stage.loaderInfo.parameters["site"];
         }
         if(stage.loaderInfo.parameters["p2"])
         {
            _p2 = stage.loaderInfo.parameters["p2"];
         }
         if(stage.loaderInfo.parameters["logintype"])
         {
            _loginType = stage.loaderInfo.parameters["logintype"];
         }
         if(_loginType != "1" && _loginType != "2" && _loginType != "3" && _loginType != "4")
         {
            _loginType = "1";
         }
         if(_loginType == "2")
         {
            DesktopManager.Instance.desktopType = 2;
         }
         if(_loginType == "4")
         {
            DesktopManager.Instance.desktopType = 4;
         }
         if(stage.loaderInfo.parameters["config"] && String(stage.loaderInfo.parameters["config"]).length > 1)
         {
            _configURL = stage.loaderInfo.parameters["config"];
         }
         if(stage.loaderInfo.parameters["rid"])
         {
            _rid = stage.loaderInfo.parameters["rid"];
         }
         if(stage.loaderInfo.parameters["http"])
         {
            if(stage.loaderInfo.parameters["http"] == "https:")
            {
               ComponentSetting.ISFROMHTTPS = true;
            }
            else
            {
               ComponentSetting.ISFROMHTTPS = false;
            }
         }
         _userInfo.site = _site;
         _userInfo.user = _user;
         _userInfo.password = _pass;
         _userInfo.userId = 0;
         _userInfo.site = _site;
         _userInfo.p2 = _p2;
         _userInfo.rid = _rid;
         _userInfo.tempPassword = String(int(Math.random() * 10000000));
         _userInfo.key = MD5.hash(_userInfo.tempPassword);
         loadConfig();
      }
      
      private function loadConfig() : void
      {
         var _loc1_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         DisplayLoader.Context = _loc1_;
         ClassUtils.uiSourceDomain = DisplayLoader.Context.applicationDomain;
         LoaderSavingManager.setup();
         _configLoader = new URLLoader();
         _configLoader.addEventListener("complete",__configLoadComplete);
         _configLoader.load(new URLRequest(_configURL + "?rnd=" + Math.random().toString()));
      }
      
      private function __configLoadComplete(param1:Event) : void
      {
         _configLoader.removeEventListener("complete",__configLoadComplete);
         _configLoader = null;
         addChild(_tip);
         _tip.x = (stage.stageWidth - _tip.width) / 2;
         _tip.y = (stage.stageHeight - _tip.height) / 2;
         var _loc5_:XML = new XML(param1.target.data);
         if(ComponentSetting.ISFROMHTTPS)
         {
            configConvertToHTTPS(_loc5_);
         }
         if(_loc5_..config.length() > 0)
         {
            _config = _loc5_..config[0];
            var _loc2_:* = _config..NODE.(@site == _site);
            var _loc4_:String = _loc2_.CLIENT_LOGIN_NAME.@value;
            var _loc3_:String = _config[0].VERSION.@value;
            ExternalInterfaceManager.instance.setExternalInfo(_loc4_,_loc3_);
            _requestPath = String(_config[0].REQUEST_PATH.@value);
            _flashSite = String(_loc2_.SITE.@value);
            ComponentSetting.REQUEST_PATH = _config[0].REQUEST_PATH.@value;
            ComponentSetting.TEMPLATE_PATH = _config[0].TEMPLATE_PATH.@value;
            ComponentSetting.VERTION_PATH = ComponentSetting.TEMPLATE_PATH + "version.xml";
            ComponentSetting.RESOURCE_PATH = String(_config[0].ResourcePath.@value);
            ComponentSetting.BACKUP_RESOURCE_PATH = String(_config[0].Backup_ResourcePath.@value);
            ComponentSetting.LANGUAGE = String(_config[0].LANGUAGE.@value);
            ComponentSetting.SITE = String(_userInfo.site);
            ComponentSetting.LOGIN_RND = Math.random() * 10000;
            ComponentSetting.initWorkedResourcePath();
            DisplayLoader.isDebug = false;
            DisplayLoader.isOldres = false;
            MaxLoading.loadingSusliks = true;
            MaxLoading.showNetTips = true;
            if(!setRSAKey())
            {
               return;
            }
            loadSelectList(null);
            return;
         }
         throw new ErrorEvent("SELECTLIST_LOAD_ERROR",true,false,"Load config file fail! Please try again later!");
      }
      
      private function configConvertToHTTPS(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc4_:int = 0;
         var _loc6_:XMLList = param1.children();
         _loc4_ = 0;
         for(; _loc4_ < _loc6_.length(); _loc4_++)
         {
            _loc2_ = _loc6_[_loc4_] as XML;
            _loc3_ = _loc2_.@root;
            if(_loc3_ != null && _loc3_ != "")
            {
               _loc3_ = _loc3_.replace("http","https").replace(":8080","");
               _loc2_.@root = _loc3_;
            }
            _loc5_ = _loc2_.@source;
            if(_loc5_ != null && _loc5_ != "")
            {
               _loc5_ = _loc5_.replace("http","https").replace(":8080","");
               _loc2_.@source = _loc5_;
            }
            _loc7_ = _loc2_.@value;
            if(_loc7_ != null && _loc7_ != "")
            {
               if(_loc2_.name().localName == "UPLOAD_PATH")
               {
                  continue;
               }
               _loc7_ = _loc7_.replace("http","https").replace(":8080","");
               _loc2_.@value = _loc7_;
            }
            if(_loc2_.hasComplexContent())
            {
               configConvertToHTTPS(_loc2_);
            }
         }
      }
      
      private function setRSAKey() : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         for each(var _loc1_:XML in _config..NODE)
         {
            if(_loc1_.@site == _site)
            {
               _loc2_ = _loc1_.RSAKey.@PublicKeyModulus;
               _loc3_ = _loc1_.RSAKey.@publicExponent;
               _userInfo.RSAkey = CrytoUtils.generateRsaKey(_loc2_,_loc3_);
               return true;
            }
         }
         _tip.text = "Site não encontrado:" + _site + " Retorno à página de login em 3 segundos";
         setTimeout(returnHome,3000);
         return false;
      }
      
      private function returnHome() : void
      {
         if(_site.indexOf("brazil") != -1 || _site.indexOf("broas") != -1 || _site.indexOf("337pt") != -1 || _site.indexOf("pt") != -1)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("callInterruption",_user,_site);
            }
            return;
         }
         ExternalInterfaceManager.instance.returnHome();
         navigateToURL(new URLRequest(_flashSite),"_self");
      }
      
      private function loadSelectList(param1:Event) : void
      {
         var _loc3_:URLVariables = new URLVariables();
         _loc3_["username"] = _user;
         _loc3_["site"] = _site;
         _loc3_["rnd"] = Math.random();
         var _loc2_:URLRequest = new URLRequest(_requestPath + "loginselectlist");
         _loc2_.data = _loc3_;
         var _loc4_:URLLoader = new URLLoader();
         _loc4_.addEventListener("complete",__loadSelectListComplete);
         _loc4_.addEventListener("ioError",__loadSelectListError);
         _loc4_.load(_loc2_);
      }
      
      private function __loadSelectListError(param1:IOErrorEvent) : void
      {
         throw new ErrorEvent("SELECTLIST_LOAD_ERROR",true,false,"Load selectList fail! Please try again later!");
      }
      
      private function __loadSelectListComplete(param1:Event) : void
      {
         param1.target.removeEventListener("complete",__loadSelectListComplete);
         param1.target.removeEventListener("ioError",__loadSelectListError);
         var _loc2_:XMLList = XML(param1.target.data)..Item;
         if(_loc2_.length() > 0)
         {
            if(_loc2_[0].@Active == "true")
            {
               _userInfo.isActive = true;
            }
            _userInfo.userId = int(_loc2_[0].@ID);
         }
         _userInfo.canJumpNovie = true;
         loadLogin();
      }
      
      private function register() : void
      {
         var _loc2_:String = null;
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["client"] = DesktopManager.Instance.isDesktop;
         _loc1_["userid"] = _userInfo.userId;
         _loc1_["nickname"] = "";
         _loc1_["camp"] = "";
         _loc1_["icon"] = 100;
         _loc1_["username"] = _userInfo.user;
         _loc1_["site"] = _userInfo.site;
         _loc1_["key"] = _userInfo.key;
         _loc1_["ran"] = Math.random();
         if(_p2 == "" || _p2 == null || _p2 + "" == "undefined")
         {
            _loc2_ = String(_config.REQUEST_PATH.@value) + "visualizeregister";
         }
         else
         {
            _loc2_ = String(_config.REQUEST_PATH.@value) + "visualizeregister2";
         }
         LoaderManagerII.instance.load(_loc2_,7,8,__onRegisterCompleteHandler,null,null,null,_loc1_);
      }
      
      private function __onRegisterCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         ExternalInterfaceManager.instance.setFirstLeave(_site,_user);
         reqNoviceProcess();
      }
      
      private function loadLogin() : void
      {
         var _loc3_:String = null;
         var _loc5_:URLVariables = new URLVariables();
         var _loc4_:ByteArray = new ByteArray();
         var _loc6_:String = myUrlEncode(_user,"UTF-8");
         _loc4_.writeUTFBytes(_loc6_ + "|" + _pass + "|" + _userInfo.tempPassword + "|" + _userInfo.userId);
         var _loc1_:String = CrytoUtils.rsaEncry4(_userInfo.RSAkey,_loc4_);
         if(DesktopManager.Instance.isDesktop)
         {
            _loginType = "2";
         }
         _loc5_["p"] = _loc1_;
         _loc5_["site"] = _site;
         _loc5_["p2"] = _p2;
         _loc5_["loginType"] = _loginType;
         _loc5_["client"] = DesktopManager.Instance.isDesktop;
         if(_p2 == "" || _p2 == null || _p2 + "" == "undefined")
         {
            _loc3_ = _requestPath + "login";
         }
         else
         {
            _loc3_ = _requestPath + "login2";
         }
         var _loc2_:LoginQueue = new LoginQueue(_loc3_,_loc5_);
         _loc2_.backCall = __onLoginComplete;
         _loc2_.errorCall = showError;
         _loc2_.load();
      }
      
      private function myUrlEncode(param1:String, param2:String) : String
      {
         var _loc4_:int = 0;
         var _loc5_:String = "";
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeMultiByte(param1,param2);
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ += escape(String.fromCharCode(_loc3_[_loc4_]));
            _loc4_++;
         }
         return _loc5_;
      }
      
      private function __onLoginComplete(param1:XML) : void
      {
         if(_queueView)
         {
            _queueView.dispose();
            _queueView = null;
         }
         var _loc3_:String = param1.@Address;
         _userInfo.userId = param1.@userId;
         _userInfo.serverName = param1.@CurrentServerName;
         _config..SocktPath.@value = _loc3_;
         _config..SocktPath.@SocketPort = param1.@Port;
         Security.allowDomain("*");
         var _loc2_:String = "xmlsocket://" + _loc3_ + ":843";
         Security.loadPolicyFile(_loc2_);
         SmallLoading.Instance.show(true);
         new Md5Versions(checkLunch,onMD5LoadProgress);
      }
      
      private function checkLunch() : void
      {
         var _loc1_:RegisterLuncher = null;
         if(!_userInfo.isActive)
         {
            _userInfo["noviceProcess"] = 0;
            LoginPreload.setup(_config,_userInfo);
            _loc1_ = new RegisterLuncher();
            _loc1_.lunch(_config,_userInfo,stage);
         }
         else
         {
            reqNoviceProcess();
         }
      }
      
      private function reqNoviceProcess() : void
      {
         var _loc1_:URLLoader = new URLLoader();
         var _loc2_:URLRequest = new URLRequest();
         var _loc3_:URLVariables = new URLVariables();
         _loc3_["op"] = 0;
         _loc3_["userid"] = _userInfo.userId;
         _loc3_["noviceprocess"] = 0;
         _loc3_["key"] = _userInfo.key;
         _loc3_["rnd"] = Math.random();
         _loc2_.url = _requestPath + "updateplayernovice";
         _loc2_.data = _loc3_;
         _loc2_.method = "POST";
         _loc1_.addEventListener("complete",__noviceReqCompleteHandler);
         _loc1_.load(_loc2_);
      }
      
      private function __noviceReqCompleteHandler(param1:Event) : void
      {
         var _loc3_:URLLoader = param1.currentTarget as URLLoader;
         _loc3_.removeEventListener("complete",__noviceReqCompleteHandler);
         _userInfo["noviceProcess"] = int(_loc3_.data);
         var _loc2_:String = ComponentSetting.getUISourcePath("mainloading");
         LoaderManagerII.instance.load(_loc2_,3,8,onNormalUILoadComplete,onNormalUILoadProgress);
      }
      
      private function onNormalUILoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:URLVariables = new URLVariables();
         _loc3_["rnd"] = ComponentSetting.LOGIN_RND;
         var _loc4_:String = ComponentSetting.RESOURCE_PATH + "background.jpg";
         LoaderManagerII.instance.load(_loc4_,2,8,onloadingBgCompleteHandler,onloadingBgProgress,null,null,_loc3_);
      }
      
      private function lunchNormal(param1:Object) : void
      {
         var _loc2_:MaxLoading = MaxLoading.Instance;
         _loc2_.addBgToMc(param1);
         _loc2_.show(stage);
         var _loc3_:NormalLuncher = new NormalLuncher();
         _loc3_.lunch(_config,_userInfo,stage,_loc2_);
      }
      
      private function onloadingBgCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:Object = {};
         _loc3_.url = "asset.loading.MainLoadingBg";
         if(param2)
         {
            _loc3_.bg = param2 as Bitmap;
         }
         else
         {
            _loc3_.bg = null;
         }
         SmallLoading.Instance.exit(lunchNormal,_loc3_);
      }
      
      private function onloadingBgProgress(param1:LoaderInfo) : void
      {
         var _loc2_:Number = param1.bytesLoaded / param1.bytesTotal;
         SmallLoading.Instance.progress = 80 + _loc2_ * 20;
      }
      
      private function onMD5LoadProgress(param1:LoaderInfo) : void
      {
         var _loc2_:Number = param1.bytesLoaded / param1.bytesTotal;
         SmallLoading.Instance.progress = _loc2_ * 50;
      }
      
      private function onNormalUILoadProgress(param1:LoaderInfo) : void
      {
         var _loc2_:Number = param1.bytesLoaded / param1.bytesTotal;
         SmallLoading.Instance.progress = 50 + _loc2_ * 30;
      }
      
      private function showError(param1:String, param2:int = 0, param3:Number = 0, param4:int = 0, param5:int = 0) : void
      {
         var _loc6_:String = LoginResultValue.getTipMessageByType(param1);
         if(param2 == 0)
         {
            _loc6_ += " Retorno à página de login em 3 segundos";
            setTimeout(returnHome,3000);
         }
         else if(param2 == 1)
         {
            if(!_queueView)
            {
               _queueView = new LoginQueueView(stage);
            }
            _queueView.update(param3,param4,param5);
            return;
         }
         trace(_loc6_);
         _tip.text = _loc6_;
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         if(_tip)
         {
            _tip.x = (stage.stageWidth - _tip.width) / 2;
            _tip.y = (stage.stageHeight - _tip.height) / 2;
         }
      }
      
      private function createLogin() : void
      {
      }
   }
}

