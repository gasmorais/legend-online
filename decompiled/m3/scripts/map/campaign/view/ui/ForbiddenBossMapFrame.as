package map.campaign.view.ui
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ObjectsEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.data.CampaignNode;
   import map.internals.utils.PathPointUtils;
   import map.internals.view.frame.PathPoint;
   import yishi.datas.templates.ForbiddenBossTempInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.TempleteManager;
   
   public class ForbiddenBossMapFrame extends Frame implements IEnterFrame
   {
      
      private var _model:CampaignMapModel;
      
      private var _selfArmy:CampaignArmy;
      
      private var _selfArmyView:Object;
      
      private var _path:Array;
      
      private var _pathPointDic:Dictionary;
      
      private var _pathContainer:Sprite;
      
      private var _bg:ScaleBitmapImage;
      
      private var _mapImg:Bitmap;
      
      private var _mapContainer:Sprite;
      
      private var _self:Bitmap;
      
      private var _nodeContainer:Sprite;
      
      private var _walkTarget:MovieClip;
      
      private var _flushtime:int;
      
      private var _nodeDic:Dictionary;
      
      private var _itemList:Dictionary;
      
      private var _showTypes:Array = [42,41];
      
      private var _helpBtn:BaseButton;
      
      public function ForbiddenBossMapFrame()
      {
         super();
         initData();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initData() : void
      {
         _model = CampaignManager.instance.mapModel;
         _selfArmy = _model.selfMemberData;
         _selfArmyView = CampaignManager.instance.controller.getArmyView(_selfArmy);
         _pathPointDic = new Dictionary();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossMapFrame.bg");
         _mapContainer = ComponentFactory.Instance.creatCustomObject("skyStepMapFrame.Container");
         _mapImg = ComponentFactory.Instance.creatBitmap("asset.forbiddenBossMapFrame.mapImg" + index);
         _self = ComponentFactory.Instance.creatBitmap("asset.space.SpaceMapFrame.SelfAsset");
         _walkTarget = ComponentFactory.Instance.creatCustomObject("map.space.SpaceMapFrame.WalkTarget");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.CloseBtn");
         _nodeContainer = new Sprite();
         _pathContainer = new Sprite();
         _mapContainer.addChild(_mapImg);
         _mapContainer.addChild(_nodeContainer);
         _mapContainer.addChild(_self);
         _mapContainer.addChild(_walkTarget);
         _mapContainer.addChild(_pathContainer);
         if(_model.campaignTemplate.CampaignId > 35000 && _model.campaignTemplate.CampaignId < 36000)
         {
            _bg.width = 426;
            _bg.height = 524;
            _helpBtn.x = 408;
            _mapContainer.mask = createShape(375,475);
         }
         else
         {
            _bg.width = 551;
            _bg.height = 379;
            _helpBtn.x = 528;
            _mapContainer.mask = createShape(500,333);
         }
         addToContent(_bg);
         addToContent(_mapContainer);
         addToContent(_helpBtn);
         _helpBtn.y = -2;
         _walkTarget.mouseChildren = _walkTarget.mouseEnabled = false;
         _walkTarget.scrollRect = null;
         _walkTarget.visible = false;
         _self.x = positionConvertX(_selfArmyView.x * 0.05) - _self.width * 0.5;
         _self.y = positionConvertY(_selfArmyView.y * 0.05) - _self.height * 0.5;
         syncSelfPosition();
         initNodePosition();
         syncSelfPath();
      }
      
      private function get index() : int
      {
         var _loc1_:ForbiddenBossTempInfo = TempleteManager.instance.forbiddenBossTempCate.getTempInfoById(_model.campaignTemplate.CampaignId);
         if(_loc1_)
         {
            return _loc1_.Category;
         }
         return 1;
      }
      
      private function createShape(param1:int, param2:int) : Shape
      {
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginFill(16777215,0);
         _loc3_.graphics.drawRect(0,0,param1,param2);
         _loc3_.graphics.endFill();
         _loc3_.x = 23;
         _loc3_.y = 23;
         addToContent(_loc3_);
         return _loc3_;
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         addEventListener("response",__frameResponse);
         _mapContainer.addEventListener("click",__mapClickHandler);
         _model.addEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
         _selfArmyView.addEventListener("WALK_NEXT",__walkNextHandler);
         _selfArmyView.addEventListener("walkOver",__walkOverHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         removeEventListener("response",__frameResponse);
         _mapContainer.removeEventListener("click",__mapClickHandler);
         _model.removeEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
         _selfArmyView.removeEventListener("WALK_NEXT",__walkNextHandler);
         _selfArmyView.removeEventListener("walkOver",__walkOverHandler);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __mapClickHandler(param1:MouseEvent) : void
      {
         if(param1.target is BaseButton)
         {
            return;
         }
         var _loc5_:Number = 0;
         var _loc4_:Number = 0;
         switch(index - 1)
         {
            case 0:
               _loc5_ = 12;
               _loc4_ = 12;
               break;
            case 1:
               _loc5_ = 13;
               _loc4_ = 12;
               break;
            case 2:
               _loc5_ = 6;
               _loc4_ = 6;
               break;
            case 3:
               _loc5_ = 11;
               _loc4_ = 10.2;
               break;
            case 4:
               _loc5_ = 12;
               _loc4_ = 12;
         }
         var _loc3_:int = param1.localX * _loc5_;
         var _loc2_:int = param1.localY * _loc4_;
         CampaignManager.instance.controller.moveArmyByPos(_loc3_,_loc2_,true);
      }
      
      private function __updateWalkTargetHandler(param1:CampaignMapEvent) : void
      {
         var _loc2_:Point = param1.data as Point;
         if(_loc2_)
         {
            syncSelfPath(_loc2_);
         }
         else
         {
            _walkTarget.visible = false;
            _walkTarget.stop();
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
      
      private function initNodePosition() : void
      {
         var _loc4_:CampaignNode = null;
         var _loc1_:BaseButton = null;
         var _loc2_:BaseButton = null;
         var _loc6_:FilterFrameText = null;
         var _loc3_:int = 0;
         _nodeDic = new Dictionary();
         _itemList = new Dictionary();
         var _loc5_:Array = _model.mapNodesData;
         _loc3_ = 0;
         while(_loc3_ < _loc5_.length)
         {
            _loc4_ = _loc5_[_loc3_] as CampaignNode;
            if(_showTypes.indexOf(_loc4_.info.types) != -1)
            {
               if(!(_loc4_.info.state == 9 || _loc4_.info.state == 8 || _loc4_.info.state == 0))
               {
                  _loc6_ = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.NodeNameTxt");
                  _loc6_.mouseEnabled = false;
                  _loc6_.setFrame(1);
                  _loc6_.text = _loc4_.info.names;
                  _nodeContainer.addChild(_loc6_);
                  if(_loc4_.info.types == 41)
                  {
                     _loc2_ = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.TransferBtn");
                     _nodeContainer.addChild(_loc2_);
                     _loc2_.x = positionConvertX(_loc4_.curPosX) - _loc2_.width * 0.5;
                     _loc2_.y = positionConvertY(_loc4_.curPosY) - 40;
                     _loc6_.x = _loc2_.x - (_loc6_.width - _loc2_.width) * 0.5;
                     _loc6_.y = _loc2_.y;
                     if(_loc6_.y <= _loc6_.height)
                     {
                        _loc6_.y = _loc2_.y + 50;
                     }
                     _loc2_.addEventListener("click",__nodeClickHandler);
                     _nodeDic[_loc2_] = _loc4_;
                  }
                  else
                  {
                     _loc1_ = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.NPCBtn");
                     _nodeContainer.addChild(_loc1_);
                     _loc1_.x = positionConvertX(_loc4_.curPosX) - _loc1_.width * 0.5;
                     _loc1_.y = positionConvertY(_loc4_.curPosY) - _loc1_.height * 0.5;
                     _loc6_.x = _loc1_.x - (_loc6_.width - _loc1_.width) * 0.5;
                     _loc6_.y = _loc1_.y - _loc6_.height;
                     _loc1_.addEventListener("click",__nodeClickHandler);
                     _nodeDic[_loc1_] = _loc4_;
                  }
               }
            }
            _loc3_++;
         }
      }
      
      private function __nodeClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:CampaignNode = _nodeDic[param1.target] as CampaignNode;
         CampaignManager.instance.mapModel.selectNode = _loc2_;
         CampaignManager.instance.controller.moveArmyByPos(_loc2_.curPosX * 20,_loc2_.curPosY * 20,true);
      }
      
      private function syncSelfPath(param1:Point = null) : void
      {
         var _loc7_:Point = null;
         var _loc2_:Point = null;
         var _loc5_:int = 0;
         _path = [];
         var _loc3_:Point = param1;
         var _loc6_:Boolean = false;
         var _loc4_:int = int(_selfArmyView.info.walkIndex);
         if(!_loc3_)
         {
            if(!_selfArmyView.info.pathInfo || _selfArmyView.info.pathInfo.length == 0)
            {
               return;
            }
            if(_selfArmyView.isStand && _loc4_ >= _selfArmyView.aiInfo.pathInfo.length)
            {
               return;
            }
            _loc2_ = _selfArmyView.info.pathInfo[_selfArmyView.info.pathInfo.length - 1];
            _loc5_ = _loc4_ - 1;
            while(_loc5_ < _selfArmyView.info.pathInfo.length)
            {
               _loc7_ = _selfArmyView.info.pathInfo[_loc5_] as Point;
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
            _path = _selfArmyView.info.pathInfo.slice();
            _walkTarget.x = positionConvertX(_loc3_.x * 0.05) - 11;
            _walkTarget.y = positionConvertY(_loc3_.y * 0.05) - 6;
         }
         _walkTarget.gotoAndPlay(1);
         _walkTarget.visible = true;
         showPath();
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
         _pathPointDic = new Dictionary();
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
      
      public function enterFrame() : void
      {
         syncSelfPosition();
      }
      
      private function syncSelfPosition() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_self)
         {
            _loc3_ = getTimer();
            _loc1_ = positionConvertX(_selfArmyView.x * 0.05) - _self.width * 0.5;
            _loc2_ = positionConvertY(_selfArmyView.y * 0.05) - _self.height * 0.5;
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
      
      private function positionConvertX(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(index - 1)
         {
            case 0:
               _loc2_ = param1 * 1.66;
               break;
            case 1:
               _loc2_ = param1 * 1.53;
               break;
            case 2:
               _loc2_ = param1 * 3.33;
               break;
            case 3:
               _loc2_ = param1 * 1.81;
               break;
            case 4:
               _loc2_ = param1 * 1.66;
         }
         return _loc2_;
      }
      
      private function positionConvertY(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(index - 1)
         {
            case 0:
               _loc2_ = param1 * 1.66;
               break;
            case 1:
               _loc2_ = param1 * 1.66;
               break;
            case 2:
               _loc2_ = param1 * 3.33;
               break;
            case 3:
               _loc2_ = param1 * 1.96;
               break;
            case 4:
               _loc2_ = param1 * 1.66;
         }
         return _loc2_;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_mapImg);
         _mapImg = null;
         ObjectUtils.disposeAllChildren(_nodeContainer);
         ObjectUtils.disposeObject(_nodeContainer);
         _nodeContainer = null;
         ObjectUtils.disposeObject(_self);
         _self = null;
         ObjectUtils.disposeObject(_walkTarget);
         _walkTarget = null;
         ObjectUtils.disposeAllChildren(_pathContainer);
         ObjectUtils.disposeObject(_pathContainer);
         _pathContainer = null;
         ObjectUtils.disposeObject(_mapContainer);
         _mapContainer = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

