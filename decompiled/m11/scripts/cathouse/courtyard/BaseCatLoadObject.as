package cathouse.courtyard
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import yishi.datas.templates.CatHouseTemplateInfo;
   
   public class BaseCatLoadObject extends Sprite
   {
      
      protected var _templateInfo:CatHouseTemplateInfo;
      
      protected var _isLoading:Boolean = false;
      
      protected var _loading:MovieClip;
      
      protected var _curLoadedDisplayObject:DisplayObject;
      
      protected var _loadedCallbackFun:Function;
      
      public function BaseCatLoadObject()
      {
         super();
      }
      
      public function get isLoading() : Boolean
      {
         return _isLoading;
      }
      
      public function set isLoading(param1:Boolean) : void
      {
         _isLoading = param1;
      }
      
      public function get templateInfo() : CatHouseTemplateInfo
      {
         return _templateInfo;
      }
      
      public function set templateInfo(param1:CatHouseTemplateInfo) : void
      {
         throw new Error("must be override");
      }
      
      public function set loadedCallbackFun(param1:Function) : void
      {
         _loadedCallbackFun = param1;
      }
      
      override public function get width() : Number
      {
         return _curLoadedDisplayObject == null ? 50 : _curLoadedDisplayObject.width;
      }
      
      override public function get height() : Number
      {
         return _curLoadedDisplayObject == null ? 50 : _curLoadedDisplayObject.height;
      }
      
      protected function toLoadAvatar(param1:String) : void
      {
         clear();
         LoaderManagerII.instance.load(param1,2,4,onLoadCompleteHandler);
         _isLoading = true;
         if(_loading == null)
         {
            _loading = ComponentFactory.Instance.creat("asset.core.IconLoading");
         }
         addChild(_loading);
         _loading.visible = true;
         _loading.gotoAndPlay(1);
      }
      
      protected function onLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         _isLoading = false;
         clearAvatar();
         _curLoadedDisplayObject = param2 as DisplayObject;
         if(_curLoadedDisplayObject != null)
         {
            addChild(_curLoadedDisplayObject);
            if(_loadedCallbackFun != null)
            {
               _loadedCallbackFun(this);
            }
            ObjectUtils.disposeObject(_loading);
            _loading = null;
            _loadedCallbackFun = null;
         }
      }
      
      private function clearLoader() : void
      {
         if(_isLoading)
         {
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onLoadCompleteHandler);
            _isLoading = false;
         }
      }
      
      public function clearAvatar() : void
      {
         if(_curLoadedDisplayObject != null)
         {
            ObjectUtils.disposeViolentMc(MovieClip(_curLoadedDisplayObject));
            _curLoadedDisplayObject = null;
         }
      }
      
      private function clearLoadingMC() : void
      {
         if(_loading != null)
         {
            _loading.stop();
            _loading.visible = false;
            if(_loading.parent != null)
            {
               _loading.parent.removeChild(_loading);
            }
         }
         _loading = null;
      }
      
      public function clear() : void
      {
         _loadedCallbackFun = null;
         clearLoader();
         clearAvatar();
         clearLoadingMC();
      }
      
      public function dispose() : void
      {
         _loadedCallbackFun = null;
         clearLoader();
         clearAvatar();
         ObjectUtils.disposeViolentMc(_loading);
         _loading = null;
         _templateInfo = null;
      }
   }
}

