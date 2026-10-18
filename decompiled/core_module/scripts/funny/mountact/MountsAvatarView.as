package funny.mountact
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.core.Component;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import yishi.datas.templates.MountTemplate;
   import yishi.utils.MountAvatarPathHelper;
   
   public class MountsAvatarView extends Component
   {
      
      private var _mountMovieClip:MovieClip;
      
      private var _isLoading:Boolean;
      
      private var _data:MountTemplate;
      
      public function MountsAvatarView()
      {
         super();
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      public function get data() : MountTemplate
      {
         return _data;
      }
      
      public function set data(param1:MountTemplate) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         if(_isLoading)
         {
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onLoaded);
            _isLoading = false;
         }
         if(!_data)
         {
            return;
         }
         _isLoading = true;
         var _loc2_:String = MountAvatarPathHelper.getUrl(param1.AvatarPath);
         LoaderManagerII.instance.load(_loc2_,2,4,__onLoaded);
      }
      
      private function __onLoaded(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:BitmapData = null;
         var _loc3_:Rectangle = null;
         _isLoading = false;
         if(isDie)
         {
            return;
         }
         if(_mountMovieClip)
         {
            _mountMovieClip.stop();
            _mountMovieClip.parent && _mountMovieClip.parent.removeChild(_mountMovieClip);
         }
         _mountMovieClip = param2 as MovieClip;
         if(!_mountMovieClip)
         {
            return;
         }
         _mountMovieClip.gotoAndStop(1);
         this.addChild(_mountMovieClip);
         if(_mountMovieClip["pos_down"])
         {
            _mountMovieClip.x = -_mountMovieClip["pos_down"].x;
            _mountMovieClip.y = -_mountMovieClip["pos_down"].y;
         }
         else
         {
            _loc4_ = new BitmapData(500,500,true,0);
            _loc4_.draw(_mountMovieClip);
            _loc3_ = _loc4_.getColorBoundsRect(4278190080,0,false);
            _mountMovieClip.x = -_loc3_.width / 2 - _loc3_.x;
            _mountMovieClip.y = -_loc3_.height / 2 - _loc3_.y;
            _loc4_.dispose();
            _loc4_ = null;
         }
         _mountMovieClip.play();
      }
      
      override public function dispose() : void
      {
         if(_isLoading)
         {
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onLoaded);
            _isLoading = false;
         }
         _data = null;
         _mountMovieClip = null;
         super.dispose();
      }
   }
}

