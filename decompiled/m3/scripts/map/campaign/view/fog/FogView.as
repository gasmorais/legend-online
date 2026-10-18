package map.campaign.view.fog
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.MapData;
   import yishi.scene.BaseSceneView;
   import yishi.utils.WorldBossHelper;
   
   public class FogView extends Sprite
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
      
      private var _isUpdatePos:Boolean;
      
      private var _isUpdateFog:Boolean;
      
      private var _model:CampaignMapModel;
      
      private var _displayRect:Rectangle = new Rectangle();
      
      private var _prePoint:Point = new Point();
      
      private var _curPoint:Point = new Point();
      
      private var drawCount:int;
      
      private var count:int;
      
      private var _pool:Array = [];
      
      public function FogView(param1:int, param2:int)
      {
         super();
         initBitmapContainer();
         _model = CampaignManager.instance.mapModel;
         _maskBitmapData = ComponentFactory.Instance.creatBitmapData("asset.campaign.FogMaskAsset");
         _mapWidth = param1;
         _mapHeight = param2;
         initMask(_mapWidth,_mapHeight);
         addEventListener("addedToStage",__addToStageHandler);
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         _model.addEventListener("SYS_FOG_DATA",__sysFogDataHandler);
         _model.addEventListener("LOCAL_UPDATE_FOG",__updateFogDataHandler,false,10);
         _model.addEventListener("SYN_FOG_DATA",__synFogHandler);
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      public static function sloveFogPoint(param1:int, param2:int) : Point
      {
         var _loc3_:Point = null;
         _loc3_ = new Point(param1 + 55,param2 + 43);
         var _loc6_:int = _loc3_.y % 86;
         var _loc4_:int = (_loc3_.y - _loc6_) / 86 % 2;
         if(_loc4_ != 0)
         {
            _loc3_.x -= 110 / 2;
         }
         _loc3_.y -= _loc6_;
         var _loc5_:int = _loc3_.x % 110;
         _loc3_.x -= _loc5_;
         return _loc3_;
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         _isUpdatePos = _isUpdateFog = true;
         upDateNextRend();
      }
      
      private function __sysFogDataHandler(param1:CampaignMapEvent) : void
      {
         if(WorldBossHelper.checkFogMap(CampaignManager.instance.mapModel.mapId))
         {
            return;
         }
         var _loc2_:Array = CampaignManager.instance.mapModel.fogData;
         if(_loc2_)
         {
            initView(_loc2_);
         }
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         __sysFogDataHandler(null);
      }
      
      private function initBitmapContainer() : void
      {
         var _loc1_:int = int(CampaignManager.instance.mapModel.mapTempInfo.Width);
         var _loc3_:int = int(CampaignManager.instance.mapModel.mapTempInfo.Height);
         if(_loc1_ <= 0 || _loc3_ <= 0)
         {
            return;
         }
         var _loc2_:BitmapData = MapData.fogBitmapDataCache;
         if(!_loc2_ || _loc2_.width != _loc1_ || _loc2_.height != _loc3_)
         {
            if(_loc2_)
            {
               _loc2_.dispose();
            }
            MapData.fogBitmapDataCache = null;
            _loc2_ = new BitmapData(_loc1_,_loc3_,true,0);
            MapData.fogBitmapDataCache = _loc2_;
         }
         _bitmapContainer = new Bitmap(_loc2_);
         addChild(_bitmapContainer);
         _bitmapContainer.scrollRect = null;
         _bitmapContainer.filters = null;
         _isUpdatePos = _isUpdateFog = true;
         upDateNextRend();
      }
      
      public function addSceneChild(param1:BaseSceneView) : void
      {
      }
      
      public function updateContainerPosX() : void
      {
         _curPoint.x = -CampaignManager.instance.mapView.x - 110;
         var _loc1_:int = 96;
         if(Point.distance(_curPoint,_prePoint) > _loc1_)
         {
            _isUpdatePos = _isUpdateFog = true;
            _prePoint.x = _curPoint.x;
            _prePoint.y = _curPoint.y;
            upDateNextRend();
         }
      }
      
      public function updateContainerPosY() : void
      {
         _curPoint.y = -CampaignManager.instance.mapView.y - 110;
         var _loc1_:int = 96;
         if(Point.distance(_curPoint,_prePoint) > _loc1_)
         {
            _isUpdatePos = _isUpdateFog = true;
            _prePoint.x = _curPoint.x;
            _prePoint.y = _curPoint.y;
            upDateNextRend();
         }
      }
      
      private function upDateNextRend() : void
      {
         if(stage)
         {
            stage.invalidate();
            addEventListener("render",__onScreenRend);
         }
      }
      
      private function __onScreenRend(param1:Event) : void
      {
         removeEventListener("render",__onScreenRend);
         if(_isUpdateFog)
         {
            draw();
         }
         _isUpdateFog = false;
      }
      
      private function draw() : void
      {
         var _loc7_:int = -CampaignManager.instance.mapView.x;
         var _loc9_:int = -CampaignManager.instance.mapView.y;
         var _loc4_:int = int(CampaignManager.instance.mapModel.mapTempInfo.Width);
         var _loc5_:int = int(CampaignManager.instance.mapModel.mapTempInfo.Height);
         _displayRect.x = _loc7_ - 110;
         _displayRect.y = _loc9_ - 110;
         _displayRect.width = _loc4_ + 110;
         _displayRect.height = _loc5_ + 110;
         _bitmapContainer.bitmapData.lock();
         _bitmapContainer.bitmapData.fillRect(_displayRect,0);
         _displayRect.x = _displayRect.y = 0;
         _displayRect.width = _maskBitmapData.width;
         _displayRect.height = _maskBitmapData.height;
         var _loc8_:int = _loc7_ - _displayRect.width;
         var _loc6_:int = _loc9_ - _displayRect.height;
         var _loc3_:int = _loc7_ + StageReferance.stageWidth + 110;
         var _loc2_:int = _loc9_ + StageReferance.stageHeight + 110;
         for each(var _loc1_:Point in _maskDict)
         {
            if(!(_loc1_.x < _loc8_ || _loc1_.y < _loc6_ || _loc1_.x > _loc3_ || _loc1_.y > _loc2_))
            {
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
         _isUpdatePos = _isUpdateFog = true;
         upDateNextRend();
      }
      
      public function checkFogEmpty(param1:int, param2:int) : Boolean
      {
         var _loc3_:Point = sloveFogPoint(param1,param2);
         var _loc4_:Point = _maskDict[_loc3_.x + "_" + _loc3_.y] as Point;
         _loc3_ = null;
         return Boolean(_loc4_);
      }
      
      private function __updateFogDataHandler(param1:CampaignMapEvent) : void
      {
         if(WorldBossHelper.checkMapId(CampaignManager.instance.mapModel.mapId))
         {
            return;
         }
         var _loc2_:Object = param1.data;
         updatePosImp(new Point(_loc2_.x,_loc2_.y),_loc2_.vy,_loc2_.type);
      }
      
      private function __synFogHandler(param1:CampaignMapEvent) : void
      {
         if(WorldBossHelper.checkFogMap(CampaignManager.instance.mapModel.mapId))
         {
            return;
         }
         var _loc2_:Object = param1.data;
         updatePos(_loc2_.y * 110,_loc2_.x * 86,_loc2_.type);
      }
      
      private function updatePos(param1:int, param2:int, param3:int) : void
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
         if(_loc3_)
         {
            _isUpdateFog = true;
            clearPoint(_loc3_);
            upDateNextRend();
         }
      }
      
      private function initView(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = param1[_loc3_];
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               if(_loc2_[_loc4_] > 0)
               {
                  updatePos(_loc4_ * 110,_loc3_ * 86,_loc2_[_loc4_]);
               }
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      private function createBitmap(param1:Point) : void
      {
         var _loc2_:Bitmap = null;
         if(param1)
         {
            _loc2_ = effectBitmap;
            _loc2_.x = param1.x;
            _loc2_.y = param1.y;
            _loc2_.alpha = 1;
            addChild(_loc2_);
            createBitmapEffect(_loc2_);
         }
         param1 = null;
      }
      
      private function get effectBitmap() : Bitmap
      {
         var _loc1_:Bitmap = _pool.pop();
         if(!_loc1_)
         {
            _loc1_ = new Bitmap(_maskBitmapData);
         }
         return _loc1_;
      }
      
      private function createBitmapEffect(param1:Bitmap) : void
      {
         if(param1)
         {
            TweenMax.to(param1,0.2,{
               "alpha":0,
               "onComplete":addBitmapPool,
               "onCompleteParams":[param1]
            });
         }
      }
      
      private function addBitmapPool(param1:Bitmap) : void
      {
         param1.x = param1.y = 0;
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         _pool.push(param1);
      }
      
      private function clearPoint(param1:Point) : void
      {
         createBitmap(param1);
         param1 = null;
      }
      
      public function getPointEnable(param1:Point) : Boolean
      {
         return true;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("render",__onScreenRend);
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         removeEventListener("addedToStage",__addToStageHandler);
         _model.removeEventListener("SYS_FOG_DATA",__sysFogDataHandler);
         _model.removeEventListener("LOCAL_UPDATE_FOG",__updateFogDataHandler);
         _model.removeEventListener("SYN_FOG_DATA",__synFogHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_maskBitmapData)
         {
            _maskBitmapData.dispose();
         }
         _maskBitmapData = null;
         for each(var _loc1_:Bitmap in _pool)
         {
            if(_loc1_)
            {
               if(_loc1_.parent)
               {
                  _loc1_.parent.removeChild(_loc1_);
               }
            }
            _loc1_ = null;
         }
         _maskDict = null;
         if(_bitmapContainer)
         {
            _bitmapContainer.bitmapData = null;
            if(_bitmapContainer.parent)
            {
               _bitmapContainer.parent.removeChild(_bitmapContainer);
            }
         }
         _bitmapContainer = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

