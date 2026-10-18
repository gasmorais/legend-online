package outyard
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import mvc.module.outyard.AreaPoint;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   
   public class AreaNodeView extends Component
   {
      
      protected var _info:AreaPoint;
      
      private var _url:String;
      
      private var _areaNodeBg:Bitmap;
      
      private var _movieContainer:Component;
      
      protected var _movie:MovieClip;
      
      public function AreaNodeView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _areaNodeBg = ComponentFactory.Instance.creatBitmap("asset.outyard.areaNodeBg");
         _movieContainer = new Component();
         addChild(_areaNodeBg);
         addChild(_movieContainer);
         _movieContainer.y = -5;
         this.tipStyle = "yishi.view.tips.OutyardAreaEventTips";
         this.isFollowMouse = false;
         this.tipDirctions = "7,5,4,6";
         this.tipGapH = 50;
         this.tipGapV = 10;
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("UPDATE_AREA_TRIGGER",__updateTriggerHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("UPDATE_AREA_TRIGGER",__updateTriggerHandler);
      }
      
      public function set info(param1:AreaPoint) : void
      {
         if(!_info)
         {
         }
         _info = param1;
         if(_info.eventId && !_info.triggered)
         {
            setSwf();
            this.tipData = _info;
         }
         if(!_info)
         {
         }
      }
      
      private function __updateTriggerHandler(param1:NotificationEvent) : void
      {
         var _loc2_:AreaPoint = param1.data as AreaPoint;
         if(_loc2_.id == _info.id)
         {
            removeNetMovieClip();
            this.tipData = null;
         }
      }
      
      protected function setSwf() : void
      {
         var _loc1_:String = PathManager.info.ResourcePath + _info.url;
         if(!_loc1_)
         {
            return;
         }
         if(_loc1_ == _url)
         {
            _url = _loc1_;
            addNetMovieClip(null,_movie);
            return;
         }
         _url = _loc1_;
         LoaderManagerII.instance.load(_loc1_,2,5,addNetMovieClip,null,null,_info.url);
      }
      
      protected function addNetMovieClip(param1:LoaderInfo, param2:Object) : void
      {
         if(param2 != _movie)
         {
            removeNetMovieClip();
         }
         if(!param2)
         {
            return;
         }
         _movie = param2 as MovieClip;
         _movie.mouseChildren = _movie.mouseEnabled = true;
         _movieContainer.addChild(_movie);
      }
      
      private function removeNetMovieClip() : void
      {
         if(_movie)
         {
            _movie.stop();
            if(_movie.parent)
            {
               _movie.parent.removeChild(_movie);
            }
            if(_movie.loaderInfo)
            {
               _movie.loaderInfo.loader.unload();
               _movie.loaderInfo.loader.unloadAndStop(true);
            }
            ObjectUtils.disposeViolentMc(_movie);
         }
         _movie = null;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(addNetMovieClip);
         ObjectUtils.disposeObject(_areaNodeBg);
         _areaNodeBg = null;
         ObjectUtils.disposeObject(_movieContainer);
         _movieContainer = null;
         ObjectUtils.disposeViolentMc(_movie);
         _movie = null;
         _info = null;
         _url = null;
         super.dispose();
      }
   }
}

