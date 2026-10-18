package avatar.view
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import yishi.datas.templates.PetTemplate;
   import yishi.utils.StringHelper;
   
   public class ShowPetAvatar extends Sprite implements Disposeable
   {
      
      protected var _contain:MovieClip;
      
      private var _path:String;
      
      private var _loader:Loader;
      
      protected var _view:MovieClip;
      
      protected var _loadComplete:Function;
      
      protected var _context:LoaderContext;
      
      private var _count:int;
      
      public var petTemplate:PetTemplate;
      
      public var first:Boolean;
      
      public var headPosY:int = -110;
      
      public function ShowPetAvatar(param1:Function)
      {
         super();
         _loadComplete = param1;
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener("complete",__completeHandler);
         initContain();
      }
      
      protected function initContain() : void
      {
         _contain = new MovieClip();
         addChild(_contain);
      }
      
      protected function clean() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadContentComplete);
         if(_view && _view.parent)
         {
            _view.stop();
            _view.parent.removeChild(_view);
         }
         _view = null;
      }
      
      public function initPath(param1:String) : void
      {
         _path = param1;
         if(StringHelper.isNullOrEmpty(_path))
         {
            clean();
            return;
         }
         _count = _count + 1;
         LoaderManagerII.instance.load(url,1,8,__loadContentComplete);
      }
      
      private function removeChilder(param1:Sprite) : void
      {
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
      }
      
      protected function __loadContentComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(!_loader)
         {
            return;
         }
         var _loc3_:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
         _context = new LoaderContext(false,_loc3_);
         if(DisplayLoader.isDebug)
         {
            _context.allowCodeImport = true;
         }
         _loader.loadBytes(param2 as ByteArray,_context);
      }
      
      protected function __completeHandler(param1:Event) : void
      {
         var _loc5_:Class = null;
         var _loc2_:Rectangle = null;
         clean();
         if(!_contain)
         {
            return;
         }
         var _loc3_:ApplicationDomain = _context.applicationDomain;
         var _loc4_:String = "ClassExport";
         if(_loc3_.hasDefinition(_loc4_))
         {
            _loc5_ = _loc3_.getDefinition(_loc4_) as Class;
            _view = new _loc5_();
            _view.gotoAndPlay("Stand");
            if(_view.hasOwnProperty("pos_head"))
            {
               headPosY = _view["pos_head"].y - 20;
            }
            else
            {
               headPosY = -110;
            }
            if(petTemplate && petTemplate.Property1 == 1)
            {
               _loc2_ = _view.getBounds(_view);
               _view.x = -_loc2_.x - _loc2_.width / 2;
            }
            _contain.addChild(_view);
         }
         if(_loadComplete != null)
         {
            _loadComplete();
         }
      }
      
      public function gotoAndPlay(param1:int) : void
      {
         if(_view)
         {
            _view.gotoAndPlay(param1);
         }
      }
      
      public function get content() : MovieClip
      {
         return _view;
      }
      
      public function get url() : String
      {
         return _path;
      }
      
      public function dispose() : void
      {
         if(_loader)
         {
            _loader.contentLoaderInfo.removeEventListener("complete",__completeHandler);
            _loader.unloadAndStop(false);
         }
         ObjectUtils.disposeViolentMc(_contain);
         _contain = null;
         ObjectUtils.disposeViolentMc(_view);
         _view = null;
         clean();
         _context = null;
         _loader = null;
         _loadComplete = null;
      }
   }
}

