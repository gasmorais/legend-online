package childnswar.item
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import managers.ChildNswarManager;
   import mvc.module.childnswar.ChildNswarModel;
   import yishi.manager.PathManager;
   
   public class ChildNswarAvatarLoader extends Sprite
   {
      
      private var _loader:Loader;
      
      private var _body:MovieClip;
      
      private var _childJob:int;
      
      private var _childGrade:int;
      
      public function ChildNswarAvatarLoader()
      {
         super();
      }
      
      private function get model() : ChildNswarModel
      {
         return ChildNswarManager.Instance.model;
      }
      
      public function refresh(param1:int, param2:int) : void
      {
         var _loc3_:String = null;
         _childJob = param1;
         _childGrade = param2;
         clearBody();
         _body = ComponentFactory.Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
         setBodyProperty();
         var _loc4_:Class = model.avatarPoolDic[_childJob + "_" + _childGrade] as Class;
         if(!_loc4_)
         {
            _loc3_ = PathManager.solveChildAvatarPath(_childJob,_childGrade);
            LoaderManagerII.instance.load(_loc3_,1,8,__loadedCompleteHandler);
         }
         else
         {
            createBody();
         }
      }
      
      private function __loadedCompleteHandler(param1:com.pickgliss.loader.data.LoaderInfo, param2:Object) : void
      {
         var _loc3_:ApplicationDomain = null;
         var _loc4_:LoaderContext = null;
         clearBody();
         if(param2)
         {
            _loc3_ = new ApplicationDomain(ApplicationDomain.currentDomain);
            _loc4_ = new LoaderContext(false,_loc3_);
            disposeLoader();
            _loader = new Loader();
            _loader.contentLoaderInfo.addEventListener("complete",__complete);
            _loader.loadBytes(param2 as ByteArray,_loc4_);
         }
      }
      
      private function disposeLoader() : void
      {
         if(_loader)
         {
            _loader.contentLoaderInfo.removeEventListener("complete",__complete);
            _loader.unloadAndStop(false);
            _loader = null;
         }
      }
      
      private function createBody() : void
      {
         if(_childJob == 0)
         {
            return;
         }
         clearBody();
         var _loc1_:Class = model.avatarPoolDic[_childJob + "_" + _childGrade] as Class;
         if(_loc1_)
         {
            _body = new _loc1_();
            setBodyProperty();
            addChild(_body);
         }
      }
      
      private function __complete(param1:Event) : void
      {
         var _loc2_:flash.display.LoaderInfo = param1.currentTarget as flash.display.LoaderInfo;
         _loc2_.removeEventListener("complete",__complete);
         var _loc3_:Class = model.avatarPoolDic[_childJob + "_" + _childGrade] as Class;
         if(!_loc3_ && _loc2_.applicationDomain.hasDefinition("ClassExport"))
         {
            _loc3_ = _loc2_.applicationDomain.getDefinition("ClassExport") as Class;
            model.avatarPoolDic[_childJob + "_" + _childGrade] = _loc3_;
         }
         createBody();
         _loader.unloadAndStop(false);
         _loader = null;
      }
      
      private function setBodyProperty() : void
      {
         _body.mouseChildren = _body.mouseEnabled = false;
         _body.scaleX = _body.scaleY = 0.8;
      }
      
      public function clean() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadedCompleteHandler);
         clearBody();
      }
      
      private function clearBody() : void
      {
         ObjectUtils.disposeViolentMc(_body);
         _body = null;
      }
      
      public function dispose() : void
      {
         disposeLoader();
         clean();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

