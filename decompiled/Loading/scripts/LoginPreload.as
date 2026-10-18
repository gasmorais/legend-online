package
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentSetting;
   import flash.events.Event;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   
   public class LoginPreload
   {
      
      private static var _config:XML;
      
      private static var _userInfo:Object;
      
      private static var _regLoadIsStarted:Boolean = false;
      
      private static var _regLoadIsCompleted:Boolean = false;
      
      private static var _norLoadIsStarted:Boolean = false;
      
      private static var _norLoadIsCompleted:Boolean = false;
      
      private static var _otherLoadIsStarted:Boolean = false;
      
      private static var _otherLoadIsCompleted:Boolean = false;
      
      private static var _onListLoadComplete:Function;
      
      private static var _curLoadCount:int = 0;
      
      private static var _needLoadCount:int = 0;
      
      public function LoginPreload()
      {
         super();
      }
      
      public static function setup(param1:XML, param2:Object) : void
      {
         _config = param1;
         _userInfo = param2;
      }
      
      public static function load(param1:Boolean = true) : void
      {
         if(param1)
         {
            new Md5Versions(loadFromRegister);
         }
         else
         {
            new Md5Versions(loadFromNormal);
         }
      }
      
      private static function loadFromRegister() : void
      {
         if(_regLoadIsStarted)
         {
            return;
         }
         _regLoadIsStarted = true;
         var _loc1_:Dictionary = new Dictionary(true);
         _loc1_[ComponentSetting.getUISourcePath("mainloadingii")] = 3;
         _loc1_[ComponentSetting.ZhanPath] = 5;
         _loc1_[ComponentSetting.AgentZhanPath] = 7;
         if(DisplayLoader.isDebug)
         {
            _loc1_[ComponentSetting.LanguagePath] = 7;
         }
         else
         {
            _loc1_[ComponentSetting.LanguagePath] = 5;
         }
         loadResources(_loc1_,onRegLoadComplete);
      }
      
      private static function onRegLoadComplete() : void
      {
         _regLoadIsCompleted = true;
         loadFromNormal();
      }
      
      private static function loadFromNormal() : void
      {
         if(_norLoadIsStarted)
         {
            return;
         }
         _norLoadIsStarted = true;
         var _loc1_:Dictionary = new Dictionary(true);
         _loc1_[ComponentSetting.getUIConfigZIPPath()] = 1;
         _loc1_[ComponentSetting.getProjectSourcePath("2.png")] = 3;
         loadResources(_loc1_,onNorLoadComplete,8);
      }
      
      private static function onNorLoadComplete() : void
      {
         var _loc1_:Class = DisplayLoader.Context.applicationDomain.getDefinition("yishi.lunch.ConfigParaser") as Class;
         if(!_loc1_.isInit)
         {
            _loc1_.paras(_config,StageReferance.stage.loaderInfo);
         }
         var _loc2_:Class = DisplayLoader.Context.applicationDomain.getDefinition("yishi.lunch.StartupResourcesLoader") as Class;
         _loc2_.instance.addEventListener("coreUILoadComplete",__startupResourcesLoadComplete);
         _loc2_.instance.start(_userInfo,_config,true);
      }
      
      private static function __startupResourcesLoadComplete(param1:Event) : void
      {
         if(param1 && param1.currentTarget)
         {
            param1.currentTarget.removeEventListener("coreUILoadComplete",__startupResourcesLoadComplete);
         }
         _norLoadIsCompleted = true;
         loadOthers();
      }
      
      private static function loadOthers() : void
      {
         if(_otherLoadIsStarted)
         {
            return;
         }
         _otherLoadIsStarted = true;
         var _loc2_:Class = DisplayLoader.Context.applicationDomain.getDefinition("yishi.datas.UIModuleTypes") as Class;
         var _loc1_:Dictionary = new Dictionary(true);
         loadResources(_loc1_,onOtherLoadComplete);
      }
      
      private static function onOtherLoadComplete() : void
      {
         _otherLoadIsCompleted = true;
         dispose();
      }
      
      private static function loadResources(param1:Dictionary, param2:Function = null, param3:int = 1) : void
      {
         _onListLoadComplete = param2;
         _curLoadCount = 0;
         _needLoadCount = getDicKeyNum(param1);
         if(_needLoadCount <= 0)
         {
            if(_onListLoadComplete != null)
            {
               _onListLoadComplete();
            }
            return;
         }
         var _loc5_:URLVariables = new URLVariables();
         _loc5_["rnd"] = ComponentSetting.LOGIN_RND;
         for(var _loc4_:String in param1)
         {
            switch(param1[_loc4_])
            {
               case 5:
               case 8:
               case 7:
                  LoaderManagerII.instance.load(_loc4_,param1[_loc4_],param3,onSingleLoadComplete,null,null,null,_loc5_);
                  break;
               default:
                  LoaderManagerII.instance.load(_loc4_,param1[_loc4_],param3,onSingleLoadComplete,null);
            }
         }
      }
      
      private static function onSingleLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         _curLoadCount = _curLoadCount + 1;
         if(_curLoadCount >= _needLoadCount)
         {
            if(_onListLoadComplete != null)
            {
               _onListLoadComplete();
            }
         }
      }
      
      private static function getDicKeyNum(param1:Dictionary) : int
      {
         var _loc2_:int = 0;
         for(var _loc3_:Object in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      public static function dispose() : void
      {
         _config = null;
         _userInfo = null;
         _onListLoadComplete = null;
      }
   }
}

