package fish.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import managers.FishManager;
   import mvc.module.fish.FishModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   
   public class FishSigleView extends Sprite implements Disposeable
   {
      
      private var _fishMc:MovieClip;
      
      private var _loader:Loader;
      
      private var _path:String;
      
      private var _point:Boolean;
      
      private var _applicationDomain:ApplicationDomain;
      
      public function FishSigleView()
      {
         super();
         _applicationDomain = FishModel.loaderContext.applicationDomain;
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener("complete",__completeHandler);
      }
      
      public function get path() : String
      {
         return _path;
      }
      
      public function set path(param1:String) : void
      {
         var _loc3_:String = null;
         if(_path == param1)
         {
            return;
         }
         _path = param1;
         var _loc2_:String = "Fish" + fishURL;
         if(_applicationDomain.hasDefinition(_loc2_))
         {
            clean();
            creatFish();
            return;
         }
         if(model.classDic[path])
         {
            _path = "";
            return;
         }
         _loc3_ = PathManager.getFishSwfPath(path);
         model.classDic[path] = path;
         LoaderManagerII.instance.load(_loc3_,1,8,__onComplete);
      }
      
      private function __onComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(!_loader)
         {
            return;
         }
         _loader.loadBytes(param2 as ByteArray,FishModel.loaderContext);
      }
      
      public function get point() : Boolean
      {
         return _point;
      }
      
      public function set point(param1:Boolean) : void
      {
         if(_point == param1)
         {
            return;
         }
         _point = param1;
         if(_fishMc)
         {
            if(_point)
            {
               _fishMc.scaleX = -1;
            }
            else
            {
               _fishMc.scaleX = 1;
            }
         }
      }
      
      private function get fishURL() : String
      {
         var _loc1_:* = null;
         if(path.indexOf("_") > 0)
         {
            return path.substr(path.indexOf("_") + 1);
         }
         return null;
      }
      
      protected function clean() : void
      {
         if(_fishMc)
         {
            _fishMc.stop();
            _fishMc.parent.removeChild(_fishMc);
         }
         _fishMc = null;
      }
      
      private function __completeHandler(param1:Event) : void
      {
         clean();
         creatFish();
         if(_loader == null)
         {
            return;
         }
         _loader.contentLoaderInfo.removeEventListener("complete",__completeHandler);
         _loader.unloadAndStop(true);
         _loader = null;
      }
      
      private function creatFish() : void
      {
         var _loc2_:Class = null;
         var _loc1_:String = "Fish" + fishURL;
         if(_applicationDomain.hasDefinition(_loc1_))
         {
            _loc2_ = _applicationDomain.getDefinition(_loc1_) as Class;
            _fishMc = new _loc2_();
            _fishMc.gotoAndPlay("normal");
            if(point)
            {
               _fishMc.scaleX = -1;
            }
            else
            {
               _fishMc.scaleX = 1;
            }
            addChild(_fishMc);
         }
      }
      
      private function get playermodel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get model() : FishModel
      {
         return FishManager.instance.model;
      }
      
      public function get fishMc() : MovieClip
      {
         return _fishMc;
      }
      
      public function dispose() : void
      {
         if(_fishMc)
         {
            _fishMc.stop();
         }
         ObjectUtils.disposeObject(_fishMc);
         _fishMc = null;
         ObjectUtils.disposeObject(_loader);
         _loader = null;
      }
   }
}

