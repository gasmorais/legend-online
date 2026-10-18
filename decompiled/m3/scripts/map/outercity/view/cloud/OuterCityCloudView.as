package map.outercity.view.cloud
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import map.internals.event.OuterCityEvent;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.view.OuterCityMap;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class OuterCityCloudView extends Sprite implements Disposeable, IEnterFrame
   {
      
      private var _cloudBitmapI:MovieClip;
      
      private var _cloudBitmapII:MovieClip;
      
      private var _cloudPoint:Point = new Point();
      
      private var _cloudPointII:Point = new Point();
      
      private var _clouds:Array;
      
      private var curMapPos:Point = new Point();
      
      private var curBitPos:Point = new Point();
      
      public function OuterCityCloudView()
      {
         super();
         initBitmaps();
         _cloudBitmapI = _clouds[0];
         _cloudBitmapII = _clouds[1];
         this.mouseChildren = this.mouseEnabled = false;
         this.addEventListener("addedToStage",__addToStageHanlder);
      }
      
      private function initBitmaps() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _clouds = [];
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("asset.outercity.CloundAsset");
            _loc2_.y = 500;
            _loc2_.cacheAsBitmap = true;
            _loc2_.mouseChildren = _loc2_.mouseEnabled = false;
            _clouds.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function __addToStageHanlder(param1:Event) : void
      {
         addEvent();
         __dragSceneEndHandler(null);
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         mapView.addEventListener("DRAG_SCENE_END",__dragSceneEndHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         this.removeEventListener("addedToStage",__addToStageHanlder);
         mapView.removeEventListener("DRAG_SCENE_END",__dragSceneEndHandler);
      }
      
      private function __dragSceneEndHandler(param1:OuterCityEvent) : void
      {
         curMapPos.x = StageReferance.stageWidth / 2 - mapView.x;
         curMapPos.y = StageReferance.stageHeight / 2 - mapView.y;
         moveBitmap(_cloudBitmapI,new Point(_cloudBitmapI.x,_cloudBitmapI.y));
         moveBitmap(_cloudBitmapII,new Point(_cloudBitmapII.x,_cloudBitmapII.y));
      }
      
      private function moveBitmap(param1:MovieClip, param2:Point) : void
      {
         var _loc4_:int = 0;
         var _loc3_:MovieClip = null;
         curBitPos.x = param2.x;
         curBitPos.y = param2.y;
         if(Point.distance(curMapPos,curBitPos) > StageReferance.stageWidth + 200)
         {
            if(param2.x > -mapView.x)
            {
               param2.x = -Math.random() * 1500 - mapView.x;
            }
            else
            {
               param2.x = StageReferance.stageWidth - mapView.x + Math.random() * 1500;
            }
            param2.y = 100 + Math.random() * StageReferance.stageHeight - mapView.y;
            if(param1 && param1.parent)
            {
               param1.parent.removeChild(param1);
            }
            _loc4_ = _clouds.length * Math.random();
            _loc3_ = _clouds[_loc4_];
            while(_loc3_ == _cloudBitmapI || _loc3_ == _cloudBitmapII)
            {
               _loc4_ = _clouds.length * Math.random();
               _loc3_ = _clouds[_loc4_];
            }
            if(param1 == _cloudBitmapI)
            {
               _cloudPoint.x = param2.x;
               _cloudPoint.y = param2.y;
            }
            else
            {
               _cloudPointII.x = param2.x;
               _cloudPointII.y = param2.y;
            }
         }
      }
      
      private function get mapView() : OuterCityMap
      {
         return OuterCityManager.instance.mapView;
      }
      
      public function enterFrame() : void
      {
         _cloudPoint.x += 1;
         _cloudPointII.x += 1;
         var _loc3_:int = StageReferance.stageWidth + _cloudBitmapI.width;
         var _loc4_:int = StageReferance.stageHeight + _cloudBitmapI.height;
         var _loc1_:int = _cloudPoint.x - curMapPos.x + StageReferance.stageWidth / 2;
         var _loc2_:int = _cloudPoint.y - curMapPos.y + StageReferance.stageHeight / 2;
         if(_loc1_ < -_cloudBitmapI.width || _loc1_ > _loc3_ || _loc2_ < -_cloudBitmapI.height || _loc2_ > _loc4_)
         {
            if(_cloudBitmapI.parent)
            {
               _cloudBitmapI.parent.removeChild(_cloudBitmapI);
            }
         }
         else
         {
            _cloudBitmapI.x = _cloudPoint.x;
            _cloudBitmapI.y = _cloudPoint.y;
            if(!_cloudBitmapI.parent)
            {
               addChild(_cloudBitmapI);
            }
         }
         _loc1_ = _cloudPointII.x - curMapPos.x + StageReferance.stageWidth / 2;
         _loc2_ = _cloudPointII.y - curMapPos.y + StageReferance.stageHeight / 2;
         if(_loc1_ < -_cloudBitmapII.width || _loc1_ > _loc3_ || _loc2_ < -_cloudBitmapII.height || _loc2_ > _loc4_)
         {
            if(_cloudBitmapII.parent)
            {
               _cloudBitmapII.parent.removeChild(_cloudBitmapII);
            }
         }
         else
         {
            _cloudBitmapII.x = _cloudPointII.x;
            _cloudBitmapII.y = _cloudPointII.y;
            if(!_cloudBitmapII.parent)
            {
               addChild(_cloudBitmapII);
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_cloudBitmapI)
         {
            _cloudBitmapI.stop();
            if(_cloudBitmapI.parent)
            {
               _cloudBitmapI.parent.removeChild(_cloudBitmapI);
            }
         }
         _cloudBitmapI = null;
         if(_cloudBitmapII)
         {
            _cloudBitmapII.stop();
            if(_cloudBitmapII.parent)
            {
               _cloudBitmapII.parent.removeChild(_cloudBitmapII);
            }
         }
         _cloudBitmapII = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

