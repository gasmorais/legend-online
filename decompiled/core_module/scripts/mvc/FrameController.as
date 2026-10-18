package mvc
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import ui.maintoolbar.MainToolBar;
   import yishi.manager.FrameControllerManager;
   import yishi.view.community.LoadingSceneView;
   
   public class FrameController
   {
      
      protected var _frame:Frame;
      
      protected var _data:ModuleFrameInfo;
      
      protected var _preModule:String;
      
      protected var _preOpenType:String;
      
      protected var _preData:Object;
      
      protected var _loadedCount:int;
      
      protected var _uiProgress:int = 99;
      
      protected var _libraryProgress:int = 0;
      
      protected var _extraProgress:int = 0;
      
      private var _progressDic:Dictionary = new Dictionary(true);
      
      protected var _isLoadingLock:Boolean;
      
      protected var _isClosed:Boolean;
      
      protected var _exitFrameName:String;
      
      public function FrameController()
      {
         super();
      }
      
      public function setPreFrame(param1:String, param2:String = null, param3:Object = null) : void
      {
         _preModule = param1;
         _preOpenType = param2;
         _preData = param3;
      }
      
      public function start(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.clearGameMenuLayer();
         _progressDic = new Dictionary();
         _data = param1;
         _isClosed = false;
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.FrameController.vModule");
         var _loc3_:String = LanguageMgr.GetTranslation("yishi.FrameController.vHasError");
         if(preLoad)
         {
            if(!_isLoadingLock)
            {
               _isLoadingLock = true;
               LoadingSceneView.instance.show(true,__loadCloseHandler);
            }
            startPreLoad();
         }
         else if(!param1.isComplete)
         {
            if(_loadedCount > 4)
            {
               LoadingSceneView.instance.hide();
               throw new Error(_loc2_ + param1.moduleUIName + _loc3_);
            }
            if(!_isLoadingLock)
            {
               _isLoadingLock = true;
               LoadingSceneView.instance.show(true,__loadCloseHandler);
            }
            moduleLoader();
         }
         else
         {
            createFrame();
         }
      }
      
      private function __loadCloseHandler() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(completeHandler);
         _isLoadingLock = false;
         _isClosed = true;
         _data.currentLoaded = 0;
      }
      
      private function moduleLoader() : void
      {
         var _loc2_:String = null;
         for each(var _loc1_:String in _data.needLoadArr)
         {
            _loc2_ = ComponentSetting.getMD5FileNameByFilePath(_loc1_);
            _progressDic[_loc2_] = 0;
            LoaderManagerII.instance.load(_loc1_,3,0,completeHandler,progressHandler,null,_data);
         }
      }
      
      private function progressHandler(param1:LoaderInfo) : void
      {
         var _loc5_:Number = param1.bytesLoaded / param1.bytesTotal;
         var _loc3_:String = ComponentSetting.getMD5FileNameByFilePath(param1.url);
         _progressDic[_loc3_] = _loc5_;
         var _loc4_:Number = 0;
         for each(var _loc2_:Number in _progressDic)
         {
            _loc4_ += _loc2_;
         }
         LoadingSceneView.instance.update(int(_loc4_ / _data.needLoadArr.length * 100));
      }
      
      private function completeHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(_isClosed)
         {
            return;
         }
         param1.args.currentLoaded++;
         if(param1.args.currentLoaded >= param1.args.needLoadArr.length)
         {
            _data.isComplete = true;
            LoadingSceneView.instance.update(100);
            start(_data);
         }
      }
      
      protected function createFrame() : void
      {
         var _loc1_:String = frameClassName;
         LayerManager.Instance.clickPos = MainToolBar.instance.getBtnPos(_loc1_);
         _frame = ComponentFactory.Instance.createComponentGroupByStylename(_loc1_,true);
         if(_frame)
         {
            if(!_frame.isDie)
            {
               showFrame();
            }
            else
            {
               _frame = null;
            }
         }
         if(_isLoadingLock)
         {
            LoadingSceneView.instance.hide();
         }
         _isLoadingLock = false;
      }
      
      protected function get preLoad() : Boolean
      {
         return false;
      }
      
      protected function startPreLoad() : void
      {
         start(_data);
      }
      
      protected function showFrame() : void
      {
         _loadedCount = 0;
         _frame.addEventListener("dispose",__disposeHandler);
         _frame.addEventListener("GROUP_CONFLICT",__groupExistHandler);
      }
      
      protected function doShowCallBack() : void
      {
         if(_data && _data.callBack != null)
         {
            _data.callBack();
            _data.callBack = null;
         }
      }
      
      private function __disposeHandler(param1:Event) : void
      {
         var _loc2_:Frame = param1.currentTarget as Frame;
         if(_loc2_)
         {
            _exitFrameName = _loc2_.stylename;
            _loc2_.removeEventListener("dispose",__disposeHandler);
            _loc2_.removeEventListener("GROUP_CONFLICT",__groupExistHandler);
            if(_frame)
            {
               if(_loc2_ == _frame)
               {
                  exitFrame();
               }
            }
            else
            {
               exitFrame();
            }
         }
      }
      
      protected function __groupExistHandler(param1:ComponentEvent) : void
      {
         if(_frame == param1.currentTarget)
         {
            _preModule = null;
         }
         _preData = null;
      }
      
      protected function exitFrame() : void
      {
         _frame = null;
         if(_preModule)
         {
            openPreFrame();
         }
         _preModule = null;
         _preOpenType = null;
         _preData = null;
         _exitFrameName = null;
      }
      
      protected function openPreFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo(_preModule,_preOpenType,_preData);
      }
      
      public function get frameClassName() : String
      {
         var _loc1_:String = LanguageMgr.GetTranslation("yishi.FrameController.vModuleMainFunction");
         throw new Error(_loc1_);
      }
   }
}

