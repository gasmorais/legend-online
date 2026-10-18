package map.campaign.view.frame
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ObjectsEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.view.ui.DownTimeView;
   import map.internals.data.CampaignNode;
   import map.internals.utils.PathPointUtils;
   import map.internals.view.frame.PathPoint;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.NotificationManager;
   
   public class GodsEveningMapFrame extends Frame implements IEnterFrame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _rightBg:Image;
      
      private var _countDownImage:Image;
      
      private var _mapImg:Bitmap;
      
      private var _mapContainer:Sprite;
      
      private var _self:Bitmap;
      
      private var _nodeContainer:Sprite;
      
      private var _walkTarget:MovieClip;
      
      private var _vBox:VBox;
      
      private var _flushtime:int;
      
      private var _model:CampaignMapModel;
      
      private var _selfArmy:CampaignArmy;
      
      private var _selfArmyView:Object;
      
      private var _nodeDic:Dictionary;
      
      private var _itemList:Array;
      
      private var _path:Array;
      
      private var _pathPointDic:Dictionary;
      
      private var _pathContainer:Sprite;
      
      private var _showTypes:Array = [41,42,91];
      
      private var _goddessWarning1:MovieClip;
      
      private var _goddessWarning2:MovieClip;
      
      private var _goddessWarning3:MovieClip;
      
      private var _goddessNodeIds:Array = [850110,850111,850112];
      
      private var _goddessNodeDic:Dictionary;
      
      private var _goddessNodeNameDic:Dictionary;
      
      private var _goddessFollowTargetDic:Dictionary;
      
      private var _goddessFlushTimeDic:Dictionary;
      
      private var _firstSyn:Boolean = true;
      
      private var _downTime:DownTimeView;
      
      public function GodsEveningMapFrame()
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
         _bg = ComponentFactory.Instance.creatComponentByStylename("map.campaign.view.frame.GodsEveningMapFrame.bg");
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("map.campaign.view.frame.GodsEveningMapFrame.rightBg");
         _countDownImage = ComponentFactory.Instance.creatComponentByStylename("map.campaign.view.frame.GodsEveningMapFrame.countDownImg");
         _mapContainer = ComponentFactory.Instance.creatCustomObject("map.space.SpaceMapFrame.Container");
         _mapImg = ComponentFactory.Instance.creatBitmap("asset.space.SpaceMapFrame.MapImg" + _model.mapId);
         _self = ComponentFactory.Instance.creatBitmap("asset.space.SpaceMapFrame.SelfAsset");
         _walkTarget = ComponentFactory.Instance.creatCustomObject("map.space.SpaceMapFrame.WalkTarget");
         _goddessWarning1 = ComponentFactory.Instance.creatCustomObject("asset.GodsEveningMapFrame.warning");
         _goddessWarning2 = ComponentFactory.Instance.creatCustomObject("asset.GodsEveningMapFrame.warning");
         _goddessWarning3 = ComponentFactory.Instance.creatCustomObject("asset.GodsEveningMapFrame.warning");
         _downTime = new DownTimeView(true);
         _downTime.x = 687;
         _downTime.y = 8;
         _nodeContainer = new Sprite();
         _pathContainer = new Sprite();
         _mapContainer.addChild(_mapImg);
         _mapContainer.addChild(_nodeContainer);
         _mapContainer.addChild(_self);
         _mapContainer.addChild(_walkTarget);
         _mapContainer.addChild(_goddessWarning1);
         _mapContainer.addChild(_goddessWarning2);
         _mapContainer.addChild(_goddessWarning3);
         _mapContainer.addChild(_pathContainer);
         _mapContainer.mask = createShape(646,491);
         _vBox = new VBox();
         _vBox.spacing = 4;
         _vBox.x = 680;
         _vBox.y = 70;
         _vBox.mouseEnabled = false;
         addToContent(_bg);
         addToContent(_rightBg);
         addToContent(_mapContainer);
         addToContent(_countDownImage);
         addToContent(_downTime);
         addToContent(_vBox);
         _walkTarget.mouseChildren = _walkTarget.mouseEnabled = false;
         _walkTarget.scrollRect = null;
         _walkTarget.visible = false;
         _goddessWarning1.mouseChildren = _goddessWarning1.mouseEnabled = false;
         _goddessWarning1.scrollRect = null;
         _goddessWarning1.visible = false;
         _goddessWarning2.mouseChildren = _goddessWarning2.mouseEnabled = false;
         _goddessWarning2.scrollRect = null;
         _goddessWarning2.visible = false;
         _goddessWarning3.mouseChildren = _goddessWarning3.mouseEnabled = false;
         _goddessWarning3.scrollRect = null;
         _goddessWarning3.visible = false;
         _self.x = positionConvert(_selfArmyView.x * 0.05) - _self.width * 0.5;
         _self.y = positionConvert(_selfArmyView.y * 0.05) - _self.height * 0.5;
         syncSelfPosition();
         initNodePosition();
         syncSelfPath();
         initGoddessInfo();
         titleText = LanguageMgr.GetTranslation("mainBar.TopToolsBar.godsEvening");
         _downTime.count = GodsEveningManager.instance.model.leftTime / 1000;
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rightBg);
         _rightBg = null;
         ObjectUtils.disposeObject(_countDownImage);
         _countDownImage = null;
         ObjectUtils.disposeObject(_downTime);
         _downTime = null;
         _vBox.disposeAllChildren();
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_mapImg);
         _mapImg = null;
         ObjectUtils.disposeAllChildren(_nodeContainer);
         ObjectUtils.disposeObject(_nodeContainer);
         _nodeContainer = null;
         ObjectUtils.disposeObject(_self);
         _self = null;
         ObjectUtils.disposeObject(_walkTarget);
         _walkTarget = null;
         ObjectUtils.disposeObject(_goddessWarning1);
         _goddessWarning1 = null;
         ObjectUtils.disposeObject(_goddessWarning2);
         _goddessWarning2 = null;
         ObjectUtils.disposeObject(_goddessWarning3);
         _goddessWarning3 = null;
         ObjectUtils.disposeAllChildren(_pathContainer);
         ObjectUtils.disposeObject(_pathContainer);
         _pathContainer = null;
         ObjectUtils.disposeObject(_mapContainer);
         _mapContainer = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         addEventListener("response",__frameResponse);
         _mapContainer.addEventListener("click",__mapClickHandler);
         _model.addEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
         NotificationManager.instance.addEventListener("GODS_EVENING_GODDESS",__goddessInfoHandler);
         _selfArmyView.addEventListener("WALK_NEXT",__walkNextHandler);
         _selfArmyView.addEventListener("walkOver",__walkOverHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         removeEventListener("response",__frameResponse);
         _mapContainer.removeEventListener("click",__mapClickHandler);
         _model.removeEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
         NotificationManager.instance.removeEventListener("GODS_EVENING_GODDESS",__goddessInfoHandler);
         _selfArmyView.removeEventListener("WALK_NEXT",__walkNextHandler);
         _selfArmyView.removeEventListener("walkOver",__walkOverHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
      
      private function __walkOverHandler(param1:ObjectsEvent) : void
      {
         if(_walkTarget)
         {
            _walkTarget.visible = false;
         }
         ObjectUtils.disposeAllChildren(_pathContainer);
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
            GodsEveningManager.instance.model.selfFowllowingArmy = null;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("LOCK_PVP_WARFIGHT",null));
         }
      }
      
      private function __mapClickHandler(param1:MouseEvent) : void
      {
         if(param1.target is BaseButton)
         {
            return;
         }
         GodsEveningManager.instance.model.selfFowllowingArmy = null;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("LOCK_PVP_WARFIGHT",null));
         var _loc3_:int = param1.localX * 1000 / 82;
         var _loc2_:int = param1.localY * 1000 / 82;
         CampaignManager.instance.controller.moveArmyByPos(_loc3_,_loc2_,true);
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
      
      private function __goddessInfoHandler(param1:NotificationEvent) : void
      {
         var _loc2_:CampaignArmy = param1.data as CampaignArmy;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.isDie == 12 || _loc2_.isDie == 10)
         {
            _goddessFollowTargetDic[_loc2_.baseHero.serviceName + "_" + _loc2_.id] = _loc2_;
         }
      }
      
      private function initGoddessInfo() : void
      {
         var _loc2_:int = 0;
         _goddessFlushTimeDic = new Dictionary();
         _loc2_ = 1;
         while(_loc2_ <= 3)
         {
            _goddessFlushTimeDic[_loc2_] = 0;
            _loc2_++;
         }
         for each(var _loc1_:CampaignArmy in _model.allUserArmy)
         {
            if(_loc1_.isDie == 12 || _loc1_.isDie == 10)
            {
               _goddessFollowTargetDic[_loc1_.baseHero.serviceName + "_" + _loc1_.id] = _loc1_;
            }
         }
      }
      
      public function enterFrame() : void
      {
         syncSelfPosition();
         synGoddessPosition();
         var _loc1_:CampaignArmy = GodsEveningManager.instance.model.selfFowllowingArmy;
         if(_loc1_)
         {
            syncSelfPath(new Point(_loc1_.curPosX * 20,_loc1_.curPosY * 20));
         }
      }
      
      private function getCampaignNodeByGodDessId(param1:int) : CampaignNode
      {
         for each(var _loc2_:CampaignNode in _model.mapNodesData)
         {
            if(_loc2_.nodeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function synGoddessPosition() : void
      {
         var _loc2_:CampaignNode = null;
         var _loc1_:BaseButton = null;
         var _loc8_:FilterFrameText = null;
         var _loc7_:MovieClip = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         _goddessWarning1.visible = _goddessWarning2.visible = _goddessWarning3.visible = false;
         for each(var _loc11_:CampaignArmy in _goddessFollowTargetDic)
         {
            if(_loc11_)
            {
               if(_loc11_.isDie != 12 && _loc11_.isDie != 10)
               {
                  delete _goddessFollowTargetDic[_loc11_.baseHero.serviceName + "_" + _loc11_.id];
               }
               else
               {
                  _loc2_ = getCampaignNodeByGodDessId(_loc11_.goddessId);
                  _loc1_ = _goddessNodeDic[_loc2_.param1];
                  _loc8_ = _goddessNodeNameDic[_loc2_.param1];
                  _loc7_ = this["_goddessWarning" + _loc2_.param1];
                  if(_loc1_)
                  {
                     _loc5_ = positionConvert(_loc11_.curPosX) - _loc1_.width * 0.5;
                     _loc6_ = positionConvert(_loc11_.curPosY) - _loc1_.height * 0.5;
                     _loc9_ = _loc5_ - (_loc8_.width - _loc1_.width) * 0.5;
                     _loc10_ = _loc6_ - _loc8_.height;
                     _loc3_ = _loc5_ + _loc1_.width * 0.5;
                     _loc4_ = _loc6_ + _loc1_.height * 0.5;
                     _loc12_ = getTimer();
                     _loc13_ = int(getCampaignNodeByGodDessId(_loc11_.goddessId).param1);
                     if(_loc12_ - _goddessFlushTimeDic[_loc13_] > 200)
                     {
                        _goddessFlushTimeDic[_loc13_] = _loc12_;
                        if(_firstSyn)
                        {
                           _loc1_.x = _loc5_;
                           _loc1_.y = _loc6_;
                           _loc8_.x = _loc9_;
                           _loc8_.y = _loc10_;
                           _loc7_.x = _loc3_;
                           _loc7_.y = _loc4_;
                        }
                        else
                        {
                           TweenLite.killTweensOf(_loc1_);
                           TweenLite.killTweensOf(_loc8_);
                           TweenLite.killTweensOf(_loc7_);
                           TweenLite.to(_loc1_,0.2,{
                              "x":_loc5_,
                              "y":_loc6_
                           });
                           TweenLite.to(_loc8_,0.2,{
                              "x":_loc9_,
                              "y":_loc10_
                           });
                           TweenLite.to(_loc7_,0.2,{
                              "x":_loc3_,
                              "y":_loc4_
                           });
                        }
                        _firstSyn = false;
                     }
                     _loc7_.visible = true;
                  }
               }
            }
         }
      }
      
      private function positionConvert(param1:int) : int
      {
         return param1 * 1.64 + 1;
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
         var _loc4_:CampaignNode = null;
         var _loc1_:BaseButton = null;
         var _loc7_:FilterFrameText = null;
         var _loc5_:GodsEveningMapNodeItem = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         _nodeDic = new Dictionary();
         _goddessNodeDic = new Dictionary();
         _goddessNodeNameDic = new Dictionary();
         _goddessFollowTargetDic = new Dictionary();
         _itemList = [];
         var _loc6_:Array = _model.mapNodesData;
         var _loc3_:int = 0;
         _loc3_;
         while(_loc3_ < _loc6_.length)
         {
            _loc4_ = _loc6_[_loc3_] as CampaignNode;
            if(_showTypes.indexOf(_loc4_.info.types) != -1)
            {
               if(_loc4_.info.state != 9)
               {
                  if(!(_loc4_.info.state == 8 && _goddessNodeIds.indexOf(_loc4_.nodeId) == -1))
                  {
                     if(!(_loc4_.info.types == 91 && _loc4_.param2 != 5))
                     {
                        _loc1_ = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.NPCBtn");
                        _loc7_ = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.NodeNameTxt");
                        _loc7_.mouseEnabled = false;
                        _loc7_.text = _loc4_.info.names;
                        _nodeContainer.addChild(_loc1_);
                        _nodeContainer.addChild(_loc7_);
                        _loc1_.x = positionConvert(_loc4_.curPosX) - _loc1_.width * 0.5;
                        _loc1_.y = positionConvert(_loc4_.curPosY) - _loc1_.height * 0.5;
                        if(_loc4_.nodeId == 850110)
                        {
                           _loc9_ = 30;
                        }
                        else if(_loc4_.nodeId == 850170)
                        {
                           _loc9_ = -10;
                        }
                        else
                        {
                           _loc9_ = 0;
                        }
                        _loc7_.x = _loc1_.x - (_loc7_.width - _loc1_.width) * 0.5 + _loc9_;
                        _loc7_.y = _loc1_.y - _loc7_.height;
                        _loc1_.addEventListener("click",__nodeClickHandler);
                        _nodeDic[_loc1_] = _loc4_;
                        if(_goddessNodeIds.indexOf(_loc4_.nodeId) != -1)
                        {
                           _goddessNodeDic[_loc4_.param1] = _loc1_;
                           _goddessNodeNameDic[_loc4_.param1] = _loc7_;
                        }
                        if(_loc4_.param2 != 5)
                        {
                           _loc5_ = new GodsEveningMapNodeItem();
                           _loc5_.data = _loc4_;
                           _itemList.push(_loc5_);
                        }
                     }
                  }
               }
            }
            _loc3_++;
         }
         _itemList.sort(sortFun);
         _vBox.removeAllChild();
         _vBox.beginChanges();
         for each(var _loc2_:GodsEveningMapNodeItem in _itemList)
         {
            _vBox.addChild(_loc2_);
         }
         _vBox.commitChanges();
      }
      
      private function sortFun(param1:GodsEveningMapNodeItem, param2:GodsEveningMapNodeItem) : int
      {
         var _loc4_:CampaignNode = param1.data;
         var _loc3_:CampaignNode = param2.data;
         if(_loc4_.param1 > _loc3_.param1)
         {
            return 1;
         }
         if(_loc4_.param1 < _loc3_.param1)
         {
            return -1;
         }
         if(_loc4_.param2 > _loc3_.param2)
         {
            return 1;
         }
         return -1;
      }
      
      private function __nodeClickHandler(param1:MouseEvent) : void
      {
         var _loc5_:CampaignArmy = null;
         SoundManager.instance.play("022");
         var _loc2_:BaseButton = param1.target as BaseButton;
         var _loc4_:CampaignNode = _nodeDic[_loc2_] as CampaignNode;
         if(_loc4_.param2 == 3)
         {
            for each(var _loc3_:CampaignArmy in _goddessFollowTargetDic)
            {
               if(_loc2_ == _goddessNodeDic[getCampaignNodeByGodDessId(_loc3_.goddessId).param1])
               {
                  _loc5_ = _loc3_;
               }
            }
         }
         CampaignManager.instance.mapModel.selectNode = _loc4_;
         if(_loc5_)
         {
            if(!(_loc5_.userId == _selfArmy.userId && _loc5_.baseHero.serviceName == _selfArmy.baseHero.serviceName))
            {
               GodsEveningManager.instance.model.selfFowllowingArmy = _loc5_;
               NotificationManager.instance.dispatchEvent(new NotificationEvent("LOCK_PVP_WARFIGHT",_loc5_));
            }
         }
         else
         {
            GodsEveningManager.instance.model.selfFowllowingArmy = null;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("LOCK_PVP_WARFIGHT",null));
            CampaignManager.instance.mapModel.selectNode = _loc4_;
            CampaignManager.instance.controller.moveArmyByPos(_loc4_.curPosX * 20,_loc4_.curPosY * 20,true);
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
         var _loc4_:int = int(_selfArmyView.info.walkIndex);
         if(!_selfArmyView.info.pathInfo || _selfArmyView.info.pathInfo.length == 0)
         {
            return;
         }
         if(!_loc3_)
         {
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
      
      private function createShape(param1:int, param2:int) : Shape
      {
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginFill(16777215,0);
         _loc3_.graphics.drawRect(-10,-5,param1,param2);
         _loc3_.graphics.endFill();
         addToContent(_loc3_);
         return _loc3_;
      }
      
      public function show() : void
      {
         SoundManager.instance.play("022");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
   }
}

