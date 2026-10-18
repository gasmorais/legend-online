package views
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import map.outercity.manager.OuterCityManager;
   
   public class NoviceFogView extends Sprite
   {
      
      public static const unitWidth:int = 110;
      
      public static const unitHeight:int = 86;
      
      public static const off:int = 110;
      
      private var _bitWidth:int;
      
      private var _bitHeight:int;
      
      private var _mapWidth:int;
      
      private var _mapHeight:int;
      
      private var _maskContainer:Sprite;
      
      private var _maskDict:Dictionary = new Dictionary(true);
      
      private var _maskBitmapData:BitmapData;
      
      private var _bitmapContainer:Bitmap;
      
      private var _displayRect:Rectangle = new Rectangle();
      
      private var _prePoint:Point = new Point();
      
      private var _curPoint:Point = new Point();
      
      public function NoviceFogView(param1:int, param2:int)
      {
         super();
         initBitmapContainer();
         _maskBitmapData = ComponentFactory.Instance.creatBitmapData("asset.campaign.FogMaskAsset");
         initMask(param1,param2);
         this.addEventListener("addedToStage",__addToStageHandler);
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         this.scrollRect = null;
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         upDateNextRend();
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         upDateNextRend();
      }
      
      private function initBitmapContainer() : void
      {
         var _loc1_:int = int(OuterCityManager.instance.mapView.width);
         var _loc2_:int = int(OuterCityManager.instance.mapView.height);
         if(_loc1_ <= 0 || _loc2_ <= 0)
         {
            return;
         }
         _bitmapContainer = new Bitmap(new BitmapData(_loc1_,_loc2_,true,0));
         addChild(_bitmapContainer);
         _bitmapContainer.scrollRect = null;
         _bitmapContainer.filters = null;
         upDateNextRend();
      }
      
      private function upDateNextRend() : void
      {
         if(this.parent)
         {
            draw();
         }
      }
      
      private function draw() : void
      {
         var _loc6_:int = 0;
         var _loc8_:int = -OuterCityManager.instance.mapView.x;
         var _loc10_:int = -OuterCityManager.instance.mapView.y;
         var _loc4_:int = int(OuterCityManager.instance.model.mapTempInfo.Width);
         var _loc5_:int = int(OuterCityManager.instance.model.mapTempInfo.Height);
         _displayRect.x = _loc8_ - 110;
         _displayRect.y = _loc10_ - 110;
         _displayRect.width = _loc4_ + 110;
         _displayRect.height = _loc5_ + 110;
         _bitmapContainer.bitmapData.lock();
         _bitmapContainer.bitmapData.fillRect(_displayRect,0);
         _displayRect.x = _displayRect.y = 0;
         _displayRect.width = _maskBitmapData.width;
         _displayRect.height = _maskBitmapData.height;
         var _loc9_:int = _loc8_ - _displayRect.width;
         var _loc7_:int = _loc10_ - _displayRect.height;
         var _loc3_:int = _loc8_ + StageReferance.stageWidth + 110;
         var _loc2_:int = _loc10_ + StageReferance.stageHeight + 110;
         for each(var _loc1_:Point in _maskDict)
         {
            if(!(_loc1_.x < _loc9_ || _loc1_.y < _loc7_ || _loc1_.x > _loc3_ || _loc1_.y > _loc2_))
            {
               _loc6_++;
               _bitmapContainer.bitmapData.copyPixels(_maskBitmapData,_displayRect,_loc1_,null,null,true);
            }
         }
         _bitmapContainer.bitmapData.unlock();
      }
      
      private function initMask(param1:int, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Point = null;
         _loc5_ = -110;
         while(_loc5_ < param1 + 110)
         {
            _loc4_ = 0;
            _loc6_ = -86;
            while(_loc6_ < param2 + 86)
            {
               _loc4_++;
               _loc3_ = new Point();
               _maskDict[_loc5_ + "_" + _loc6_] = _loc3_;
               if(_loc4_ % 2 == 0)
               {
                  _loc3_.x = _loc5_;
               }
               else
               {
                  _loc3_.x = _loc5_ + 110 / 2;
               }
               _loc3_.y = _loc6_;
               _loc3_.x -= _maskBitmapData.width / 2;
               _loc3_.y -= _maskBitmapData.height / 2;
               _loc6_ += 86;
            }
            _loc5_ += 110;
         }
         upDateNextRend();
      }
      
      public function updatePos(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:Point = null;
         _loc4_ = new Point(param1 + 55,param2 + 43);
         var _loc7_:int = _loc4_.y % 86;
         var _loc5_:int = (_loc4_.y - _loc7_) / 86 % 2;
         if(_loc5_ != 0)
         {
            _loc4_.x -= 110 / 2;
         }
         _loc4_.y -= _loc7_;
         var _loc6_:int = _loc4_.x % 110;
         _loc4_.x -= _loc6_;
         updatePosImp(_loc4_,_loc5_,param3);
         upDateNextRend();
      }
      
      private function updatePosImp(param1:Point, param2:int, param3:int) : void
      {
         removeByKey(new Point(param1.x,param1.y));
         if(param3 >= 2)
         {
            removeByKey(new Point(param1.x - 110,param1.y));
            removeByKey(new Point(param1.x + 110,param1.y));
            removeByKey(new Point(param1.x - 110 * 2,param1.y));
            removeByKey(new Point(param1.x + 110 * 2,param1.y));
            removeByKey(new Point(param1.x + 110,param1.y - 86 * 2));
            removeByKey(new Point(param1.x,param1.y - 86 * 2));
            removeByKey(new Point(param1.x - 110,param1.y - 86 * 2));
            removeByKey(new Point(param1.x + 110,param1.y + 86 * 2));
            removeByKey(new Point(param1.x,param1.y + 86 * 2));
            removeByKey(new Point(param1.x - 110,param1.y + 86 * 2));
         }
         if(param3 >= 3)
         {
            removeByKey(new Point(param1.x - 110 * 3,param1.y));
            removeByKey(new Point(param1.x + 110 * 3,param1.y));
            removeByKey(new Point(param1.x + 110,param1.y - 86 * 3));
            removeByKey(new Point(param1.x,param1.y - 86 * 3));
            removeByKey(new Point(param1.x - 110,param1.y - 86 * 3));
            removeByKey(new Point(param1.x + 2 * 110,param1.y - 86 * 2));
            removeByKey(new Point(param1.x - 2 * 110,param1.y - 86 * 2));
            removeByKey(new Point(param1.x + 2 * 110,param1.y + 86 * 2));
            removeByKey(new Point(param1.x - 2 * 110,param1.y + 86 * 2));
            removeByKey(new Point(param1.x + 110,param1.y + 86 * 3));
            removeByKey(new Point(param1.x,param1.y + 86 * 3));
            removeByKey(new Point(param1.x - 110,param1.y + 86 * 3));
         }
         if(param3 >= 4)
         {
            removeByKey(new Point(param1.x - 110 * 4,param1.y));
            removeByKey(new Point(param1.x + 110 * 4,param1.y));
            removeByKey(new Point(param1.x,param1.y - 86 * 4));
            removeByKey(new Point(param1.x,param1.y + 86 * 4));
            removeByKey(new Point(param1.x - 110,param1.y - 86 * 4));
            removeByKey(new Point(param1.x - 110,param1.y + 86 * 4));
            removeByKey(new Point(param1.x + 110,param1.y - 86 * 4));
            removeByKey(new Point(param1.x + 110,param1.y + 86 * 4));
            removeByKey(new Point(param1.x - 110 * 2,param1.y - 86 * 4));
            removeByKey(new Point(param1.x - 110 * 2,param1.y + 86 * 4));
            removeByKey(new Point(param1.x + 110 * 2,param1.y - 86 * 4));
            removeByKey(new Point(param1.x + 110 * 2,param1.y + 86 * 4));
            removeByKey(new Point(param1.x - 110 * 3,param1.y - 86 * 2));
            removeByKey(new Point(param1.x - 110 * 3,param1.y + 86 * 2));
            removeByKey(new Point(param1.x + 110 * 3,param1.y - 86 * 2));
            removeByKey(new Point(param1.x + 110 * 3,param1.y + 86 * 2));
         }
         if(param2 == 0)
         {
            removeByKey(new Point(param1.x,param1.y - 86));
            removeByKey(new Point(param1.x - 110,param1.y - 86));
            removeByKey(new Point(param1.x,param1.y + 86));
            removeByKey(new Point(param1.x - 110,param1.y + 86));
            if(param3 >= 2)
            {
               removeByKey(new Point(param1.x - 110 * 2,param1.y - 86));
               removeByKey(new Point(param1.x + 110,param1.y - 86));
               removeByKey(new Point(param1.x - 110 * 2,param1.y + 86));
               removeByKey(new Point(param1.x + 110,param1.y + 86));
            }
            if(param3 >= 3)
            {
               removeByKey(new Point(param1.x - 2 * 110,param1.y - 86 * 3));
               removeByKey(new Point(param1.x + 2 * 110,param1.y - 86));
               removeByKey(new Point(param1.x - 3 * 110,param1.y - 86));
               removeByKey(new Point(param1.x + 2 * 110,param1.y + 86));
               removeByKey(new Point(param1.x - 3 * 110,param1.y + 86));
               removeByKey(new Point(param1.x - 2 * 110,param1.y + 86 * 3));
            }
            if(param3 >= 4)
            {
               removeByKey(new Point(param1.x - 4 * 110,param1.y - 86));
               removeByKey(new Point(param1.x - 4 * 110,param1.y + 86));
               removeByKey(new Point(param1.x + 3 * 110,param1.y - 86));
               removeByKey(new Point(param1.x + 3 * 110,param1.y + 86));
               removeByKey(new Point(param1.x - 3 * 110,param1.y - 86 * 3));
               removeByKey(new Point(param1.x - 3 * 110,param1.y + 86 * 3));
               removeByKey(new Point(param1.x + 2 * 110,param1.y - 86 * 3));
               removeByKey(new Point(param1.x + 2 * 110,param1.y + 86 * 3));
            }
         }
         else
         {
            removeByKey(new Point(param1.x,param1.y - 86));
            removeByKey(new Point(param1.x + 110,param1.y - 86));
            removeByKey(new Point(param1.x,param1.y + 86));
            removeByKey(new Point(param1.x + 110,param1.y + 86));
            if(param3 >= 2)
            {
               removeByKey(new Point(param1.x - 110,param1.y - 86));
               removeByKey(new Point(param1.x + 110 * 2,param1.y - 86));
               removeByKey(new Point(param1.x - 110,param1.y + 86));
               removeByKey(new Point(param1.x + 110 * 2,param1.y + 86));
            }
            if(param3 >= 3)
            {
               removeByKey(new Point(param1.x + 2 * 110,param1.y - 86 * 3));
               removeByKey(new Point(param1.x - 2 * 110,param1.y - 86));
               removeByKey(new Point(param1.x + 3 * 110,param1.y - 86));
               removeByKey(new Point(param1.x - 2 * 110,param1.y + 86));
               removeByKey(new Point(param1.x + 3 * 110,param1.y + 86));
               removeByKey(new Point(param1.x + 2 * 110,param1.y + 86 * 3));
            }
            if(param3 >= 4)
            {
               removeByKey(new Point(param1.x - 3 * 110,param1.y - 86));
               removeByKey(new Point(param1.x - 3 * 110,param1.y + 86));
               removeByKey(new Point(param1.x + 4 * 110,param1.y - 86));
               removeByKey(new Point(param1.x + 4 * 110,param1.y + 86));
               removeByKey(new Point(param1.x - 2 * 110,param1.y - 86 * 3));
               removeByKey(new Point(param1.x - 2 * 110,param1.y + 86 * 3));
               removeByKey(new Point(param1.x + 3 * 110,param1.y - 86 * 3));
               removeByKey(new Point(param1.x + 3 * 110,param1.y + 86 * 3));
            }
         }
      }
      
      private function removeByKey(param1:Point) : void
      {
         var _loc2_:String = param1.x + "_" + param1.y;
         var _loc3_:Point = _maskDict[_loc2_] as Point;
         delete _maskDict[_loc2_];
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         this.removeEventListener("addedToStage",__addToStageHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_maskBitmapData)
         {
            _maskBitmapData.dispose();
         }
         _maskBitmapData = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

