package loading
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class MaxLoadingII extends Sprite
   {
      
      private static var _instance:MaxLoadingII;
      
      private var _loadingMc:MovieClip;
      
      private var _container:DisplayObjectContainer;
      
      private var _currProgress:int;
      
      private var _preProgress:int = -1;
      
      private var _count:int;
      
      private var _pro:int;
      
      public function MaxLoadingII()
      {
         super();
         init();
      }
      
      public static function get Instance() : MaxLoadingII
      {
         if(_instance == null)
         {
            _instance = new MaxLoadingII();
         }
         return _instance;
      }
      
      private function init() : void
      {
         var _loc1_:String = null;
         if(!ModuleLoader.hasDefinition("asset.loading.MainLoadingAssetII"))
         {
            _loc1_ = ComponentSetting.getUISourcePath("mainloadingii");
            LoaderManagerII.instance.load(_loc1_,3,8,__loadingCompleteHandler);
         }
         else
         {
            createLoadingMc();
         }
      }
      
      private function __loadingCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         createLoadingMc();
         show(_container);
      }
      
      private function createLoadingMc() : void
      {
         var _loc1_:Class = ModuleLoader.getDefinition("asset.loading.MainLoadingAssetII") as Class;
         _loadingMc = new _loc1_() as MovieClip;
         _loadingMc.loadPro.selectable = false;
         _loadingMc.loadPro.mouseEnabled = false;
         _loadingMc.loadPro.mouseWheelEnabled = false;
         _loadingMc.childLoadPro.selectable = false;
         _loadingMc.childLoadPro.mouseEnabled = false;
         _loadingMc.childLoadPro.mouseWheelEnabled = false;
         try
         {
            _loadingMc.notice.visible = false;
         }
         catch(e:Error)
         {
         }
         setProgress(1);
         setItemLoaderInfo(0,"");
      }
      
      public function show(param1:DisplayObjectContainer) : void
      {
         _container = param1;
         if(!ModuleLoader.hasDefinition("asset.loading.MainLoadingAssetII"))
         {
            return;
         }
         _loadingMc.x = 200;
         _loadingMc.y = 110;
         _container.addChild(_loadingMc);
      }
      
      public function setProgress(param1:int) : void
      {
         if(!_loadingMc)
         {
            return;
         }
         _pro = param1;
         _loadingMc.progressBarMc.pro.gotoAndStop(_pro);
         _loadingMc.loadPro.text = "Progresso Total   " + _pro + "%";
      }
      
      public function setItemLoaderInfo(param1:Number, param2:String) : void
      {
         if(!_loadingMc)
         {
            return;
         }
         var _loc3_:int = param1 * 100;
         _loadingMc.childProgressBarMc.pro.gotoAndStop(_loc3_);
         if(param2)
         {
            _loadingMc.childLoadPro.text = param2 + "     Progresso" + _loc3_ + "%";
         }
         else
         {
            _loadingMc.childLoadPro.text = "     Progresso" + _loc3_ + "%";
         }
      }
      
      public function hide() : void
      {
         _currProgress = 1;
         ObjectUtils.disposeViolentMc(_loadingMc);
         _loadingMc = null;
         _container = null;
         _instance = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

