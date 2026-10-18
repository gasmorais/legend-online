package archaeology
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import yishi.utils.MsgMan;
   import yishi.utils.WorldMapHelper;
   
   public class ArchaeologyWorldMapView extends Component
   {
      
      private var mapBack:Bitmap;
      
      private var _mapAreaContainer:MovieImage;
      
      public function ArchaeologyWorldMapView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         mapBack = ComponentFactory.Instance.creatBitmap("asset.ArchaeologyWorldMapView.mapBack");
         _mapAreaContainer = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyWorldMapView.MapAreaContainer");
         addChild(mapBack);
         addChild(_mapAreaContainer);
      }
      
      private function addEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            _mapAreaContainer.movie["map" + _loc1_].addEventListener("click",__mouseAreaClickHandler);
            _loc1_++;
         }
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         var _loc2_:SimpleButton = null;
         if(_mapAreaContainer)
         {
            _loc1_ = 0;
            while(_loc1_ < _mapAreaContainer.numChildren)
            {
               _loc2_ = _mapAreaContainer.getChildAt(_loc1_) as SimpleButton;
               if(_loc2_)
               {
                  _loc2_.removeEventListener("click",__mouseAreaClickHandler);
               }
               _loc1_++;
            }
         }
      }
      
      private function __mouseAreaClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:String = param1.currentTarget.name;
         var _loc3_:int = int(WorldMapHelper.tagNameToMapId(_loc4_));
         var _loc2_:Object = {};
         _loc2_.currentIndex = 2;
         _loc2_.mapSelect = _loc3_;
         MsgMan.notifyObserver("VIEW_CHANGE",_loc2_);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(mapBack)
         {
            ObjectUtils.disposeObject(mapBack);
         }
         mapBack = null;
         if(_mapAreaContainer)
         {
            ObjectUtils.disposeObject(_mapAreaContainer);
         }
         _mapAreaContainer = null;
         super.dispose();
      }
   }
}

