package avatar.load
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import yishi.utils.StringHelper;
   
   public class ShowAvatarLoader extends Sprite implements Disposeable
   {
      
      protected var _contain:MovieClip;
      
      protected var _path:String;
      
      protected var _view:MovieClip;
      
      protected var _loadComplete:Function;
      
      private var _count:int;
      
      public var first:Boolean;
      
      public function ShowAvatarLoader(param1:Function)
      {
         super();
         _loadComplete = param1;
         initContain();
      }
      
      protected function initContain() : void
      {
         _contain = new MovieClip();
         addChild(_contain);
      }
      
      protected function clean() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__iconLoadComplete);
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
         LoaderManagerII.instance.load(_path,2,8,__iconLoadComplete,null,null,_path);
      }
      
      private function removeChilder(param1:Sprite) : void
      {
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
      }
      
      protected function __iconLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(_path != param1.args || !_contain)
         {
            return;
         }
         clean();
         removeChilder(_contain);
         if(param2 is MovieClip)
         {
            _view = param2 as MovieClip;
            _contain.addChild(_view);
            if(_loadComplete != null)
            {
               _loadComplete();
            }
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
         ObjectUtils.disposeViolentMc(_view);
         ObjectUtils.disposeViolentMc(_contain);
         _contain = null;
         clean();
         _loadComplete = null;
      }
   }
}

