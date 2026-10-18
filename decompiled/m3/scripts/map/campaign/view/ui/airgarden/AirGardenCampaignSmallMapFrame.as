package map.campaign.view.ui.airgarden
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ObjectsEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import mainBar.effects.MainToolBtnGlowEffect;
   import managers.AirGardenManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.data.CampaignNode;
   import map.internals.utils.PathPointUtils;
   import map.internals.view.frame.PathPoint;
   import mvc.module.airgarden.AirGardenCampaignBedInfo;
   import mvc.module.airgarden.AirGardenModel;
   import utils.LogicUtils;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.ArmyManager;
   import yishi.manager.EnterFrameManager;
   import yishi.utils.MsgMan;
   
   public class AirGardenCampaignSmallMapFrame extends Frame implements IManualSize, IEnterFrame
   {
      
      private static const SX:Number = 12.5;
      
      private static const SY:Number = 12.5;
      
      private var _rect:Rectangle;
      
      private var _mapImg:Bitmap;
      
      private var _leftBg:ScaleBitmapImage;
      
      private var _self:Bitmap;
      
      private var _path:Array;
      
      private var _pathPointDic:Dictionary;
      
      private var _walkTarget:MovieClip;
      
      private var _pathContainer:Component;
      
      private var _syncSelfPositionFlag:Boolean = true;
      
      private var _mapContainer:Component;
      
      private var _npcPointItem:Object;
      
      private var _effectDic:Dictionary;
      
      private const NPCIdArr1:Array = [700002];
      
      private const NPCIdArr2:Array = [700003];
      
      private var _flushtime:int;
      
      public function AirGardenCampaignSmallMapFrame()
      {
         super();
         initView();
         addEvent();
         initNodePosition();
         syncSelfPath();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,580,345);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignSmallMapFrame.MapBg");
         _mapImg = ComponentFactory.Instance.creatBitmap("asset.AirGardenCampaignSmallMapFrame.SmallMap");
         _self = ComponentFactory.Instance.creatBitmap("asset.AirGardenCampaignSmallMapFrame.SelfAsset");
         _walkTarget = ComponentFactory.Instance.creatCustomObject("AirGardenCampaignSmallMapFrame.WalkTarget");
         _pathContainer = new Component();
         _mapContainer = new Component();
         _mapContainer.x = 6;
         _mapContainer.y = 9;
         _mapContainer.mask = createShape(560,320);
         addToContent(_leftBg);
         addToContent(_mapContainer);
         _mapContainer.addChild(_mapImg);
         _mapContainer.addChild(_self);
         _mapContainer.addChild(_walkTarget);
         _mapContainer.addChild(_pathContainer);
         _walkTarget.mouseChildren = _walkTarget.mouseEnabled = false;
         _walkTarget.scrollRect = null;
         _walkTarget.visible = false;
         _self.x = selfArmyView.x / 12.5 - 8;
         _self.y = selfArmyView.y / 12.5 - 8;
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
         LogicUtils.disposeDisplayCollection(_effectDic);
         _effectDic = null;
      }
      
      private function initNodePosition(param1:* = null) : void
      {
         var _loc3_:BaseButton = null;
         var _loc2_:MainToolBtnGlowEffect = null;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc9_:CampaignNode = null;
         var _loc4_:String = null;
         clearNpcItem();
         var _loc8_:Array = mapModel.mapNodesData;
         if(!_loc8_ || _loc8_.length <= 0)
         {
            return;
         }
         _effectDic = new Dictionary(true);
         var _loc7_:Boolean = false;
         _loc5_ = 0;
         while(_loc5_ < _loc8_.length)
         {
            _loc9_ = _loc8_[_loc5_];
            _loc4_ = "";
            if(NPCIdArr1.indexOf(_loc9_.nodeId) != -1)
            {
               _loc4_ = "AirGardenCampaignSmallMapFrame.NPCGreenBtn";
            }
            else if(NPCIdArr2.indexOf(_loc9_.nodeId) != -1)
            {
               _loc4_ = "AirGardenCampaignSmallMapFrame.NPCPurpleBtn";
            }
            else if(_loc9_.info.types == 207 && _loc9_.info.state == 1)
            {
               _loc4_ = "AirGardenCampaignSmallMapFrame.NPCBlueBtn";
               _loc7_ = true;
            }
            if(_loc4_ != "")
            {
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename(_loc4_);
               addToContent(_loc3_);
               if(_loc7_)
               {
                  _loc2_ = new MainToolBtnGlowEffect(_loc3_);
                  _loc2_.stop();
                  _effectDic[_loc9_.nodeId] = _loc2_;
               }
               _npcPointItem[_loc9_.nodeId] = _loc3_;
               _loc3_.addEventListener("click",onNpcPointClick);
               _loc3_.tipData = [_loc9_.info.names];
               _loc3_.x = _loc9_.x / 12.5 - 2;
               _loc3_.y = _loc9_.y / 12.5 + 1;
            }
            _loc5_++;
         }
         __updateCampainDetailHandler(null,null);
      }
      
      private function onNpcPointClick(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:CampaignNode = null;
         for(var _loc2_:String in _npcPointItem)
         {
            if(_npcPointItem[_loc2_] == param1.currentTarget)
            {
               _loc5_ = int(_loc2_);
            }
         }
         if(_loc5_ == 0)
         {
            return;
         }
         if(_effectDic[_loc5_])
         {
            (_effectDic[_loc5_] as MainToolBtnGlowEffect).stop();
         }
         var _loc4_:Array = mapModel.mapNodesData;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc3_];
            if(_loc6_.nodeId == _loc5_)
            {
               CampaignManager.instance.controller.moveArmyByPos(_loc6_.x,_loc6_.y,true);
            }
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         addEventListener("response",__frameResponse);
         mapModel.addEventListener("UPDATE_CAMPAING_NODE",initNodePosition);
         mapModel.addEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
         selfArmyView.addEventListener("WALK_NEXT",__walkNextHandler);
         selfArmyView.addEventListener("walkOver",__walkOverHandler);
         _mapContainer.addEventListener("click",__mapClickHandler);
         MsgMan.addObserver("CAMPAIGN_DETAIL_UPDATE",this,__updateCampainDetailHandler);
      }
      
      private function removeEvent() : void
      {
         var _loc2_:BaseButton = null;
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         removeEventListener("response",__frameResponse);
         if(mapModel)
         {
            mapModel.removeEventListener("UPDATE_CAMPAING_NODE",initNodePosition);
         }
         if(mapModel)
         {
            mapModel.removeEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
         }
         if(selfArmyView)
         {
            selfArmyView.removeEventListener("WALK_NEXT",__walkNextHandler);
         }
         if(selfArmyView)
         {
            selfArmyView.removeEventListener("walkOver",__walkOverHandler);
         }
         if(_mapContainer)
         {
            _mapContainer.removeEventListener("click",__mapClickHandler);
         }
         MsgMan.removeObserver("CAMPAIGN_DETAIL_UPDATE",this,__updateCampainDetailHandler);
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
      
      private function __updateCampainDetailHandler(param1:String, param2:Object) : void
      {
         for each(var _loc3_:AirGardenCampaignBedInfo in model.campaignInfo.bedNodeList)
         {
            if(model.campaignInfo.masterUserId == ArmyManager.instance.thane.userId && _loc3_.campaignNodeId > 0 && _loc3_.objId == 0)
            {
               if(_effectDic[_loc3_.campaignNodeId])
               {
                  (_effectDic[_loc3_.campaignNodeId] as MainToolBtnGlowEffect).play();
               }
            }
            else if(_effectDic[_loc3_.campaignNodeId])
            {
               (_effectDic[_loc3_.campaignNodeId] as MainToolBtnGlowEffect).stop();
            }
         }
      }
      
      private function __mapClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = param1.localX * 12.5;
         var _loc2_:int = param1.localY * 12.5;
         CampaignManager.instance.controller.moveArmyByPos(_loc3_,_loc2_,true);
      }
      
      public function enterFrame() : void
      {
         if(_syncSelfPositionFlag)
         {
            syncSelfPosition();
         }
      }
      
      private function syncSelfPosition() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_self && selfArmyView)
         {
            _loc3_ = getTimer();
            _loc1_ = selfArmyView.x / 12.5 - 8;
            _loc2_ = selfArmyView.y / 12.5 - 8;
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
         var _loc4_:int = int(selfArmyView.aiInfo.walkIndex);
         if(!_loc3_)
         {
            if(!selfArmyView.aiInfo.pathInfo || selfArmyView.aiInfo.pathInfo.length == 0)
            {
               return;
            }
            if(selfArmyView.isStand && _loc4_ >= selfArmyView.aiInfo.pathInfo.length)
            {
               return;
            }
            _loc2_ = selfArmyView.aiInfo.pathInfo[selfArmyView.aiInfo.pathInfo.length - 1];
            _loc5_ = _loc4_ - 1;
            while(_loc5_ < selfArmyView.aiInfo.pathInfo.length)
            {
               _loc7_ = selfArmyView.aiInfo.pathInfo[_loc5_] as Point;
               _path.push(_loc7_);
               _loc5_++;
            }
            if(_path.length == 0)
            {
               return;
            }
            _loc3_ = _loc2_;
            _walkTarget.x = positionConvertX(_loc3_.x) - 11;
            _walkTarget.y = positionConvertY(_loc3_.y) - 13;
         }
         else
         {
            _path = selfArmyView.aiInfo.pathInfo.slice();
            _walkTarget.x = _loc3_.x / 12.5 - 11;
            _walkTarget.y = _loc3_.y / 12.5 - 13;
         }
         _walkTarget.gotoAndPlay(1);
         _walkTarget.visible = true;
         showSelfPath();
      }
      
      private function positionConvertX(param1:int) : int
      {
         return param1 * 20 / 12.5;
      }
      
      private function positionConvertY(param1:int) : int
      {
         return param1 * 20 / 12.5;
      }
      
      private function showSelfPath() : void
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
               _loc2_ = new Point(int(selfArmyView.x / 20),int(selfArmyView.y / 20));
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
            case 1:
               dispose();
         }
      }
      
      private function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      private function get selfArmy() : CampaignArmy
      {
         return mapModel.selfMemberData;
      }
      
      private function get selfArmyView() : *
      {
         return CampaignManager.instance.controller.getArmyView(selfArmy);
      }
      
      private function get model() : AirGardenModel
      {
         return AirGardenManager.instance.model;
      }
      
      public function show() : void
      {
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
         ObjectUtils.disposeObject(_mapContainer);
         _mapContainer = null;
         ObjectUtils.disposeViolentMc(_walkTarget);
         _walkTarget = null;
         ObjectUtils.disposeObject(_mapImg);
         _mapImg = null;
         ObjectUtils.disposeObject(_self);
         _self = null;
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_pathContainer);
         _pathContainer = null;
         LogicUtils.disposeDisplayCollection(_npcPointItem);
         _npcPointItem = null;
         LogicUtils.disposeDisplayCollection(_effectDic);
         _effectDic = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

