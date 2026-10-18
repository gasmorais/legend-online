package map.space.view.frame
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
   import managers.RingTaskManager;
   import managers.TreasureMapManager;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.data.SpaceNode;
   import map.internals.utils.PathPointUtils;
   import map.internals.view.frame.PathPoint;
   import map.space.SpaceManager;
   import map.space.SpaceModel;
   import map.space.data.SpaceArmy;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.ringtask.RingTask;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.BaseManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class SpaceMapFrame extends Frame implements IEnterFrame, IManualSize
   {
      
      private const FRAME_WIDTH:int = 895;
      
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
      
      private var _model:SpaceModel;
      
      private var _selfArmy:SpaceArmy;
      
      private var _selfArmyView:Object;
      
      private var _nodeDic:Dictionary;
      
      private var _textDic:Dictionary;
      
      private var _syncSelfPositionFlag:Boolean = true;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _pathPointDic:Dictionary;
      
      private var _itemList:Dictionary;
      
      private var _memberDic:Dictionary;
      
      private var _memberList:Dictionary;
      
      private var _flushtime:int;
      
      private var _showTypes:Array = [61,171];
      
      public function SpaceMapFrame()
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
         _model = SpaceManager.instance.model;
         _selfArmy = _model.selfArmy;
         _selfArmyView = SpaceManager.instance.controller.getArmyView(_selfArmy);
         _pathPointDic = new Dictionary(true);
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
         _mapImg = ComponentFactory.Instance.creatBitmap("asset.space.SpaceMapFrame.MapImg");
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
         _mapContainer.addChild(_mapImg);
         _mapContainer.addChild(_nodeContainer1);
         _mapContainer.addChild(_nodeContainer2);
         _mapContainer.addChild(_nodeContainer3);
         _mapContainer.addChild(_teamContainer);
         _mapContainer.addChild(_self);
         _mapContainer.addChild(_pathContainer);
         _mapContainer.addChild(_walkTarget);
         _mapContainer.mask = createShape(691,476);
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
         _leftBg.width = 556;
         _leftBg.height = 363;
         addToContent(_rightBg);
         _rightBg.x = 546;
         _rightBg.y = 0;
         _rightBg.width = 269;
         _rightBg.height = 362;
         addToContent(_mapContainer);
         addToContent(_leftTitleBg);
         _leftTitleBg.x = 6;
         _leftTitleBg.y = 321;
         addToContent(_leftTitleImg);
         _leftTitleImg.x = 12;
         _leftTitleImg.y = 326;
         addToContent(_optionBtn1);
         _optionBtn1.x = 132;
         _optionBtn1.y = 326;
         addToContent(_optionBtn2);
         _optionBtn2.x = 222;
         _optionBtn2.y = 326;
         addToContent(_optionBtn3);
         _optionBtn3.x = 292;
         _optionBtn3.y = 326;
         addToContent(_rightTitleImg);
         _rightTitleImg.x = 670;
         _rightTitleImg.y = 15;
         addToContent(_rightTitleline);
         _rightTitleline.x = 552;
         _rightTitleline.y = 35;
         addToContent(_scrollPanel);
         _scrollPanel.height = 314;
         _scrollPanel.x = 552;
         _scrollPanel.y = 37;
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
         _selfArmyView.aiInfo.addEventListener("WALK_NEXT",__walkNextHandler);
         _selfArmyView.aiInfo.addEventListener("walkOver",__walkOverHandler);
         NotificationManager.instance.addEventListener("TEAM_INFO_UPDATE",__updateTeamInfoHandler);
         NotificationManager.instance.addEventListener("TEAM_INFO_SYNC",__syncTeamInfoHandler);
         TreasureMapManager.instance.model.addEventListener("TREASURE_INFO_UPDATE",__treasureInfoUpdateHandler);
         NotificationManager.instance.addEventListener("SPACE_NPC_VISIBLE",__refreshNpcBtnHandler);
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
         _selfArmyView.aiInfo.removeEventListener("WALK_NEXT",__walkNextHandler);
         _selfArmyView.aiInfo.removeEventListener("walkOver",__walkOverHandler);
         NotificationManager.instance.removeEventListener("TEAM_INFO_UPDATE",__updateTeamInfoHandler);
         NotificationManager.instance.removeEventListener("TEAM_INFO_SYNC",__syncTeamInfoHandler);
         TreasureMapManager.instance.model.removeEventListener("TREASURE_INFO_UPDATE",__treasureInfoUpdateHandler);
         NotificationManager.instance.removeEventListener("SPACE_NPC_VISIBLE",__refreshNpcBtnHandler);
      }
      
      private function __treasureInfoUpdateHandler(param1:TreasureMapEvent) : void
      {
         if(TreasureMapManager.instance.model.useFrameOpened)
         {
            _rect.width = 248;
         }
         else
         {
            _rect.width = 895;
         }
         x = (StageReferance.gameStageWidth - _rect.width) / 2;
      }
      
      private function __mapClickHandler(param1:MouseEvent) : void
      {
         if(param1.target is BaseButton)
         {
            return;
         }
         var _loc3_:int = param1.localX * 16.6;
         var _loc2_:int = param1.localY * 16.6;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         else if(_loc3_ > _model.mapTempInfo.Width)
         {
            _loc3_ = int(_model.mapTempInfo.Width);
         }
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         else if(_loc2_ > _model.mapTempInfo.Height)
         {
            _loc2_ = int(_model.mapTempInfo.Height);
         }
         SpaceManager.instance.controller.moveArmyByPos(_loc3_,_loc2_,true);
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
            _walkTarget.x = positionConvert(_loc3_.x) - 11;
            _walkTarget.y = positionConvert(_loc3_.y) - 6;
         }
         else
         {
            _path = _selfArmyView.aiInfo.pathInfo.slice();
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
         var _loc7_:SpaceNode = null;
         var _loc1_:BaseButton = null;
         var _loc4_:BaseButton = null;
         var _loc10_:FilterFrameText = null;
         var _loc8_:MapNodeItem = null;
         var _loc12_:RingTask = null;
         var _loc2_:OfferRewardConditionTemplate = null;
         _nodeDic = new Dictionary(true);
         _textDic = new Dictionary(true);
         _itemList = new Dictionary(true);
         var _loc11_:Array = [];
         var _loc3_:Array = [];
         var _loc9_:Array = _model.mapNodesData;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc9_.sortOn("sort",16);
         _loc5_;
         for(; _loc5_ < _loc9_.length; _loc5_++)
         {
            _loc7_ = _loc9_[_loc5_] as SpaceNode;
            if(_showTypes.indexOf(_loc7_.info.types) != -1)
            {
               _loc10_ = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.NodeNameTxt");
               _loc10_.mouseEnabled = false;
               if(_loc7_.info.types == 171)
               {
                  _loc10_.text = _loc7_.info.names;
                  _loc4_ = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.TransferBtn");
                  _nodeContainer1.addChild(_loc4_);
                  _nodeContainer1.addChild(_loc10_);
                  _loc4_.x = positionConvert(_loc7_.curPosX) - _loc4_.width * 0.5;
                  _loc4_.y = positionConvert(_loc7_.curPosY) - 40;
                  _loc10_.x = _loc4_.x - (_loc10_.width - _loc4_.width) * 0.5;
                  _loc10_.y = _loc4_.y;
                  if(_loc10_.y <= _loc10_.height)
                  {
                     _loc10_.y = _loc4_.y + 50;
                  }
                  if(_loc7_.nodeId == 5)
                  {
                     _loc10_.y += 42;
                  }
                  _loc4_.addEventListener("click",__nodeClickHandler);
                  _nodeDic[_loc4_] = _loc7_;
                  _textDic[_loc10_] = _loc7_;
               }
               else
               {
                  if(_loc7_.nodeId == 18)
                  {
                     _loc12_ = RingTaskManager.instance.getRingTask();
                     if(!_loc12_)
                     {
                        continue;
                     }
                     _loc2_ = _loc12_.conditionList[0] as OfferRewardConditionTemplate;
                     if(_loc2_.CondictionType != 4)
                     {
                        continue;
                     }
                     if(_loc2_.Para1 + "" != _loc7_.param4)
                     {
                        continue;
                     }
                     if(_loc12_.isCompleted)
                     {
                        continue;
                     }
                  }
                  _loc10_.text = _loc7_.funcType;
                  _loc1_ = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.NPCBtn");
                  _nodeContainer2.addChild(_loc1_);
                  _nodeContainer2.addChild(_loc10_);
                  _loc1_.x = positionConvert(_loc7_.curPosX) - _loc1_.width * 0.5;
                  _loc1_.y = positionConvert(_loc7_.curPosY) - _loc1_.height * 0.5;
                  _loc10_.x = _loc1_.x - (_loc10_.width - _loc1_.width) * 0.5;
                  _loc10_.y = _loc1_.y - _loc10_.height;
                  if(_loc11_.indexOf(_loc7_.nodeId) != -1)
                  {
                     _loc10_.x = _loc1_.x - (_loc10_.width - _loc1_.width);
                  }
                  if(_loc3_.indexOf(_loc7_.nodeId) != -1)
                  {
                     _loc10_.x = _loc1_.x;
                  }
                  if(_loc7_.nodeId == 22)
                  {
                     _loc10_.y += 30;
                  }
                  else if(_loc7_.nodeId == 3)
                  {
                     _loc10_.x -= 35;
                     _loc10_.y += 15;
                  }
                  else if(_loc7_.nodeId == 31)
                  {
                     _loc10_.x -= 33;
                     _loc10_.y += 5;
                  }
                  else if(_loc7_.nodeId == 4)
                  {
                     _loc10_.y += 30;
                  }
                  else if(_loc7_.nodeId == 53)
                  {
                     _loc10_.x += 35;
                     _loc10_.y += 15;
                  }
                  else if(_loc7_.nodeId == 39)
                  {
                     _loc10_.y += 6;
                  }
                  else if(_loc7_.nodeId == 1)
                  {
                     _loc10_.x += 35;
                  }
                  else if(_loc7_.nodeId == 37)
                  {
                     _loc10_.y += 30;
                  }
                  else if(_loc7_.nodeId == 46)
                  {
                     _loc10_.y = 195;
                     _loc10_.x = 1;
                  }
                  else if(_loc7_.nodeId == 32)
                  {
                     _loc10_.x = 255;
                     _loc10_.y = 130;
                  }
                  else if(_loc7_.nodeId == 44)
                  {
                     _loc10_.x = 134;
                     _loc10_.y = 140;
                  }
                  else if(_loc7_.nodeId == 51)
                  {
                     _loc10_.x = 408;
                     _loc10_.y = 235;
                  }
                  else if(_loc7_.nodeId == 48)
                  {
                     _loc10_.x = 210;
                     _loc10_.y = 250;
                  }
                  else if(_loc7_.nodeId == 43)
                  {
                     _loc10_.x = 174;
                     _loc10_.y = 305;
                  }
                  else if(_loc7_.nodeId == 49)
                  {
                     _loc10_.x = 295;
                     _loc10_.y = 278;
                  }
                  else if(_loc7_.nodeId == 52)
                  {
                     _loc10_.x = 330;
                     _loc10_.y = 237;
                  }
                  else if(_loc7_.nodeId == 45)
                  {
                     _loc10_.x = 60;
                     _loc10_.y = 307;
                  }
                  _loc1_.addEventListener("click",__nodeClickHandler);
                  _nodeDic[_loc1_] = _loc7_;
                  _textDic[_loc10_] = _loc7_;
                  _loc1_.visible = checkIsNeedShow(_loc7_);
                  _loc10_.visible = checkIsNeedShow(_loc7_);
               }
               if(_loc10_.text == " Arena Einherjar")
               {
                  _loc10_.x = 375;
                  _loc10_.y = 106;
               }
               if(_loc10_.text == " Expedição de Einherjar")
               {
                  _loc10_.x = 350;
                  _loc10_.y = 90;
               }
               if(_loc10_.text == " Caminho do Céu")
               {
                  _loc10_.x = 415;
                  _loc10_.y = 76;
               }
               if(_loc10_.text == "Ilha dos Einherjars")
               {
                  _loc10_.x = 425;
                  _loc10_.y = 120;
               }
               if(_loc10_.text == " Troca de Einherjar")
               {
                  _loc10_.x = 425;
                  _loc10_.y = 145;
               }
               if(_loc10_.text == " Missão de Ciclo")
               {
                  _loc10_.x = 110;
                  _loc10_.y = 85;
               }
               if(_loc10_.text == "Carro de Casamento")
               {
                  _loc10_.x = 0;
               }
               if(_loc10_.text == " Caminho da Glória")
               {
                  _loc10_.y = 217;
               }
               if(checkIsNeedShow(_loc7_))
               {
                  _scrollPanel.beginChanges();
                  _loc8_ = new MapNodeItem();
                  _loc8_.data = _loc7_;
                  _itemList[_loc7_.nodeId] = _loc8_;
                  _vBox.addChild(_loc8_);
                  _vBox.refreshChildPos();
                  _scrollPanel.commitChanges();
                  _loc6_++;
               }
            }
         }
         _loc6_;
         while(_loc6_ < 16)
         {
            _scrollPanel.beginChanges();
            _loc8_ = new MapNodeItem();
            _vBox.addChild(_loc8_);
            _vBox.refreshChildPos();
            _scrollPanel.commitChanges();
            _loc6_++;
         }
         __refreshNpcBtnHandler(null);
         _scrollPanel.invalidateViewport();
      }
      
      private function checkIsNeedShow(param1:SpaceNode) : Boolean
      {
         if(param1.info.id == 32)
         {
            if(!ConfigManager.info.NEW_YEAR_MODULE || !ConfigManager.info.NEW_YEAR_BEGIN_DATE || !ConfigManager.info.NEW_YEAR_END_DATE || ConfigManager.info.NEW_YEAR_BEGIN_DATE.time > playerModel.nowDate || ConfigManager.info.NEW_YEAR_END_DATE.time <= playerModel.nowDate)
            {
               return false;
            }
         }
         return true;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __refreshNpcBtnHandler(param1:NotificationEvent = null) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:MapNodeItem = null;
         var _loc8_:Array = BaseManager.instance.checkIsNeedShow();
         _loc5_ = 0;
         while(_loc5_ < _loc8_.length)
         {
            _loc6_ = int((_loc8_[_loc5_] as Array)[0]);
            _loc3_ = Boolean((_loc8_[_loc5_] as Array)[1]);
            for(var _loc7_ in _nodeDic)
            {
               if((_nodeDic[_loc7_] as SpaceNode).info.id == _loc6_)
               {
                  (_loc7_ as DisplayObject).visible = _loc3_;
               }
            }
            for(var _loc2_ in _textDic)
            {
               if((_textDic[_loc2_] as SpaceNode).info.id == _loc6_)
               {
                  (_loc2_ as DisplayObject).visible = _loc3_;
               }
            }
            if(_loc3_)
            {
               if(!_itemList[_loc6_])
               {
                  _scrollPanel.beginChanges();
                  _loc4_ = new MapNodeItem();
                  _loc4_.data = _model.getMapNodeById(_loc6_);
                  _itemList[_loc6_] = _loc4_;
                  _vBox.addChild(_loc4_);
                  _vBox.refreshChildPos();
                  _scrollPanel.commitChanges();
               }
            }
            else if(_itemList[_loc6_] && (_itemList[_loc6_] as MapNodeItem).parent)
            {
               _scrollPanel.beginChanges();
               _vBox.removeChild(_itemList[_loc6_]);
               _vBox.refreshChildPos();
               _scrollPanel.commitChanges();
               delete _itemList[_loc6_];
            }
            _loc5_++;
         }
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
      
      public function scrollItemPosCheck(param1:DisplayObject) : void
      {
         var _loc2_:Rectangle = param1["viewRectangle"];
         if(param1.y >= _loc2_.height * 16)
         {
            _scrollPanel.vScrollbar.scrollValue = param1.y - _loc2_.height * (16 - 1);
         }
      }
      
      public function getMapNodeItemByNodeId(param1:int) : MapNodeItem
      {
         return _itemList[param1];
      }
      
      private function positionConvert(param1:int) : int
      {
         return param1 * 1.2 + 1;
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
         var _loc2_:int = int((_nodeDic[param1.target] as SpaceNode).nodeId);
         SpaceManager.instance.visitSpaceNPC(_loc2_);
      }
      
      private function updateContainerVisible() : void
      {
         _nodeContainer1.visible = _optionBtn2.selected;
         _nodeContainer2.visible = _optionBtn1.selected;
         _nodeContainer3.visible = _optionBtn3.selected;
      }
      
      public function show() : void
      {
         _rect = new Rectangle(0,0,895,500);
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
         var _loc2_:MapNodeItem = param1.parent as MapNodeItem;
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
         _pathContainer = null;
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
         _selfArmy = null;
         _selfArmyView = null;
         _pathPointDic = null;
         _itemList = null;
         _textDic = null;
         _nodeDic = null;
         super.dispose();
      }
   }
}

