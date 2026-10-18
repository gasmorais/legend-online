package map.campaign.view.frame.duskarea
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ObjectsEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.data.CampaignNode;
   import map.internals.utils.PathPointUtils;
   import map.internals.view.frame.PathPoint;
   import utils.LogicUtils;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class IceFireWarSmallMapFrame extends Frame implements IEnterFrame
   {
      
      private static const SX:Number = 12.8;
      
      private static const SY:Number = 11.2;
      
      private var _rect:Rectangle;
      
      private var _mapModel:CampaignMapModel;
      
      private var _selfArmy:CampaignArmy;
      
      private var _selfArmyView:*;
      
      private var _mapImg:Bitmap;
      
      private var _leftBg:ScaleBitmapImage;
      
      private var _self:Bitmap;
      
      private var _path:Array;
      
      private var _pathPointDic:Dictionary;
      
      private var _walkTarget:MovieClip;
      
      private var _pathContainer:Sprite;
      
      private var _syncSelfPositionFlag:Boolean = true;
      
      private var _flushtime:int;
      
      private var _mapContainer:Sprite;
      
      private var _buildBuleBtn:BaseButton;
      
      private var _buildRedBtn:BaseButton;
      
      private var redNodeId:int;
      
      private var buleNodeId:int;
      
      public var isDuskareaSmallMap:Boolean = true;
      
      private const NPCIdArr1:Array = [47011003,47011004];
      
      private const NPCIdArr2:Array = [47011028,47011029,47011030,47011031,47011032,47011033];
      
      private const NPCIdArr3:Array = [47011301,47011332];
      
      private var _npcPointItem:Object;
      
      public function IceFireWarSmallMapFrame()
      {
         super();
         _mapModel = CampaignManager.instance.mapModel;
         _selfArmy = _mapModel.selfMemberData;
         _selfArmyView = CampaignManager.instance.controller.getArmyView(_selfArmy);
         initView();
         addEvent();
         initNodePosition();
         syncSelfPath();
      }
      
      private function initView() : void
      {
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaSmallMapFrame.MapBg");
         _mapImg = ComponentFactory.Instance.creatBitmap("asset.duskarea.DuskAreaSmallMapFrame.SmallMap");
         _self = ComponentFactory.Instance.creatBitmap("asset.duskarea.DuskAreaSmallMapFrame.SelfAsset");
         _walkTarget = ComponentFactory.Instance.creatCustomObject("duskarea.DuskAreaSmallMapFrame.WalkTarget");
         _pathContainer = new Sprite();
         _mapContainer = new Sprite();
         _mapContainer.x = 6;
         _mapContainer.y = 9;
         _mapContainer.mask = createShape(500,375);
         addToContent(_leftBg);
         addToContent(_mapContainer);
         _mapContainer.addChild(_mapImg);
         _mapContainer.addChild(_self);
         _mapContainer.addChild(_walkTarget);
         _mapContainer.addChild(_pathContainer);
         _walkTarget.mouseChildren = _walkTarget.mouseEnabled = false;
         _walkTarget.scrollRect = null;
         _walkTarget.visible = false;
         _buildBuleBtn = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.buildBlueBtn");
         addToContent(_buildBuleBtn);
         _buildRedBtn = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.buildRedBtn");
         addToContent(_buildRedBtn);
         _self.x = _selfArmyView.x / 12.8 - 15;
         _self.y = _selfArmyView.y / 11.2 - 15;
      }
      
      private function createShape(param1:int, param2:int) : Shape
      {
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginFill(16777215,0);
         _loc3_.graphics.drawRect(0,0,param1,param2);
         _loc3_.graphics.endFill();
         _loc3_.x = 6;
         _loc3_.y = 9;
         addToContent(_loc3_);
         return _loc3_;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _rect;
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function clearNpcItem() : void
      {
         var _loc2_:BaseButton = null;
         for(var _loc1_:String in _npcPointItem)
         {
            _loc2_ = _npcPointItem[_loc1_];
            if(_loc2_ != null)
            {
               _loc2_.removeEventListener("click",onNpcPointClick);
            }
         }
         LogicUtils.disposeDisplayCollection(_npcPointItem);
         _npcPointItem = [];
      }
      
      private function initNodePosition(param1:* = null) : void
      {
         var _loc3_:BaseButton = null;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc8_:CampaignNode = null;
         var _loc4_:String = null;
         clearNpcItem();
         var _loc7_:Array = _mapModel.mapNodesData;
         _loc5_ = 0;
         while(_loc5_ < _loc7_.length)
         {
            _loc8_ = _loc7_[_loc5_];
            if(_loc8_.param2 == 5 && _loc8_.info.types != 42)
            {
               if(int(_loc8_.param1) == 1)
               {
                  buleNodeId = _loc8_.nodeId;
                  _buildBuleBtn.x = _loc8_.x / 12.8 - 15;
                  _buildBuleBtn.y = _loc8_.y / 11.2 - 15;
                  _buildBuleBtn.tipData = [_loc8_.info.names];
               }
               else if(int(_loc8_.param1) == 2)
               {
                  redNodeId = _loc8_.nodeId;
                  _buildRedBtn.x = _loc8_.x / 12.8 - 15;
                  _buildRedBtn.y = _loc8_.y / 11.2 - 15;
                  _buildRedBtn.tipData = [_loc8_.info.names];
               }
            }
            else
            {
               _loc4_ = "";
               if(NPCIdArr1.indexOf(_loc8_.nodeId) != -1)
               {
                  _loc4_ = "duskarea.DuskAreaSmallMapFrame.NPCBGreentn";
               }
               else if(NPCIdArr2.indexOf(_loc8_.nodeId) != -1)
               {
                  _loc4_ = "duskarea.DuskAreaSmallMapFrame.NPCBPurpletn";
               }
               else if(_loc8_.nodeId >= NPCIdArr3[0] && _loc8_.nodeId <= NPCIdArr3[1])
               {
                  _loc4_ = "duskarea.DuskAreaSmallMapFrame.NPCBYellowtn";
               }
               if(_loc4_ != "")
               {
                  _loc3_ = ComponentFactory.Instance.creatComponentByStylename(_loc4_);
                  addToContent(_loc3_);
                  _npcPointItem[_loc8_.nodeId] = _loc3_;
                  _loc3_.addEventListener("click",onNpcPointClick);
                  _loc3_.tipData = [_loc8_.info.names];
                  _loc3_.x = _loc8_.x / 12.8 - 15;
                  _loc3_.y = _loc8_.y / 11.2 - 15;
               }
            }
            _loc5_++;
         }
      }
      
      private function onNpcPointClick(param1:MouseEvent) : void
      {
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:CampaignNode = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         for(var _loc2_:String in _npcPointItem)
         {
            if(_npcPointItem[_loc2_] == param1.currentTarget)
            {
               _loc7_ = int(_loc2_);
            }
         }
         if(_loc7_ == 0)
         {
            if(_buildBuleBtn == param1.currentTarget)
            {
               _loc7_ = buleNodeId;
            }
            else if(_buildRedBtn == param1.currentTarget)
            {
               _loc7_ = redNodeId;
            }
         }
         var _loc6_:Array = _mapModel.mapNodesData;
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc8_ = _loc6_[_loc5_];
            if(_loc8_.nodeId == _loc7_)
            {
               if(_loc8_.param2 == 5 && _loc8_.info.types != 42)
               {
                  if(_loc7_ == buleNodeId)
                  {
                     _loc4_ = (_buildBuleBtn.x + 15) * 12.8;
                     _loc3_ = (_buildBuleBtn.y + 15) * 11.2;
                  }
                  else if(_loc7_ == redNodeId)
                  {
                     _loc4_ = (_buildRedBtn.x + 15) * 12.8;
                     _loc3_ = (_buildRedBtn.y + 15) * 11.2;
                  }
               }
               else
               {
                  _loc4_ = int(_loc8_.x);
                  _loc3_ = int(_loc8_.y);
               }
               CampaignManager.instance.controller.moveArmyByPos(_loc4_,_loc3_,true);
            }
            _loc5_++;
         }
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         addEventListener("response",__frameResponse);
         _mapModel.addEventListener("UPDATE_CAMPAING_NODE",initNodePosition);
         _mapModel.addEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
         _selfArmyView.addEventListener("WALK_NEXT",__walkNextHandler);
         _selfArmyView.addEventListener("walkOver",__walkOverHandler);
         _mapContainer.addEventListener("click",__mapClickHandler);
         _buildBuleBtn.addEventListener("click",onNpcPointClick);
         _buildRedBtn.addEventListener("click",onNpcPointClick);
      }
      
      private function removeEvent() : void
      {
         var _loc2_:BaseButton = null;
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         removeEventListener("response",__frameResponse);
         if(_mapModel)
         {
            _mapModel.removeEventListener("UPDATE_CAMPAING_NODE",initNodePosition);
         }
         if(_mapModel)
         {
            _mapModel.removeEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
         }
         if(_selfArmyView)
         {
            _selfArmyView.removeEventListener("WALK_NEXT",__walkNextHandler);
         }
         if(_selfArmyView)
         {
            _selfArmyView.removeEventListener("walkOver",__walkOverHandler);
         }
         if(_buildBuleBtn)
         {
            _buildBuleBtn.removeEventListener("click",onNpcPointClick);
         }
         if(_buildRedBtn)
         {
            _buildRedBtn.removeEventListener("click",onNpcPointClick);
         }
         if(_mapContainer)
         {
            _mapContainer.removeEventListener("click",__mapClickHandler);
         }
         if(_npcPointItem != null)
         {
            for(var _loc1_:String in _npcPointItem)
            {
               _loc2_ = _npcPointItem[_loc1_];
               if(_loc2_ != null)
               {
                  _loc2_.removeEventListener("click",onNpcPointClick);
               }
            }
         }
      }
      
      private function __mapClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = param1.localX * 12.8 - 15;
         var _loc2_:int = param1.localY * 11.2 - 15;
         CampaignManager.instance.controller.moveArmyByPos(_loc3_,_loc2_,true);
      }
      
      public function enterFrame() : void
      {
         if(_syncSelfPositionFlag)
         {
            syncSelfPosition();
         }
         flagPosition();
      }
      
      private function flagPosition() : void
      {
         var _loc2_:int = 0;
         var _loc5_:CampaignArmy = null;
         var _loc4_:int = 0;
         var _loc3_:* = undefined;
         if(!_mapModel)
         {
            return;
         }
         var _loc1_:Array = _mapModel.getArmysByState(9);
         if(_loc1_ && _loc1_.length > 0)
         {
            _loc2_ = int(_loc1_.length);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc5_ = _loc1_[_loc4_];
               _loc3_ = CampaignManager.instance.controller.getArmyView(_loc5_);
               if(_loc3_)
               {
                  if(_loc5_.teamId == 1)
                  {
                     _buildRedBtn.x = _loc3_.x / 12.8 - 15;
                     _buildRedBtn.y = _loc3_.y / 11.2 - 15;
                  }
                  else if(_loc5_.teamId == 2)
                  {
                     _buildBuleBtn.x = _loc3_.x / 12.8 - 15;
                     _buildBuleBtn.y = _loc3_.y / 11.2 - 15;
                  }
               }
               _loc4_ += 1;
            }
         }
      }
      
      private function syncSelfPosition() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_self)
         {
            _loc3_ = getTimer();
            _loc1_ = _selfArmyView.x / 12.8 - 15;
            _loc2_ = _selfArmyView.y / 11.2 - 15;
            if(_loc3_ - _flushtime > 200)
            {
               _flushtime = _loc3_;
               TweenLite.killTweensOf(_self);
               TweenLite.to(_self,0.2,{
                  "x":_loc1_,
                  "y":_loc2_
               });
            }
         }
      }
      
      private function __updateWalkTargetHandler(param1:CampaignMapEvent) : void
      {
         var _loc2_:Point = param1.data as Point;
         if(_loc2_)
         {
            _syncSelfPositionFlag = true;
            syncSelfPath(_loc2_);
         }
         else
         {
            _syncSelfPositionFlag = false;
            _walkTarget.visible = false;
            _walkTarget.stop();
         }
      }
      
      private function syncSelfPath(param1:Point = null) : void
      {
         var _loc7_:Point = null;
         var _loc2_:Point = null;
         var _loc5_:int = 0;
         _path = [];
         var _loc3_:Point = param1;
         var _loc6_:Boolean = false;
         var _loc4_:int = int(_selfArmyView.aiInfo.walkIndex);
         if(!_loc3_)
         {
            if(!_selfArmyView.aiInfo.pathInfo || _selfArmyView.aiInfo.pathInfo.length == 0)
            {
               return;
            }
            if(_selfArmyView.isStand && _loc4_ >= _selfArmyView.aiInfo.pathInfo.length)
            {
               return;
            }
            _loc2_ = _selfArmyView.aiInfo.pathInfo[_selfArmyView.aiInfo.pathInfo.length - 1];
            _loc5_ = _loc4_ - 1;
            while(_loc5_ < _selfArmyView.aiInfo.pathInfo.length)
            {
               _loc7_ = _selfArmyView.aiInfo.pathInfo[_loc5_] as Point;
               _path.push(_loc7_);
               _loc5_++;
            }
            if(_path.length == 0)
            {
               return;
            }
            _loc3_ = _loc2_;
            _walkTarget.x = positionConvertX(_loc3_.x) - 11;
            _walkTarget.y = positionConvertY(_loc3_.y) - 6;
         }
         else
         {
            _path = _selfArmyView.aiInfo.pathInfo.slice();
            _walkTarget.x = positionConvertX(_loc3_.x * 0.05) - 11;
            _walkTarget.y = positionConvertY(_loc3_.y * 0.05) - 6;
         }
         _walkTarget.gotoAndPlay(1);
         _walkTarget.visible = true;
         showPath();
      }
      
      private function positionConvertX(param1:int) : int
      {
         return param1 * 20 / 12.8;
      }
      
      private function positionConvertY(param1:int) : int
      {
         return param1 * 20 / 11.2;
      }
      
      private function showPath() : void
      {
         var _loc6_:Point = null;
         var _loc4_:PathPoint = null;
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         var _loc9_:Array = null;
         var _loc5_:Number = NaN;
         if(!_path)
         {
            return;
         }
         _pathPointDic = new Dictionary(true);
         ObjectUtils.disposeAllChildren(_pathContainer);
         var _loc7_:int = 1;
         var _loc1_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _path.length)
         {
            if(_loc7_ > 0)
            {
               _loc2_ = _path[_loc7_ - 1];
            }
            else
            {
               _loc2_ = new Point(int(_selfArmyView.x / 20),int(_selfArmyView.y / 20));
            }
            _loc3_ = _path[_loc7_];
            _loc9_ = PathPointUtils.findPoints(_loc2_,_loc3_);
            _loc9_.shift();
            _loc1_ = _loc1_.concat(_loc9_);
            _loc7_++;
         }
         _path = _loc1_;
         var _loc8_:* = 0;
         _loc7_ = 0;
         for(; _loc7_ < _path.length; _loc7_++)
         {
            if(_loc7_ > 0)
            {
               if(_loc7_ == _path.length - 1)
               {
                  _loc5_ = Point.distance(_loc6_,_path[_loc7_]);
                  if(_loc5_ <= 2.5)
                  {
                     continue;
                  }
               }
               else
               {
                  if(_loc7_ - _loc8_ <= 3)
                  {
                     continue;
                  }
                  _loc5_ = Point.distance(_loc6_,_path[_loc7_]);
                  if(_loc5_ < 5)
                  {
                     continue;
                  }
               }
            }
            _loc8_ = _loc7_;
            _loc6_ = _path[_loc7_] as Point;
            _loc4_ = new PathPoint();
            _loc4_.x = positionConvertX(_loc6_.x) - _loc4_.width * 0.5;
            _loc4_.y = positionConvertY(_loc6_.y) - _loc4_.height * 0.5;
            _pathContainer.addChild(_loc4_);
            _pathPointDic[_loc6_.x + "_" + _loc6_.y] = _loc4_;
         }
      }
      
      private function __walkNextHandler(param1:ObjectsEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc3_:PathPoint = null;
         if(_path.length == 0)
         {
            return;
         }
         var _loc2_:Point = param1.data.point as Point;
         _loc4_ = _loc2_.x - 1;
         while(_loc4_ <= _loc2_.x + 1)
         {
            _loc5_ = _loc2_.y - 1;
            while(_loc5_ <= _loc2_.y + 1)
            {
               _loc6_ = _loc4_ + "_" + _loc5_;
               _loc3_ = _pathPointDic[_loc6_];
               ObjectUtils.disposeObject(_loc3_);
               delete _pathPointDic[_loc6_];
               _loc5_++;
            }
            _loc4_++;
         }
      }
      
      private function __walkOverHandler(param1:ObjectsEvent) : void
      {
         if(_walkTarget)
         {
            _walkTarget.visible = false;
         }
         ObjectUtils.disposeAllChildren(_pathContainer);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         _rect = new Rectangle(0,0,520,400);
         LayerManager.Instance.addToLayer(this,3,true,true);
         SoundManager.instance.play("022");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_self)
         {
            TweenLite.killTweensOf(_self);
         }
         ObjectUtils.disposeAllChildren(_mapContainer);
         _mapContainer = null;
         ObjectUtils.disposeAllChildren(_pathContainer);
         _pathContainer = null;
         ObjectUtils.disposeViolentMc(_walkTarget);
         _walkTarget = null;
         ObjectUtils.disposeObject(_mapImg);
         _mapImg = null;
         ObjectUtils.disposeObject(_self);
         _self = null;
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_buildRedBtn);
         _buildRedBtn = null;
         ObjectUtils.disposeObject(_buildBuleBtn);
         _buildBuleBtn = null;
         LogicUtils.disposeDisplayCollection(_npcPointItem);
         _npcPointItem = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

