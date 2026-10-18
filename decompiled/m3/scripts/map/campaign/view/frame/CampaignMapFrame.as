package map.campaign.view.frame
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.FreedomTeamEvent;
   import events.ObjectsEvent;
   import events.TreasureMapEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.OfferRewardManager;
   import managers.RingTaskManager;
   import managers.TreasureMapManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.data.CampaignNode;
   import map.internals.utils.PathPointUtils;
   import map.internals.view.frame.PathPoint;
   import mvc.module.armyII.BaseArmy;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.WorldBossHelper;
   
   public class CampaignMapFrame extends Frame implements IEnterFrame, IManualSize
   {
      
      private const FRAME_WIDTH:int = 704;
      
      private const FRAME_HEIGHT:int = 500;
      
      private const GROUP_WIDTH:int = 248;
      
      private var _rect:Rectangle;
      
      private const NODE_COUNT_MAX:int = 16;
      
      private var _leftBg:ScaleBitmapImage;
      
      private var _rightBg:ScaleBitmapImage;
      
      private var _leftTitleBg:Bitmap;
      
      private var _leftTitleImg:Bitmap;
      
      private var _optionBtn1:SelectedTextButton;
      
      private var _optionBtn2:SelectedTextButton;
      
      private var _optionBtn3:SelectedTextButton;
      
      private var _walkTarget:MovieClip;
      
      private var _mapContainer:Sprite;
      
      private var _pathContainer:Sprite;
      
      private var _path:Array;
      
      private var _mapImg:Bitmap;
      
      private var _self:Bitmap;
      
      private var _nodeContainer1:Sprite;
      
      private var _nodeContainer2:Sprite;
      
      private var _nodeContainer3:Sprite;
      
      private var _teamContainer:Sprite;
      
      private var _rightTitleImg:Bitmap;
      
      private var _rightTitleline:ScaleBitmapImage;
      
      private var _model:CampaignMapModel;
      
      private var _selfArmy:CampaignArmy;
      
      private var _selfArmyView:Object;
      
      private var _nodeDic:Dictionary;
      
      private var _syncSelfPositionFlag:Boolean = true;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _pathPointDic:Dictionary;
      
      private var _itemList:Dictionary;
      
      private var _memberDic:Dictionary;
      
      private var _memberList:Dictionary;
      
      private var _flushtime:int;
      
      private var _showTypes:Array = [61,171,91,1003];
      
      private var _sortDataDic:Dictionary;
      
      private var _sortData:Array;
      
      public function CampaignMapFrame()
      {
         super();
         initData();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _rect;
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initData() : void
      {
         _model = CampaignManager.instance.mapModel;
         _selfArmy = _model.selfMemberData;
         var _loc1_:Object = CampaignManager.instance.controller.getArmyView(_selfArmy);
         _selfArmyView = _loc1_;
         _pathPointDic = new Dictionary();
         _sortDataDic = new Dictionary();
         _sortDataDic[20001] = [2000102,2000150,2000149];
         _sortDataDic[20002] = [2000202,2000201];
         _sortDataDic[20003] = [2000341,2000301];
         _sortDataDic[20004] = [2000401];
         _sortDataDic[30000] = [3000003,3000004,3000002,3000056];
         _sortDataDic[30001] = [3000101,3000102,3000103];
         _sortData = [];
         _sortData = _sortDataDic[CampaignManager.instance.mapId];
      }
      
      private function initView() : void
      {
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.LeftBg");
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.RightBg");
         _leftTitleBg = ComponentFactory.Instance.creatBitmap("asset.space.SpaceMapFrame.MapOptionBg");
         _leftTitleImg = ComponentFactory.Instance.creatBitmap("asset.space.SpaceMapFrame.TitleAsset1");
         _optionBtn1 = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.OptionBtn1");
         _optionBtn2 = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.OptionBtn2");
         _optionBtn3 = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.OptionBtn3");
         _mapImg = ComponentFactory.Instance.creatBitmap("asset.space.SpaceMapFrame.MapImg" + _model.mapId);
         _self = ComponentFactory.Instance.creatBitmap("asset.space.SpaceMapFrame.SelfAsset");
         _rightTitleImg = ComponentFactory.Instance.creatBitmap("asset.space.SpaceMapFrame.TitleAsset2");
         _rightTitleline = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.RightTitleLine");
         _walkTarget = ComponentFactory.Instance.creatCustomObject("map.space.SpaceMapFrame.WalkTarget");
         _mapContainer = ComponentFactory.Instance.creatCustomObject("asset.space.SpaceMapFrame.Container");
         _nodeContainer1 = new Sprite();
         _nodeContainer2 = new Sprite();
         _nodeContainer3 = new Sprite();
         _teamContainer = new Sprite();
         _pathContainer = new Sprite();
         _vBox = new VBox();
         _vBox.spacing = 0;
         _vBox.mouseEnabled = false;
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.MapNodeList");
         _scrollPanel.setView(_vBox,true);
         _mapContainer.y = 5;
         _mapContainer.addChild(_mapImg);
         _mapContainer.addChild(_nodeContainer1);
         _mapContainer.addChild(_nodeContainer2);
         _mapContainer.addChild(_nodeContainer3);
         _mapContainer.addChild(_teamContainer);
         _mapContainer.addChild(_self);
         _mapContainer.addChild(_pathContainer);
         _mapContainer.addChild(_walkTarget);
         _mapContainer.mask = createShape(500,476);
         _nodeContainer3.mouseEnabled = _nodeContainer3.mouseChildren = false;
         _walkTarget.mouseChildren = _walkTarget.mouseEnabled = false;
         _walkTarget.scrollRect = null;
         _walkTarget.visible = false;
         _optionBtn1.text = LanguageMgr.GetTranslation("map.space.SpaceMapFrame.OptionBtnTxt1");
         _optionBtn2.text = LanguageMgr.GetTranslation("map.space.SpaceMapFrame.OptionBtnTxt2");
         _optionBtn3.text = LanguageMgr.GetTranslation("map.space.SpaceMapFrame.OptionBtnTxt3");
         _optionBtn1.selected = true;
         _optionBtn2.selected = true;
         _optionBtn3.selected = true;
         addToContent(_leftBg);
         addToContent(_rightBg);
         addToContent(_mapContainer);
         addToContent(_leftTitleBg);
         addToContent(_leftTitleImg);
         addToContent(_optionBtn1);
         addToContent(_optionBtn2);
         addToContent(_optionBtn3);
         addToContent(_rightTitleImg);
         addToContent(_rightTitleline);
         addToContent(_scrollPanel);
         _self.x = positionConvert(_selfArmyView.x * 0.05) - _self.width * 0.5;
         _self.y = positionConvert(_selfArmyView.y * 0.05) - _self.height * 0.5;
         syncSelfPosition();
         initNodePosition();
         initMembersPositioin();
         syncSelfPath();
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
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         addEventListener("response",__frameResponse);
         _mapContainer.addEventListener("click",__mapClickHandler);
         _optionBtn1.addEventListener("click",__optionBtnClickHandler);
         _optionBtn2.addEventListener("click",__optionBtnClickHandler);
         _optionBtn3.addEventListener("click",__optionBtnClickHandler);
         _model.addEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
         _selfArmyView.addEventListener("WALK_NEXT",__walkNextHandler);
         _selfArmyView.addEventListener("walkOver",__walkOverHandler);
         NotificationManager.instance.addEventListener("TEAM_INFO_UPDATE",__updateTeamInfoHandler);
         NotificationManager.instance.addEventListener("TEAM_INFO_SYNC",__syncTeamInfoHandler);
         TreasureMapManager.instance.model.addEventListener("TREASURE_INFO_UPDATE",__treasureInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         removeEventListener("response",__frameResponse);
         _mapContainer.removeEventListener("click",__mapClickHandler);
         _optionBtn1.removeEventListener("click",__optionBtnClickHandler);
         _optionBtn2.removeEventListener("click",__optionBtnClickHandler);
         _optionBtn3.removeEventListener("click",__optionBtnClickHandler);
         _model.removeEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
         _selfArmyView.removeEventListener("WALK_NEXT",__walkNextHandler);
         _selfArmyView.removeEventListener("walkOver",__walkOverHandler);
         NotificationManager.instance.removeEventListener("TEAM_INFO_UPDATE",__updateTeamInfoHandler);
         NotificationManager.instance.removeEventListener("TEAM_INFO_SYNC",__syncTeamInfoHandler);
         TreasureMapManager.instance.model.removeEventListener("TREASURE_INFO_UPDATE",__treasureInfoUpdateHandler);
      }
      
      private function __treasureInfoUpdateHandler(param1:TreasureMapEvent) : void
      {
         if(TreasureMapManager.instance.model.useFrameOpened)
         {
            _rect.width = 248;
         }
         else
         {
            _rect.width = 704;
         }
         x = (StageReferance.gameStageWidth - _rect.width) / 2;
      }
      
      private function __mapClickHandler(param1:MouseEvent) : void
      {
         if(param1.target is BaseButton)
         {
            return;
         }
         var _loc3_:int = param1.localX * 8;
         var _loc2_:int = param1.localY * 8;
         CampaignManager.instance.controller.moveArmyByPos(_loc3_,_loc2_,true);
      }
      
      private function __optionBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         updateContainerVisible();
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
            _walkTarget.x = positionConvert(_loc3_.x) - 11;
            _walkTarget.y = positionConvert(_loc3_.y) - 6;
         }
         else
         {
            _path = _selfArmyView.info.pathInfo.slice();
            _walkTarget.x = positionConvert(_loc3_.x * 0.05) - 11;
            _walkTarget.y = positionConvert(_loc3_.y * 0.05) - 6;
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
            _loc4_.x = positionConvert(_loc6_.x) - _loc4_.width * 0.5;
            _loc4_.y = positionConvert(_loc6_.y) - _loc4_.height * 0.5;
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
         if(_self)
         {
            _loc3_ = getTimer();
            _loc1_ = positionConvert(_selfArmyView.x * 0.05) - _self.width * 0.5;
            _loc2_ = positionConvert(_selfArmyView.y * 0.05) - _self.height * 0.5;
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
      
      private function initNodePosition() : void
      {
         var _loc10_:CampaignNode = null;
         var _loc1_:BaseButton = null;
         var _loc8_:BaseButton = null;
         var _loc6_:FilterFrameText = null;
         var _loc11_:CampaignMapNodeItem = null;
         var _loc13_:int = 0;
         var _loc12_:Boolean = false;
         var _loc2_:Array = null;
         var _loc7_:Boolean = false;
         var _loc9_:int = 0;
         _nodeDic = new Dictionary();
         _itemList = new Dictionary();
         var _loc5_:Array = _model.mapNodesData;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_;
         for(; _loc3_ < _loc5_.length; _loc3_++)
         {
            _loc12_ = true;
            _loc10_ = _loc5_[_loc3_] as CampaignNode;
            if(_showTypes.indexOf(_loc10_.info.types) != -1)
            {
               if(!(_loc10_.resource != 2 && _loc10_.info.types == 91))
               {
                  if(!(WorldBossHelper.checkInPetBossFloor(_model.mapId) && _loc10_.info.types == 1003 && _loc10_.param4 != "3"))
                  {
                     if(!(_loc10_.info.state == 9 || _loc10_.info.state == 8))
                     {
                        _loc6_ = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.NodeNameTxt");
                        _loc6_.mouseEnabled = false;
                        _loc6_.setFrame(1);
                        if(_loc10_.info.types == 171 || _loc10_.sonType == 2336)
                        {
                           _loc6_.text = _loc10_.info.names;
                           _loc8_ = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.TransferBtn");
                           _nodeContainer1.addChild(_loc8_);
                           _nodeContainer1.addChild(_loc6_);
                           _loc8_.x = positionConvert(_loc10_.curPosX) - _loc8_.width * 0.5;
                           _loc8_.y = positionConvert(_loc10_.curPosY) - 40;
                           _loc6_.x = _loc8_.x - (_loc6_.width - _loc8_.width) * 0.5;
                           _loc6_.y = _loc10_.info.names == "Transmissor" ? _loc8_.y + 10 : Number(_loc8_.y);
                           if(_loc10_.info.names == "Transmissor piso 1")
                           {
                              _loc6_.x -= 20;
                           }
                           if(_loc6_.y <= _loc6_.height)
                           {
                              _loc6_.y = _loc8_.y + 50;
                           }
                           _loc8_.addEventListener("click",__nodeClickHandler);
                           _nodeDic[_loc8_] = _loc10_;
                        }
                        else
                        {
                           _loc2_ = _loc10_.param4.split(",");
                           _loc7_ = true;
                           _loc9_ = int(CampaignManager.instance.mapId);
                           if(_loc10_.info.types == 91 && Boolean(WorldBossHelper.checkPetLand(_loc9_)))
                           {
                              _loc7_ = false;
                              for each(_loc13_ in _loc2_)
                              {
                                 if(OfferRewardManager.instance.model.hasTaskAndNotCompleted(_loc13_) || Boolean(RingTaskManager.instance.hasTaskAndNotCompleted(_loc13_)))
                                 {
                                    _loc7_ = true;
                                    break;
                                 }
                              }
                           }
                           if(_loc10_.info.types == 91 && Boolean(WorldBossHelper.checkMineral(_loc9_)))
                           {
                              _loc12_ = false;
                           }
                           if(!_loc7_)
                           {
                              continue;
                           }
                           _loc6_.text = _loc10_.param5;
                           _loc1_ = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.NPCBtn");
                           _nodeContainer2.addChild(_loc1_);
                           _nodeContainer2.addChild(_loc6_);
                           _loc1_.x = positionConvert(_loc10_.curPosX) - _loc1_.width * 0.5;
                           _loc1_.y = positionConvert(_loc10_.curPosY) - _loc1_.height * 0.5;
                           _loc6_.x = _loc1_.x - (_loc6_.width - _loc1_.width) * 0.5;
                           _loc6_.y = _loc1_.y - _loc6_.height;
                           _loc1_.addEventListener("click",__nodeClickHandler);
                           _nodeDic[_loc1_] = _loc10_;
                           if(WorldBossHelper.checkInPetBossFloor(_model.mapId) && _loc10_.info.types == 1003 && _loc10_.param4 == "3")
                           {
                              _loc6_.setFrame(2);
                           }
                           if(_loc10_.info.types == 1003)
                           {
                              if(_loc1_.y < 32)
                              {
                                 _loc1_.y = 32;
                              }
                              if(_loc6_.x < 0)
                              {
                                 _loc6_.x = 0;
                              }
                              if(_loc6_.x > 342)
                              {
                                 _loc6_.x = 342;
                              }
                              if(_loc6_.y < 47)
                              {
                                 _loc6_.y = 47;
                              }
                           }
                        }
                        if(_loc12_)
                        {
                           _loc11_ = new CampaignMapNodeItem();
                           _loc11_.data = _loc10_;
                           _itemList[_loc10_.nodeId] = _loc11_;
                           if(_sortData.indexOf(_loc10_.nodeId) == -1)
                           {
                              _sortData.push(_loc10_.nodeId);
                           }
                           _loc4_++;
                        }
                     }
                  }
               }
            }
         }
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _scrollPanel.beginChanges();
            _loc11_ = getMapNodeItemByNodeId(_sortData[_loc3_]);
            _vBox.addChild(_loc11_);
            _vBox.refreshChildPos();
            _scrollPanel.commitChanges();
            _loc3_++;
         }
         _loc4_;
         while(_loc4_ < 16)
         {
            _scrollPanel.beginChanges();
            _loc11_ = new CampaignMapNodeItem();
            _vBox.addChild(_loc11_);
            _vBox.refreshChildPos();
            _scrollPanel.commitChanges();
            _loc4_++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function __updateTeamInfoHandler(param1:FreedomTeamEvent) : void
      {
         initMembersPositioin();
      }
      
      private function __syncTeamInfoHandler(param1:FreedomTeamEvent) : void
      {
         syncMembersPosition();
      }
      
      private function initMembersPositioin() : void
      {
         var _loc3_:BaseButton = null;
         ObjectUtils.disposeAllChildren(_teamContainer);
         if(!FreedomTeamManager.instance.hasTeam)
         {
            return;
         }
         _memberDic = new Dictionary();
         _memberList = new Dictionary();
         var _loc2_:Array = FreedomTeamManager.instance.model.allMembers;
         for each(var _loc1_:BaseArmy in _loc2_)
         {
            if(_loc1_.userId != _selfArmy.userId)
            {
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.MemberBtn");
               _loc3_.visible = false;
               _teamContainer.addChild(_loc3_);
               _loc3_.x = positionConvert(_loc1_.curPosX) - _loc3_.width * 0.5;
               _loc3_.y = positionConvert(_loc1_.curPosY) - _loc3_.height * 0.5;
               _loc3_.tipData = _loc1_.nickName;
               _loc3_.addEventListener("click",__memberClickHandler);
               _memberDic[_loc3_] = _loc1_;
               _memberList[_loc1_.userId] = _loc3_;
               if(_loc1_.mapId == _selfArmy.mapId)
               {
                  if(FreedomTeamManager.instance.memberIsOnline(_loc1_.userId))
                  {
                     _loc3_.visible = true;
                  }
               }
            }
         }
      }
      
      private function syncMembersPosition() : void
      {
         var _loc3_:BaseButton = null;
         if(!FreedomTeamManager.instance.hasTeam)
         {
            return;
         }
         var _loc2_:Array = FreedomTeamManager.instance.model.allMembers;
         for each(var _loc1_:BaseArmy in _loc2_)
         {
            if(_loc1_.userId != _selfArmy.userId)
            {
               _loc3_ = _memberList[_loc1_.userId] as BaseButton;
               if(_loc3_)
               {
                  _loc3_.visible = true;
                  if(_loc1_.mapId != _selfArmy.mapId)
                  {
                     _loc3_.visible = false;
                  }
                  else if(!FreedomTeamManager.instance.memberIsOnline(_loc1_.userId))
                  {
                     _loc3_.visible = false;
                  }
                  else
                  {
                     _loc3_.x = positionConvert(_loc1_.curPosX) - _loc3_.width * 0.5;
                     _loc3_.y = positionConvert(_loc1_.curPosY) - _loc3_.height * 0.5;
                  }
               }
            }
         }
      }
      
      public function getMapNodeItemByNodeId(param1:int) : CampaignMapNodeItem
      {
         return _itemList[param1];
      }
      
      private function positionConvert(param1:int) : int
      {
         return param1 * 2.5 + 1;
      }
      
      private function __memberClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:int = int((_memberDic[param1.target] as BaseArmy).userId);
         FreedomTeamManager.instance.model.followId = _loc2_;
         NotificationManager.instance.sendNotification("LOCK_TEAM_FOLLOW_TARGET",_loc2_);
      }
      
      private function __nodeClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:CampaignNode = _nodeDic[param1.target] as CampaignNode;
         CampaignManager.instance.mapModel.selectNode = _loc2_;
         CampaignManager.instance.controller.moveArmyByPos(_loc2_.curPosX * 20,_loc2_.curPosY * 20,true);
      }
      
      private function updateContainerVisible() : void
      {
         _nodeContainer1.visible = _optionBtn2.selected;
         _nodeContainer2.visible = _optionBtn1.selected;
         _nodeContainer3.visible = _optionBtn3.selected;
      }
      
      public function show() : void
      {
         _rect = new Rectangle(0,0,704,500);
         TreasureMapManager.instance.model.mapFrameOpened = true;
         TreasureMapManager.instance.model.commit();
         __treasureInfoUpdateHandler(null);
         LayerManager.Instance.addToLayer(this,3,true,true);
         SoundManager.instance.play("022");
      }
      
      public function isInvalidClick(param1:DisplayObject) : Boolean
      {
         if(param1 == _mapContainer || _nodeDic[param1] || isMapNodeItem(param1))
         {
            return false;
         }
         return true;
      }
      
      private function isMapNodeItem(param1:DisplayObject) : Boolean
      {
         var _loc2_:CampaignMapNodeItem = param1.parent as CampaignMapNodeItem;
         if(_loc2_ && _loc2_.data)
         {
            return true;
         }
         return false;
      }
      
      override public function dispose() : void
      {
         var _loc1_:DisplayObject = null;
         TreasureMapManager.instance.model.mapFrameOpened = false;
         TreasureMapManager.instance.model.commit();
         if(_self)
         {
            TweenLite.killTweensOf(_self);
         }
         removeEvent();
         if(_vBox)
         {
            _vBox.disposeAllChildren();
            _vBox.removeAllChild();
            _vBox = null;
         }
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _nodeContainer1.numChildren)
         {
            _loc1_ = _nodeContainer1.getChildAt(_loc2_);
            _loc1_.removeEventListener("click",__nodeClickHandler);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _nodeContainer2.numChildren)
         {
            _loc1_ = _nodeContainer2.getChildAt(_loc2_);
            _loc1_.removeEventListener("click",__nodeClickHandler);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _nodeContainer3.numChildren)
         {
            _loc1_ = _nodeContainer3.getChildAt(_loc2_);
            _loc1_.removeEventListener("click",__nodeClickHandler);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _teamContainer.numChildren)
         {
            _loc1_ = _teamContainer.getChildAt(_loc2_);
            _loc1_.removeEventListener("click",__memberClickHandler);
            _loc2_++;
         }
         ObjectUtils.disposeAllChildren(_mapContainer);
         _mapContainer = null;
         ObjectUtils.disposeAllChildren(_pathContainer);
         _pathContainer = null;
         ObjectUtils.disposeAllChildren(_nodeContainer1);
         _pathContainer = null;
         ObjectUtils.disposeAllChildren(_nodeContainer2);
         _pathContainer = null;
         ObjectUtils.disposeAllChildren(_nodeContainer3);
         _pathContainer = null;
         ObjectUtils.disposeAllChildren(_teamContainer);
         _teamContainer = null;
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_rightBg);
         _rightBg = null;
         ObjectUtils.disposeObject(_leftTitleBg);
         _leftTitleBg = null;
         ObjectUtils.disposeObject(_leftTitleImg);
         _leftTitleImg = null;
         ObjectUtils.disposeObject(_optionBtn1);
         _optionBtn1 = null;
         ObjectUtils.disposeObject(_optionBtn2);
         _optionBtn2 = null;
         ObjectUtils.disposeObject(_optionBtn3);
         _optionBtn3 = null;
         ObjectUtils.disposeObject(_walkTarget);
         _walkTarget = null;
         ObjectUtils.disposeObject(_mapImg);
         _mapImg = null;
         ObjectUtils.disposeObject(_self);
         _self = null;
         ObjectUtils.disposeObject(_rightTitleImg);
         _rightTitleImg = null;
         ObjectUtils.disposeObject(_rightTitleline);
         _rightTitleline = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeAllChildren(this);
         _model = null;
         _selfArmyView = null;
         _pathPointDic = null;
         _itemList = null;
         super.dispose();
      }
   }
}

