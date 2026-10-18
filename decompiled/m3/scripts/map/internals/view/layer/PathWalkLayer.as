package map.internals.view.layer
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import events.ObjectsEvent;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.event.OuterCityEvent;
   import map.space.SpaceManager;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.scene.SceneManager;
   import yishi.utils.StringHelper;
   
   public class PathWalkLayer extends Sprite
   {
      
      public static var self:PathWalkLayer;
      
      private var selfColor:uint = 16711935;
      
      private var targetColor:uint = 16711680;
      
      private var pathColor:uint = 16711680;
      
      private var mapModel:*;
      
      private var tilesData:Object;
      
      private var selfView:Shape;
      
      private var controller:*;
      
      private var armyView:Object;
      
      private var targetView:Shape;
      
      private var pointShape:Shape;
      
      private var footmarkShape:Shape;
      
      private var posText:FilterFrameText;
      
      private var timeId:int;
      
      private var _shape:Shape;
      
      private var _path:Shape;
      
      private var idd:int;
      
      private var _selfData:*;
      
      public function PathWalkLayer()
      {
         PathWalkLayer.self = this;
         super();
         idd = setTimeout(init,1000);
      }
      
      private function init() : void
      {
         clearTimeout(idd);
         idd = 0;
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            controller = CampaignManager.instance.controller as CampaignMapController;
            mapModel = CampaignManager.instance.mapModel;
            tilesData = mapModel.mapTielsData;
            if(!mapModel.selfMemberData)
            {
               mapModel.addEventListener("addGarrison",__addPlayerHandler);
            }
            else
            {
               timeId = setTimeout(drawSelf,2000);
            }
         }
         else
         {
            controller = SpaceManager.instance.controller;
            mapModel = SpaceManager.instance.model;
            tilesData = mapModel.mapTielsData;
            if(!mapModel.selfArmy)
            {
               mapModel.addEventListener("addGarrison",__addPlayerHandler);
            }
            else
            {
               timeId = setTimeout(drawSelf,2000);
            }
         }
         footmarkShape = new Shape();
         _shape = new Shape();
         _shape.cacheAsBitmap = true;
         selfView = new Shape();
         selfView.graphics.beginFill(selfColor,1);
         selfView.graphics.lineStyle(1,0,0.5);
         selfView.graphics.drawRect(0,0,20,20);
         selfView.graphics.endFill();
         targetView = new Shape();
         targetView.graphics.beginFill(targetColor);
         targetView.graphics.lineStyle(1,0,0.5);
         targetView.graphics.drawRect(0,0,20,20);
         targetView.graphics.endFill();
         pointShape = new Shape();
         pointShape.graphics.beginFill(65535);
         pointShape.graphics.drawCircle(0,0,2);
         pointShape.graphics.endFill();
         _path = new Shape();
         addChild(_shape);
         addChild(footmarkShape);
         addChild(targetView);
         addChild(selfView);
         addChild(pointShape);
         addChild(_path);
         posText = ComponentFactory.Instance.creatComponentByStylename("pet.PowerTxt");
         addChild(posText);
         mapModel.addEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
         mouseEnabled = mouseChildren = false;
         drawTilesData();
      }
      
      public function drawTilesData(param1:Boolean = false) : void
      {
         var _loc8_:String = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc3_:int = mapModel.mapTempInfo.Width / 20;
         var _loc4_:int = mapModel.mapTempInfo.Height / 20;
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc6_ = _loc2_ + "_" + _loc5_;
                  if(!(_loc6_ in tilesData))
                  {
                     tilesData[_loc6_] = 10000;
                  }
                  _loc5_++;
               }
               _loc2_++;
            }
         }
         else
         {
            for(_loc8_ in tilesData)
            {
               if(tilesData[_loc8_] == 10000)
               {
                  delete tilesData[_loc8_];
               }
            }
         }
         _shape.graphics.clear();
         _shape.graphics.lineStyle(1,0,0.5);
         for(_loc8_ in tilesData)
         {
            if(tilesData[_loc8_] == 10000)
            {
               _shape.graphics.beginFill(16777215,0);
            }
            else
            {
               _shape.graphics.beginFill(10066329,0.5);
            }
            _loc7_ = _loc8_.split("_");
            _shape.graphics.drawRect(int(_loc7_[0]) * 20,int(_loc7_[1]) * 20,20,20);
         }
         _shape.graphics.endFill();
      }
      
      private function __addPlayerHandler(param1:OuterCityEvent) : void
      {
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            if(!mapModel.selfMemberData)
            {
               return;
            }
         }
         else if(!mapModel.selfArmy)
         {
            return;
         }
         mapModel.removeEventListener("addGarrison",__addPlayerHandler);
         timeId = setTimeout(drawSelf,2000);
      }
      
      private function drawSelf() : void
      {
         clearTimeout(timeId);
         timeId = 0;
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _selfData = mapModel.selfMemberData;
         }
         else
         {
            _selfData = mapModel.selfArmy;
         }
         armyView = controller.getArmyView(_selfData);
         armyView.aiInfo.addEventListener("updatePaths",__walkOverHandler);
         selfView.x = int(armyView.x / 20) * 20;
         selfView.y = int(armyView.y / 20) * 20;
         addEventListener("enterFrame",enterFrame);
      }
      
      private function enterFrame(param1:Event) : void
      {
         if(pointShape.x != armyView.x || pointShape.y != armyView.y)
         {
            _path.graphics.lineStyle(1,0);
            _path.graphics.drawCircle(armyView.x,armyView.y,2);
         }
         pointShape.x = armyView.x;
         pointShape.y = armyView.y;
         var _loc2_:Number = int(armyView.x / 20) * 20;
         var _loc3_:Number = int(armyView.y / 20) * 20;
         if(_loc2_ != selfView.x || _loc3_ != selfView.y)
         {
            footmarkShape.graphics.beginFill(10092390);
            footmarkShape.graphics.lineStyle(1,0);
            footmarkShape.graphics.drawRect(selfView.x,selfView.y,20,20);
            footmarkShape.graphics.endFill();
            selfView.x = _loc2_;
            selfView.y = _loc3_;
         }
         posText.text = StringHelper.format("({0},{1})",int(mouseX / 20),int(mouseY / 20));
         posText.x = mouseX + 20;
         posText.y = mouseY + 20;
      }
      
      private function __walkNextHandler(param1:ObjectsEvent) : void
      {
      }
      
      private function __walkOverHandler(param1:Event) : void
      {
         footmarkShape.graphics.clear();
         _path.graphics.clear();
         var _loc2_:Array = (param1.currentTarget as AIBaseInfo).pathInfo;
         drawLine(getStraightLine(_loc2_));
      }
      
      private function __updateWalkTargetHandler(param1:CampaignMapEvent) : void
      {
         var _loc2_:Point = param1.data as Point;
         if(_loc2_)
         {
            targetView.x = int(_loc2_.x / 20) * 20;
            targetView.y = int(_loc2_.y / 20) * 20;
         }
      }
      
      public function drawLine(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Point = null;
         _path.graphics.lineStyle(1,16711680);
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = (param1[_loc3_] as Point).clone();
            _loc2_.x = _loc2_.x * 20 + 10;
            _loc2_.y = _loc2_.y * 20 + 10;
            if(_loc3_ == 0)
            {
               _path.graphics.moveTo(_loc2_.x,_loc2_.y);
            }
            else
            {
               _path.graphics.lineTo(_loc2_.x,_loc2_.y);
            }
            _loc3_++;
         }
      }
      
      private function getStraightLine(param1:Array) : Array
      {
         var _loc7_:Point = null;
         var _loc2_:Point = null;
         var _loc3_:Array = null;
         var _loc5_:int = getTimer();
         if(param1.length <= 1)
         {
            return param1;
         }
         var _loc4_:int = int(param1.length);
         var _loc8_:int = 0;
         var _loc9_:int = _loc4_ - 1;
         var _loc6_:Array = [];
         while(_loc8_ != _loc9_)
         {
            _loc7_ = param1[_loc8_];
            _loc2_ = param1[_loc9_];
            _loc3_ = findPoints(_loc7_,_loc2_);
            if(_loc3_)
            {
               _loc6_.push(param1[_loc8_]);
               _loc8_ = _loc9_;
               _loc9_ = _loc4_ - 1;
            }
            else
            {
               _loc9_ = (_loc9_ + _loc8_) / 2;
            }
         }
         _loc6_.push(param1[_loc8_]);
         return _loc6_;
      }
      
      private function findPoints(param1:Point, param2:Point) : Array
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:Number = NaN;
         var _loc8_:int = 0;
         var _loc3_:Array = [];
         if(param1.x == param2.x)
         {
            _loc5_ = Math.max(param1.y,param2.y);
            _loc7_ = _loc4_ = Math.min(param1.y,param2.y);
            while(_loc7_ < _loc5_)
            {
               if(!mapModel.getWalkable(param1.x,_loc7_))
               {
                  return null;
               }
               _loc3_.push(new Point(param1.x,_loc7_));
               _loc7_++;
            }
         }
         else
         {
            _loc9_ = (param2.y - param1.y) / (param2.x - param1.x);
            if(Math.abs(param2.x - param1.x) < Math.abs(param2.y - param1.y))
            {
               _loc8_ = param2.y > param1.y ? 1 : -1;
               _loc7_ = param1.y;
               while(true)
               {
                  if(_loc7_ != param2.y)
                  {
                     _loc6_ = (_loc7_ - param1.y) / _loc9_ + param1.x;
                     if(!mapModel.getWalkable(_loc6_,_loc7_))
                     {
                        break;
                     }
                     _loc3_.push(new Point(_loc6_,_loc7_));
                     _loc7_ += _loc8_;
                     continue;
                  }
               }
               return null;
            }
            _loc8_ = param2.x > param1.x ? 1 : -1;
            _loc6_ = param1.x;
            while(_loc6_ != param2.x)
            {
               _loc7_ = (_loc6_ - param1.x) * _loc9_ + param1.y;
               if(!mapModel.getWalkable(_loc6_,_loc7_))
               {
                  return null;
               }
               _loc3_.push(new Point(_loc6_,_loc7_));
               _loc6_ += _loc8_;
            }
         }
         return _loc3_;
      }
      
      private function isAllWalkable(param1:Array) : Boolean
      {
         for each(var _loc2_:Point in param1)
         {
            if(!mapModel.getWalkable(_loc2_.x,_loc2_.y))
            {
               return false;
            }
         }
         return true;
      }
      
      public function dispose() : void
      {
         clearTimeout(timeId);
         timeId = 0;
         if(armyView)
         {
            armyView.aiInfo.removeEventListener("updatePaths",__walkOverHandler);
         }
         mapModel.removeEventListener("addGarrison",__addPlayerHandler);
         mapModel.removeEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
         removeEventListener("enterFrame",enterFrame);
      }
   }
}

