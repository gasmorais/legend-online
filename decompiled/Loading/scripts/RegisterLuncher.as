package
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.FilterWordAnalyzer;
   import com.pickgliss.loader.LanguageAnalyzer;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.NamesLibAnalyzer;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.display.Stage;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import loading.MaxLoadingII;
   import loading.RegisterLoading;
   import loading.SmallLoading;
   import manager.AgentFilterManager;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import manager.NamesLibManager;
   import register.MainFigureView;
   
   public class RegisterLuncher
   {
      
      public static const UIMODULE_NAME:String = "mainloadingii";
      
      public static const FORMAT_TEXT:String = "text";
      
      public static const FORMAT_XML:String = "xml";
      
      private var _showLoadingTimerId:uint;
      
      private var _loadingView:*;
      
      private var _backShape:Shape;
      
      private var _selectRoleView:MainFigureView;
      
      private var _stage:Stage;
      
      private var _config:XML;
      
      private var _userInfo:Object;
      
      private var _callback:Function;
      
      private var _resourcesList:Dictionary;
      
      private var _curLoadCount:int = 0;
      
      private var _needLoadCount:int = 0;
      
      public function RegisterLuncher()
      {
         super();
      }
      
      public function lunch(param1:XML, param2:Object, param3:Stage, param4:Boolean = false, param5:Function = null) : void
      {
         _stage = param3;
         _config = param1;
         _userInfo = param2;
         _callback = param5;
         _resourcesList = new Dictionary(true);
         if(param4)
         {
            _loadingView = RegisterLoading.instance;
            _showLoadingTimerId = setTimeout(_loadingView.show,1500);
         }
         else
         {
            _loadingView = SmallLoading.Instance;
         }
         loadResources();
      }
      
      private function loadResources() : void
      {
         _resourcesList[ComponentSetting.getUISourcePath("mainloadingii")] = 3;
         _resourcesList[ComponentSetting.ZhanPath] = 5;
         _resourcesList[ComponentSetting.AgentZhanPath] = 7;
         if(DisplayLoader.isDebug)
         {
            _resourcesList[ComponentSetting.LanguagePath] = 7;
            _resourcesList[ComponentSetting.NamesLibPath] = 7;
         }
         else
         {
            _resourcesList[ComponentSetting.LanguagePath] = 5;
            _resourcesList[ComponentSetting.NamesLibPath] = 5;
         }
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
                  LoaderManagerII.instance.load(_loc1_,_resourcesList[_loc1_],8,onSingleLoadComplete,onRegisterLoadProgress,null,null,_loc2_);
                  break;
               default:
                  LoaderManagerII.instance.load(_loc1_,_resourcesList[_loc1_],8,onSingleLoadComplete,onRegisterLoadProgress);
            }
         }
      }
      
      private function onSingleLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         saveContentByURL(ComponentSetting.ZhanPath,param1.url,param2,"text");
         saveContentByURL(ComponentSetting.AgentZhanPath,param1.url,param2,"text");
         saveContentByURL(ComponentSetting.LanguagePath,param1.url,param2,"text");
         saveContentByURL(ComponentSetting.NamesLibPath,param1.url,param2,"text");
         _curLoadCount = _curLoadCount + 1;
         if(_curLoadCount >= _needLoadCount)
         {
            clearTimeout(_showLoadingTimerId);
            parseResources();
         }
      }
      
      private function parseResources() : void
      {
         var _loc1_:DataAnalyzer = null;
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
         if(!NamesLibManager.hasSetup)
         {
            _loc1_ = new NamesLibAnalyzer(NamesLibManager.setup);
            _loc1_.analyze(_resourcesList[ComponentSetting.NamesLibPath]);
         }
         ComponentFactory.Instance.setup(new RegisterUIConfig().getXML());
         _loadingView.exit(showRegisterView);
      }
      
      private function saveContentByURL(param1:String, param2:String, param3:Object, param4:String) : void
      {
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
               default:
                  throw new Error("Formato dos dados não definido");
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
      
      private function onRegisterLoadProgress(param1:LoaderInfo) : void
      {
         var _loc2_:Number = param1.bytesLoaded / param1.bytesTotal * (_curLoadCount / _needLoadCount);
         _loadingView.progress = int(50 + _loc2_ * 50);
      }
      
      private function showRegisterView(param1:Object = null) : void
      {
         _backShape = new Shape();
         _selectRoleView = new MainFigureView(_userInfo,lunchMaxLoadingII);
         _backShape.graphics.beginFill(0,1);
         _backShape.graphics.drawRect(0,0,2400,1800);
         _backShape.graphics.endFill();
         LayerManager.Instance.addToLayer(_backShape,0,true,true);
         LayerManager.Instance.addToLayer(_selectRoleView,0,true,true,0,0,true);
         LoginPreload.load(false);
      }
      
      private function lunchMaxLoadingII() : void
      {
         var _loc2_:MaxLoadingII = MaxLoadingII.Instance;
         _loc2_.show(_selectRoleView);
         var _loc1_:NormalLuncher = new NormalLuncher();
         _loc1_.lunch(_config,_userInfo,_stage,_loc2_,unload);
      }
      
      public function unload() : void
      {
         clearTimeout(_showLoadingTimerId);
         ObjectUtils.disposeObject(_backShape);
         _backShape = null;
         if(_selectRoleView)
         {
            _selectRoleView.dispose();
         }
         _selectRoleView = null;
         _loadingView = null;
         _stage = null;
         _config = null;
         _userInfo = null;
         _resourcesList = null;
         if(_callback != null)
         {
            _callback();
            _callback = null;
         }
      }
   }
}

