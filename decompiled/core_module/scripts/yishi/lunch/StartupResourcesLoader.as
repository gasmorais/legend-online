package yishi.lunch
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.FilterWordAnalyzer;
   import com.pickgliss.loader.LanguageAnalyzer;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.UiConfigAnalyzer;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentSetting;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import manager.AgentFilterManager;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.preload.PreRigeterCampaignData;
   import yishi.GlobalConfig;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.StartupEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.BaseManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NewGuildHelpManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.resolve.TemplateResolveQueue;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.RightMenuUtils;
   import yishi.utils.StringUtil;
   
   public class StartupResourcesLoader extends EventDispatcher
   {
      
      private static var _instance:StartupResourcesLoader;
      
      public static const TIP_LOADNOW:String = "Carregando    ";
      
      public static const TIP_NEWB_CAMP:String = "Campanha Tutorial";
      
      public static const TIP_PRE_DATA:String = "Preparando Dados";
      
      public static const TIP_INIT_GAME:String = "Iniciando Jogo";
      
      public static const FORMAT_TEXT:String = "text";
      
      public static const FORMAT_XML:String = "xml";
      
      public static const FORMAT_BYTE:String = "byte";
      
      private var _userInfo:Object;
      
      private var _config:XML;
      
      private var _step:int;
      
      private var _resourcesList:Dictionary;
      
      private var _proObj:Object;
      
      private var _curLoadCount:int = 0;
      
      private var _needLoadCount:int = 0;
      
      private var _loadIsStarted:Boolean = false;
      
      private var _loadIsCompleted:Boolean = false;
      
      private var _isPreload:Boolean;
      
      public function StartupResourcesLoader()
      {
         super();
         _proObj = {};
         updateProObj(0.0625,0,"");
      }
      
      public static function get instance() : StartupResourcesLoader
      {
         if(!_instance)
         {
            _instance = new StartupResourcesLoader();
         }
         return _instance;
      }
      
      public function start(param1:Object, param2:XML = null, param3:Boolean = false) : void
      {
         _isPreload = param3;
         _userInfo = param1;
         _config = param2;
         BaseManager.instance.isRigister = _userInfo.isActive;
         if(!_isPreload && _loadIsCompleted)
         {
            reqLoginInitData();
            return;
         }
         if(_loadIsStarted)
         {
            return;
         }
         _loadIsStarted = true;
         EnterFrameManager.instance.setup(StageReferance.stage);
         _step = 1;
         LoaderManagerII.instance.load(ComponentSetting.getUISizeXMLPath(),7,8,onUISizeConfigLoadComplete,onResourcesLoadProgress);
      }
      
      private function onUISizeConfigLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:DataAnalyzer = new UiConfigAnalyzer(null);
         _loc3_.analyzeCompleteCall = loadResources;
         _loc3_.analyze(param2);
      }
      
      private function loadResources() : void
      {
         _step = 2;
         _resourcesList = new Dictionary(true);
         _resourcesList[PathManager.versionPath] = 7;
         _resourcesList[ComponentSetting.getUISourcePath("core")] = 3;
         _resourcesList[ComponentSetting.getUISourcePath("core2")] = 3;
         _resourcesList[ComponentSetting.getUISourcePath("common")] = 3;
         _resourcesList[ComponentSetting.ZhanPath] = 5;
         _resourcesList[ComponentSetting.AgentZhanPath] = 7;
         _resourcesList[PathManager.backAvatarList] = 5;
         _resourcesList[ComponentSetting.getUISourcePath("smallmap")] = 3;
         _resourcesList[ComponentSetting.getUISourcePath("resourcesbar")] = 3;
         _resourcesList[ComponentSetting.getUISourcePath("maintoolbar")] = 3;
         _resourcesList[ComponentSetting.getUISourcePath("taskextra")] = 3;
         _resourcesList[ComponentSetting.getUISourcePath("invite")] = 3;
         _resourcesList[ComponentSetting.getUISourcePath("tips")] = 3;
         _resourcesList[ComponentSetting.getUISourcePath("framebg")] = 3;
         _resourcesList[ComponentSetting.getUISourcePath("fairycommon")] = 3;
         if(noviceProcess < 19000)
         {
            _resourcesList[ComponentSetting.getProjectSourcePath("3.png")] = 3;
            _resourcesList[ComponentSetting.getUISourcePath("map")] = 3;
            _resourcesList[ComponentSetting.getProjectSourcePath("10.png")] = 3;
            _resourcesList[ComponentSetting.getUISourcePath("battle")] = 3;
            _resourcesList[PathManager.getBattleMapPath(14)] = 1;
         }
         if(noviceProcess < 99900)
         {
            _resourcesList[ComponentSetting.getProjectSourcePath("8.png")] = 3;
            _resourcesList[ComponentSetting.getUISourcePath("novice")] = 3;
            _resourcesList[ComponentSetting.newbieConfigPath] = DisplayLoader.isDebug ? 7 : 5;
         }
         if(noviceProcess < 11300)
         {
            _resourcesList[ComponentSetting.getUISourcePath("newguidestart")] = 3;
         }
         if(DisplayLoader.isDebug)
         {
            _resourcesList[ComponentSetting.LanguagePath] = 7;
         }
         else
         {
            _resourcesList[ComponentSetting.LanguagePath] = 5;
         }
         _resourcesList[ComponentSetting.templatePath] = 1;
         _resourcesList[ComponentSetting.newGuildHelpPath] = DisplayLoader.isDebug ? 7 : 5;
         _needLoadCount = getDicKeyNum(_resourcesList);
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["rnd"] = ComponentSetting.LOGIN_RND;
         for(var _loc1_:String in _resourcesList)
         {
            switch(_resourcesList[_loc1_])
            {
               case 5:
               case 8:
               case 7:
               case 1:
                  LoaderManagerII.instance.load(_loc1_,_resourcesList[_loc1_],8,onSingleLoadComplete,onResourcesLoadProgress,null,null,_loc2_);
                  break;
               default:
                  LoaderManagerII.instance.load(_loc1_,_resourcesList[_loc1_],8,onSingleLoadComplete,onResourcesLoadProgress);
            }
         }
      }
      
      private function onSingleLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         saveContentByURL(PathManager.versionPath,param1.url,param2,"xml");
         saveContentByURL(ComponentSetting.ZhanPath,param1.url,param2,"text");
         saveContentByURL(ComponentSetting.AgentZhanPath,param1.url,param2,"text");
         saveContentByURL(ComponentSetting.LanguagePath,param1.url,param2,"text");
         saveContentByURL(ComponentSetting.newbieConfigPath,param1.url,param2,"xml");
         saveContentByURL(PathManager.backAvatarList,param1.url,param2,"xml");
         saveContentByURL(ComponentSetting.templatePath,param1.url,param2,"byte");
         saveContentByURL(ComponentSetting.newGuildHelpPath,param1.url,param2,"xml");
         _curLoadCount = _curLoadCount + 1;
         if(_resourcesList[PathManager.versionPath] is XML)
         {
            BaseManager.instance.updateBroadcastContent = _resourcesList[PathManager.versionPath];
         }
         if(_curLoadCount >= _needLoadCount)
         {
            if(noviceProcess < 15000)
            {
               loadNewbieCampaign(10002,{
                  "row":6,
                  "column":11
               });
            }
            else
            {
               parseResources();
            }
         }
      }
      
      private function loadNewbieCampaign(param1:int, param2:Object = null) : void
      {
         _step = 3;
         var _loc3_:CampaignMapModel = new CampaignMapModel();
         _loc3_.mapId = param1;
         new PreRigeterCampaignData(_loc3_,onNewbieCampaignLoadProgress,false,false,param2).syncBackCall(parseResources);
      }
      
      private function parseResources() : void
      {
         var _loc1_:DataAnalyzer = null;
         _step = 4;
         updateProObj(0.3125,0.99,"Iniciando Jogo");
         ConfigManager.backAvatarLisr = _resourcesList[PathManager.backAvatarList];
         FilterWordManager.filterTrim = VersionSwitch.FILTER_TRIM;
         if(!FilterWordManager.hasSetup)
         {
            _loc1_ = new FilterWordAnalyzer(FilterWordManager.setup);
            _loc1_.analyze(_resourcesList[ComponentSetting.ZhanPath]);
         }
         if(!LanguageMgr.hasSetup)
         {
            _loc1_ = new LanguageAnalyzer(LanguageMgr.setup);
            _loc1_.analyze(_resourcesList[ComponentSetting.LanguagePath]);
         }
         if(!AgentFilterManager.hasSetup)
         {
            AgentFilterManager.Instance.setup(_resourcesList[ComponentSetting.AgentZhanPath]);
         }
         if(!NewGuildHelpManager.hasSetup)
         {
            NewGuildHelpManager.Instance.setup(_resourcesList[ComponentSetting.newGuildHelpPath]);
         }
         TemplateResolveQueue.step = noviceProcess >= 10000 ? 500 : 30;
         TempleteManager.instance.setup(_resourcesList[ComponentSetting.templatePath],onTemplateSetupComplete);
      }
      
      private function onTemplateSetupComplete() : void
      {
         TempleteManager.instance.initTemplate();
         reqLoginInitData();
      }
      
      public function get step() : int
      {
         return _step;
      }
      
      private function reqLoginInitData() : void
      {
         _step = 5;
         _loadIsCompleted = true;
         this.dispatchEvent(new StartupEvent("coreUILoadComplete"));
         if(_isPreload)
         {
            return;
         }
         SocketManager.instance.acceptData = true;
         GlobalConfig.isLoginMsg = true;
         new LoginInitDataAccept().losyBackCall(onLoginInitDataAcceptComplete);
      }
      
      private function onLoginInitDataAcceptComplete() : void
      {
         if(noviceProcess == 10000)
         {
            _userInfo["noviceProcess"] = 11000;
            PlayerManager.instance.sendSaveProcess(11000);
         }
         LoginInitDataAccept.loginOverRequest();
         dispatchEvent(new StartupEvent("coreSetupLoadComplete"));
         RightMenuUtils.setup();
         sendFlashPlayerVersion();
      }
      
      private function sendJumpNovice() : void
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.jumpNovice)
         {
            PlayerManager.instance.newbieProcess = 99900;
            SocketSendManager.instance.sendJumpNovice();
         }
      }
      
      private function saveContentByURL(param1:String, param2:String, param3:Object, param4:String) : void
      {
         var _loc5_:ByteArray = null;
         if(param2.indexOf(param1.toLowerCase()) >= 0)
         {
            switch(param4)
            {
               case "text":
                  _resourcesList[param1] = String(param3);
                  break;
               case "xml":
                  _resourcesList[param1] = XML(param3);
                  break;
               case "byte":
                  _loc5_ = param3 as ByteArray;
                  _loc5_.uncompress();
                  _resourcesList[param1] = ByteArray(param3);
                  break;
               default:
                  throw new Error("未定义此数据格式");
            }
         }
      }
      
      private function getDicKeyNum(param1:Dictionary) : int
      {
         var _loc2_:int = 0;
         for(var _loc3_:Object in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      private function sendFlashPlayerVersion() : void
      {
         var _loc4_:String = ComponentSetting.REQUEST_PATH + "flashversionservlet";
         var _loc6_:String = getNoStrVersion(Capabilities.version);
         var _loc1_:Array = _loc6_.split(",");
         ComponentSetting.useStage3D = VersionSwitch.STAGE3D;
         if(VersionSwitch.STAGE3D)
         {
            ComponentSetting.useStage3D = int(_loc1_[0]) >= 11 && int(_loc1_[1]) >= 4;
         }
         var _loc8_:Number = Capabilities.screenResolutionX;
         var _loc7_:Number = Capabilities.screenResolutionY;
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["v"] = _loc6_ + "|" + _loc8_ + "*" + _loc7_;
         var _loc5_:URLLoader = new URLLoader();
         _loc5_.addEventListener("complete",__onError);
         _loc5_.addEventListener("ioError",__onError);
         var _loc3_:URLRequest = new URLRequest(_loc4_);
         _loc3_.method = "POST";
         _loc3_.data = _loc2_;
         _loc5_.load(_loc3_);
      }
      
      private function __onError(param1:Event) : void
      {
         var _loc2_:URLLoader = param1.currentTarget as URLLoader;
         _loc2_.removeEventListener("complete",__onError);
         _loc2_.removeEventListener("ioError",__onError);
      }
      
      private function getNoStrVersion(param1:String) : String
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1.charAt(_loc2_);
            if(!StringUtil.isEnglish(_loc3_))
            {
               return StringUtil.ltrim(param1.substring(_loc2_,param1.length));
            }
            _loc2_++;
         }
         return param1;
      }
      
      private function get noviceProcess() : int
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.jumpNovice)
         {
            return 99900;
         }
         return _userInfo["noviceProcess"];
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function onResourcesLoadProgress(param1:LoaderInfo) : void
      {
         var _loc2_:Number = NaN;
         switch(_step - 1)
         {
            case 0:
               _loc2_ = param1.bytesLoaded / param1.bytesTotal;
               updateProObj(0.0625 + 0.0625 * _loc2_,_loc2_,"Carregando    " + ComponentSetting.getMD5FileNameByFilePath(param1.url));
               break;
            case 1:
               _loc2_ = _curLoadCount / _needLoadCount;
               updateProObj(0.125 + 0.1875 * _loc2_,_loc2_,"Carregando    " + ComponentSetting.getMD5FileNameByFilePath(param1.url));
         }
      }
      
      private function onNewbieCampaignLoadProgress(param1:Number) : void
      {
         updateProObj(0.3125 + 0.0625 * param1,param1,"Carregando    " + "Campanha Tutorial");
      }
      
      private function updateProObj(param1:Number = -1, param2:Number = -1, param3:String = null) : void
      {
         if(param1 >= 0)
         {
            _proObj["totalPro"] = param1 * 100;
         }
         if(param2 >= 0)
         {
            _proObj["subPro"] = param2;
         }
         if(param3 != null)
         {
            _proObj["subProName"] = param3;
         }
      }
      
      public function get proObj() : Object
      {
         return _proObj;
      }
      
      public function templateProgress() : Number
      {
         return TempleteManager.instance.progress;
      }
      
      public function dispose() : void
      {
         _userInfo = null;
         _config = null;
         _resourcesList = null;
         _proObj = null;
         _instance = null;
      }
   }
}

