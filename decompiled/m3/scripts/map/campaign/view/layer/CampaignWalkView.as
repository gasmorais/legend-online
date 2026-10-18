package map.campaign.view.layer
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import managers.FreedomTeamManager;
   import managers.MarryManager;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.MarketModel;
   import map.campaign.data.StallInfo;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.mediator.layer.WalkDepthMediator;
   import map.campaign.mediator.layer.WalkTargetMediator;
   import map.campaign.view.physics.ActiveVehicleArmyView;
   import map.campaign.view.physics.CampaignArmyView;
   import map.campaign.view.physics.ConsortiaEmeDreamArmyView;
   import map.campaign.view.physics.DuskAreaWarFightArmyView;
   import map.campaign.view.physics.GodsEveningArmyView;
   import map.campaign.view.physics.GroupfbArmyView;
   import map.campaign.view.physics.HouseArmyView;
   import map.campaign.view.physics.MarketArmyView;
   import map.campaign.view.physics.MineralArmyView;
   import map.campaign.view.physics.MonopolyArmyView;
   import map.campaign.view.physics.PetLandArmyView;
   import map.campaign.view.physics.PvpWarFightArmyView;
   import map.campaign.view.physics.SumCampaignArmyView;
   import map.campaign.view.physics.UnrealShootingArmyView;
   import map.internals.data.CampaignNode;
   import map.internals.utils.ArmySpeedUtils;
   import map.internals.view.hero.helper.HeroAvatarViewHelper;
   import mvc.module.marry.MarryModel;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.utils.MsgMan;
   import yishi.utils.WorldBossHelper;
   
   public class CampaignWalkView extends Sprite implements IEnterFrame
   {
      
      public static const NAME:String = "map.campaign.view.layer.CampaignWalkView";
      
      protected var _armys:Dictionary;
      
      private var _filter:SimpleBuildingFilter = new SimpleBuildingFilter();
      
      protected var _model:CampaignMapModel;
      
      private var maxRenderPlayerNum:int = 99999;
      
      private var isLimitPlayerNum:Boolean = false;
      
      private var _selfArmyView:CampaignArmyView;
      
      protected var _controller:CampaignMapController;
      
      private var _mediatorKey:String;
      
      private var _items:Dictionary = new Dictionary(true);
      
      private var renderList:Array = [];
      
      public function CampaignWalkView()
      {
         super();
         _armys = new Dictionary(true);
         _controller = CampaignManager.instance.controller;
         _model = CampaignManager.instance.mapModel;
         if(WorldBossHelper.checkPetLand(_model.mapId))
         {
            isLimitPlayerNum = true;
            maxRenderPlayerNum = 50;
         }
         else if(WorldBossHelper.checkMineral(_model.mapId))
         {
            isLimitPlayerNum = true;
            maxRenderPlayerNum = 31;
         }
         else if(WorldBossHelper.checkWedding(_model.mapId))
         {
            isLimitPlayerNum = true;
            maxRenderPlayerNum = 30;
         }
         else if(WorldBossHelper.checkInHome(_model.mapId) || Boolean(WorldBossHelper.checkInHouse(_model.mapId)))
         {
            isLimitPlayerNum = true;
            maxRenderPlayerNum = 15;
         }
         else if(WorldBossHelper.checkMarket(_model.mapId))
         {
            isLimitPlayerNum = true;
            maxRenderPlayerNum = 20;
         }
         this.mouseEnabled = false;
         this.scrollRect = null;
         initRegisterList();
         addEvent();
      }
      
      protected function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         if(WorldBossHelper.checkWedding(_model.mapId) || Boolean(WorldBossHelper.checkPetLand(_model.mapId)) || Boolean(WorldBossHelper.checkMineral(_model.mapId)) || Boolean(WorldBossHelper.checkWorldBoss(_model.mapId)) || Boolean(WorldBossHelper.checkDuskArea(_model.mapId)) || Boolean(WorldBossHelper.checkFlameTemple(_model.mapId)) || Boolean(WorldBossHelper.checkIceFireTemple(_model.mapId)) || Boolean(WorldBossHelper.checkConsortiaEmeDream(_model.mapId)) || Boolean(WorldBossHelper.checkForbiddenBoss(_model.mapId)))
         {
            NotificationManager.instance.addEventListener("HIDE_OTHERS",__hideOthers);
         }
         if(WorldBossHelper.checkWedding(_model.mapId))
         {
            MsgMan.addObserver("MarryEventType.WEDDING_OATH",this,__oathHandler);
         }
      }
      
      private function __oathHandler(param1:String, param2:Object) : void
      {
         var _loc3_:* = null;
         if(WorldBossHelper.checkWedding(_model.mapId))
         {
            for each(_loc3_ in _items)
            {
               if(_loc3_.data.userId == marryModel.weddingInfo.userIdA)
               {
                  _loc3_.avatarView.angle = 210;
               }
               else if(_loc3_.data.userId == marryModel.weddingInfo.userIdB)
               {
                  _loc3_.avatarView.angle = 260;
               }
            }
         }
      }
      
      private function __hideOthers(param1:NotificationEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:Boolean = !SharedManager.instance.hideOthers;
         if(WorldBossHelper.checkPetLand(_model.mapId) || Boolean(WorldBossHelper.checkWorldBoss(_model.mapId)) || Boolean(WorldBossHelper.checkConsortiaEmeDream(_model.mapId)) || Boolean(WorldBossHelper.checkForbiddenBoss(_model.mapId)) || Boolean(WorldBossHelper.checkDuskArea(_model.mapId)) || Boolean(WorldBossHelper.checkFlameTemple(_model.mapId)) || Boolean(WorldBossHelper.checkIceFireTemple(_model.mapId)))
         {
            for each(_loc2_ in _items)
            {
               if(_loc2_.parent && _loc2_ != _selfArmyView && !_controller.checkNeedShowWhenHideOthers(_loc2_.data))
               {
                  _loc2_.isPlaying = _loc3_;
               }
            }
         }
         else if(WorldBossHelper.checkWedding(_model.mapId))
         {
            for each(_loc2_ in _items)
            {
               if(_loc2_.parent && _loc2_ != _selfArmyView && _loc2_.data.userId != marryModel.weddingInfo.userIdA && _loc2_.data.userId != marryModel.weddingInfo.userIdB)
               {
                  _loc2_.isPlaying = _loc3_;
               }
            }
         }
         if(_loc3_)
         {
            NotificationManager.instance.sendNotification("CHECK_PLAYING",null);
         }
      }
      
      private function initRegisterList() : void
      {
         var _loc1_:Array = [WalkDepthMediator,WalkTargetMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.campaign.view.layer.CampaignWalkView");
      }
      
      public function onClickHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      protected function initSelfArmy() : void
      {
         var _loc1_:CampaignArmy = _model.selfMemberData;
         if(_loc1_)
         {
            if(_loc1_.mapId != _model.mapId)
            {
               return;
            }
            if(_armys[_loc1_.key])
            {
               return;
            }
            if(!_loc1_.baseHero || !_loc1_.baseHero.templateInfo)
            {
               return;
            }
            _selfArmyView = createArmy(_loc1_);
            addItem(_selfArmyView);
            _selfArmyView.updateVisible();
         }
      }
      
      protected function initArmyList(param1:Dictionary) : void
      {
         var _loc2_:CampaignArmyView = null;
         for each(var _loc3_:CampaignArmy in param1)
         {
            if(!(!_loc3_.needInit && checkMapNeededInit()))
            {
               if(_loc3_.mapId == _model.mapId)
               {
                  if(!_armys[_loc3_.key])
                  {
                     if(!(!_loc3_.baseHero || !_loc3_.baseHero.templateInfo))
                     {
                        if(!(!checkDistance(_loc3_) && checkMapDistanceAndRenderCheck()))
                        {
                           if(!(!canRenderArmyView(_loc3_.userId) && checkMapDistanceAndRenderCheck()))
                           {
                              _loc2_ = createArmy(_loc3_);
                              addItem(_loc2_);
                              _loc2_.updateVisible();
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      protected function initHighPriorityArmy(param1:Dictionary) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:CampaignArmyView = null;
         for each(var _loc4_:CampaignArmy in param1)
         {
            _loc2_ = false;
            if(WorldBossHelper.checkGodsEvening(_model.mapId))
            {
               if(_loc4_.goddessTeamId != 0)
               {
                  _loc2_ = true;
               }
            }
            if(_loc2_)
            {
               _loc3_ = createArmy(_loc4_);
               addItem(_loc3_);
               _loc3_.updateVisible();
            }
         }
      }
      
      protected function checkMapNeededInit() : Boolean
      {
         var _loc1_:Boolean = false;
         if(_model)
         {
            if(WorldBossHelper.checkMineral(_model.mapId) || Boolean(WorldBossHelper.checkPetLand(_model.mapId)) || Boolean(WorldBossHelper.checkWedding(_model.mapId)))
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      protected function checkMapDistanceAndRenderCheck() : Boolean
      {
         var _loc1_:Boolean = true;
         if(_model)
         {
            if(WorldBossHelper.checkMarket(_model.mapId) || Boolean(WorldBossHelper.checkGroupfb(_model.mapId)) || Boolean(WorldBossHelper.checkActiveVehicle(_model.mapId)))
            {
               _loc1_ = false;
            }
         }
         return _loc1_;
      }
      
      protected function checkDistance(param1:CampaignArmy) : Boolean
      {
         var _loc4_:Point = null;
         var _loc2_:Point = null;
         var _loc3_:Boolean = false;
         if(WorldBossHelper.checkActiveVehicle(_model.mapId))
         {
            return true;
         }
         if(WorldBossHelper.checkGodsEvening(_model.mapId))
         {
            if(param1.isDie == 12 || param1.isDie == 10)
            {
               return true;
            }
         }
         if(_model.selfMemberData)
         {
            _loc4_ = new Point(_model.selfMemberData.curPosX,_model.selfMemberData.curPosY);
            _loc2_ = new Point(param1.curPosX,param1.curPosY);
            if(Point.distance(_loc4_,_loc2_) <= 70)
            {
               _loc3_ = true;
            }
         }
         else
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      protected function canRenderArmyView(param1:int = 0) : Boolean
      {
         var _loc2_:Boolean = true;
         if(WorldBossHelper.checkWedding(_model.mapId))
         {
            if(param1 == marryModel.weddingInfo.userIdA || param1 == marryModel.weddingInfo.userIdB)
            {
               _loc2_ = true;
            }
            else if(isLimitPlayerNum && renderList.length >= maxRenderPlayerNum)
            {
               _loc2_ = false;
            }
         }
         else if(WorldBossHelper.checkMarket(_model.mapId))
         {
            if(isSelling(param1))
            {
               _loc2_ = true;
            }
            if(isLimitPlayerNum && renderList.length >= maxRenderPlayerNum)
            {
               _loc2_ = false;
            }
         }
         else
         {
            if(FreedomTeamManager.instance.hasTeam && Boolean(FreedomTeamManager.instance.inMyTeam(param1)))
            {
               _loc2_ = true;
            }
            if(isLimitPlayerNum && renderList.length >= maxRenderPlayerNum)
            {
               _loc2_ = false;
            }
         }
         return _loc2_;
      }
      
      protected function createArmy(param1:CampaignArmy, param2:int = 0) : CampaignArmyView
      {
         var _loc4_:Point = null;
         var _loc6_:Point = null;
         var _loc3_:int = 0;
         var _loc5_:Point = null;
         var _loc9_:CampaignArmyView = CampaignArmyView(_armys[param1.key]);
         if(_loc9_)
         {
            return _loc9_;
         }
         var _loc13_:int = int(_model.mapId);
         if(WorldBossHelper.checkPvp(_loc13_) || Boolean(WorldBossHelper.checkFlameTemple(_loc13_)) || Boolean(WorldBossHelper.checkSvs(_loc13_)))
         {
            _loc9_ = new PvpWarFightArmyView();
         }
         else if(WorldBossHelper.checkMonopoly(_loc13_))
         {
            _loc9_ = new MonopolyArmyView();
            _loc9_.filter = _filter;
         }
         else if(WorldBossHelper.checkDuskArea(_loc13_) || Boolean(WorldBossHelper.checkIceFireTemple(_loc13_)))
         {
            _loc9_ = new DuskAreaWarFightArmyView();
         }
         else if(WorldBossHelper.checkPetLand(_loc13_))
         {
            _loc9_ = new PetLandArmyView();
            _loc9_.filter = _filter;
         }
         else if(WorldBossHelper.checkMineral(_loc13_))
         {
            _loc9_ = new MineralArmyView();
            _loc9_.filter = _filter;
         }
         else if(WorldBossHelper.checkSumCampaign(_loc13_))
         {
            _loc9_ = new SumCampaignArmyView();
            _loc9_.filter = _filter;
         }
         else if(WorldBossHelper.checkMarket(_loc13_))
         {
            _loc9_ = new MarketArmyView();
            _loc9_.filter = _filter;
         }
         else if(WorldBossHelper.checkActiveVehicle(_loc13_))
         {
            _loc9_ = new ActiveVehicleArmyView();
         }
         else if(WorldBossHelper.checkInHouse(_loc13_))
         {
            _loc9_ = new HouseArmyView();
            _loc9_.filter = _filter;
         }
         else if(WorldBossHelper.checkGroupfb(_loc13_))
         {
            _loc9_ = new GroupfbArmyView();
         }
         else if(WorldBossHelper.checkUnrealShooting(_loc13_))
         {
            _loc9_ = new UnrealShootingArmyView();
         }
         else if(WorldBossHelper.checkGodsEvening(_loc13_))
         {
            _loc9_ = new GodsEveningArmyView();
         }
         else if(WorldBossHelper.checkConsortiaEmeDream(_loc13_))
         {
            _loc9_ = new ConsortiaEmeDreamArmyView();
         }
         else if(WorldBossHelper.checkIsNoviceCityMap(_loc13_))
         {
            if(renderingAvatarCount >= 20 && param1.userId != _model.selfMemberData.userId)
            {
               _loc9_ = new CampaignArmyView(false);
            }
            else
            {
               _loc9_ = new CampaignArmyView();
            }
         }
         else
         {
            _loc9_ = new CampaignArmyView();
         }
         _armys[param1.key] = _loc9_;
         CampaignManager.instance.controller.addArmyView(_loc9_);
         var _loc14_:AIBaseInfo = new BaseArmyAiInfo();
         _loc14_.speed = ArmySpeedUtils.getMoveSpeed(param1);
         _loc14_.isLiving = true;
         _loc14_.moveOverState = param2;
         _loc9_.info = _loc14_;
         _loc9_.data = param1;
         var _loc7_:int = int(PlayerManager.instance.newbieProcess);
         var _loc11_:int = param1.curPosX * 20;
         var _loc12_:int = param1.curPosY * 20;
         _loc9_.x = _loc11_;
         _loc9_.y = _loc12_;
         if(WorldBossHelper.checkIsNoviceMap(param1.mapId))
         {
            setArmyPosByNewbieProcess(_loc9_,_loc12_,_loc7_);
         }
         var _loc8_:Boolean = false;
         if(WorldBossHelper.checkMapId(param1.mapId))
         {
            _loc9_.avatarView.scaleX = _loc9_.avatarView.scaleY = 0.85;
         }
         else
         {
            _model.updateFog(_loc9_.x,_loc9_.y,4);
            if(param1.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
            {
               _loc8_ = true;
            }
         }
         var _loc10_:CampaignNode = _model.getToAttackNode();
         if(_loc10_)
         {
            _loc4_ = new Point(_loc9_.x,_loc9_.y);
            _loc6_ = new Point(_loc10_.x,_loc10_.y);
            _loc3_ = Point.distance(_loc4_,_loc6_);
            _loc5_ = Point.interpolate(_loc6_,_loc4_,100 / _loc3_);
            if(_loc9_.data.angle == -1)
            {
               _loc9_.avatarView.angle = HeroAvatarViewHelper.twoPointAngle(_loc6_.x,_loc6_.y,_loc4_.x,_loc4_.y);
            }
            else
            {
               _loc9_.avatarView.angle = _loc9_.data.angle;
            }
            if(_loc8_)
            {
               _model.updateFog(_loc5_.x,_loc5_.y,4);
            }
         }
         param1.preParent = this;
         return _loc9_;
      }
      
      protected function get renderingAvatarCount() : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:CampaignArmyView = null;
         _loc3_ = 0;
         while(_loc3_ < renderList.length)
         {
            _loc1_ = renderList[_loc3_] as CampaignArmyView;
            if(_loc1_ != null && _loc1_.isRenderingAvatar)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function setArmyPosByNewbieProcess(param1:CampaignArmyView, param2:int, param3:int) : void
      {
         if(param3 <= 11300)
         {
            param1.x = 3000;
            param1.y = 1080;
            param1.updateDirection(270);
         }
         else if(param3 == 11400)
         {
            param1.x = 1285;
            param1.y = 1045;
            param1.updateDirection(280);
         }
         else if(param3 >= 11500 && param3 <= 12500)
         {
            param1.x = 1320;
            param1.y = 860;
            param1.updateDirection(280);
         }
         else if(param3 == 14000)
         {
            param1.x = 1340;
            param1.y = 700;
            param1.updateDirection(350);
         }
      }
      
      public function removeItem(param1:CampaignArmyView) : void
      {
         _items[param1] = null;
         delete _items[param1];
         param1.data.removeEventListener("IS_SELLING",__changeSellHandler);
         if(param1 && param1.parent)
         {
            param1.parent.removeChild(param1);
         }
      }
      
      public function addItem(param1:CampaignArmyView) : void
      {
         if(!param1 || !_selfArmyView)
         {
            return;
         }
         if(param1 != _selfArmyView && Boolean(WorldBossHelper.checkSacrificeRoom(CampaignManager.instance.mapId)))
         {
            return;
         }
         param1.data.removeEventListener("IS_SELLING",__changeSellHandler);
         param1.data.addEventListener("IS_SELLING",__changeSellHandler);
         this.addChild(param1);
         _items[param1] = param1;
         if(param1.data.userId != _selfArmyView.data.userId)
         {
            if(WorldBossHelper.checkPetLand(_model.mapId) || Boolean(WorldBossHelper.checkWorldBoss(_model.mapId)) || Boolean(WorldBossHelper.checkWedding(_model.mapId)) || Boolean(WorldBossHelper.checkConsortiaEmeDream(_model.mapId)) || Boolean(WorldBossHelper.checkForbiddenBoss(_model.mapId)))
            {
               param1.isPlaying = !SharedManager.instance.hideOthers;
            }
            else
            {
               param1.isPlaying = true;
            }
         }
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:CampaignArmyView = param1 as CampaignArmyView;
         if(_loc2_)
         {
            if((_selfArmyView == param1 || canRenderArmyView(_loc2_.data.userId)) && _loc2_.info.moveOverState != 2)
            {
               if(renderList.indexOf(param1) < 0 && !isSelling(_loc2_.data.userId))
               {
                  renderList.push(param1);
               }
               super.addChild(param1);
            }
         }
         else
         {
            super.addChild(param1);
         }
         return param1;
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         if(param1 is CampaignArmyView)
         {
            if(_selfArmyView == param1 || canRenderArmyView((param1 as CampaignArmyView).data.userId))
            {
               if(renderList.indexOf(param1) < 0 && !isSelling((param1 as CampaignArmyView).data.userId))
               {
                  renderList.push(param1);
               }
               super.addChildAt(param1,param2);
            }
         }
         else
         {
            super.addChildAt(param1,param2);
         }
         return param1;
      }
      
      protected function __changeSellHandler(param1:Event) : void
      {
         var _loc2_:CampaignArmyView = null;
         var _loc3_:int = 0;
         var _loc4_:CampaignArmy = param1.currentTarget as CampaignArmy;
         if(_loc4_ && _selfArmyView)
         {
            if(_loc4_.userId == _selfArmyView.data.userId)
            {
               return;
            }
            _loc2_ = _armys[_loc4_.key] as CampaignArmyView;
            _loc3_ = renderList.indexOf(_loc2_);
            if(_loc3_ >= 0)
            {
               renderList.splice(_loc3_,1);
            }
            if(isSelling(_loc4_.userId))
            {
               for each(_loc2_ in _items)
               {
                  if(_loc2_.parent == null)
                  {
                     addChild(_loc2_);
                     _loc2_.data.dispatchEvent(new CampaignMapEvent("IS_SELLING",null));
                  }
               }
            }
            else if(canRenderArmyView(_loc4_.userId))
            {
               addChild(_loc2_);
            }
            else
            {
               if(_loc2_.parent == this)
               {
                  removeChild(_loc2_);
               }
               if(_loc2_.petAvatarView && _loc2_.petAvatarView.parent == this)
               {
                  this.removeChild(_loc2_.petAvatarView);
               }
               if(_loc2_.childrenAvatarView && _loc2_.childrenAvatarView.parent == this)
               {
                  this.removeChild(_loc2_.childrenAvatarView);
               }
            }
         }
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:int = 0;
         param1 = super.removeChild(param1);
         if(param1 is CampaignArmyView)
         {
            _loc2_ = renderList.indexOf(param1);
            if(_loc2_ >= 0)
            {
               renderList.splice(_loc2_,1);
            }
         }
         return param1;
      }
      
      override public function removeChildAt(param1:int) : DisplayObject
      {
         var _loc2_:DisplayObject = super.removeChildAt(param1);
         if(_loc2_ is CampaignArmyView)
         {
            param1 = renderList.indexOf(_loc2_);
            if(param1 >= 0)
            {
               renderList.splice(param1,1);
            }
         }
         return _loc2_;
      }
      
      private function get marryModel() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function isSelling(param1:int) : Boolean
      {
         if(marketModel == null)
         {
            return false;
         }
         var _loc2_:StallInfo = marketModel.stalls[param1] as StallInfo;
         return _loc2_ && _loc2_.state == 2;
      }
      
      private function get marketModel() : MarketModel
      {
         return CampaignManager.instance.marketModel;
      }
      
      public function enterFrame() : void
      {
         if(!_model || Boolean(_model.exit))
         {
            return;
         }
         if(!_model.mapTielsData)
         {
            return;
         }
         for each(var _loc1_:CampaignArmyView in _items)
         {
            if(_loc1_)
            {
               _loc1_.execute();
               if(!_loc1_.isLiving)
               {
                  removeItem(_loc1_);
                  _loc1_.dispose();
               }
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:CampaignArmyView = null;
         NotificationManager.instance.removeEventListener("HIDE_OTHERS",__hideOthers);
         MsgMan.removeObserver("MarryEventType.WEDDING_OATH",this,__oathHandler);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         for(var _loc2_ in _items)
         {
            _loc1_ = _items[_loc2_] as CampaignArmyView;
            if(_loc1_.data)
            {
               _loc1_.data.removeEventListener("IS_SELLING",__changeSellHandler);
            }
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
            delete _items[_loc2_];
         }
         for(_loc2_ in _armys)
         {
            _loc1_ = _armys[_loc2_];
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
            delete _items[_loc2_];
         }
         _armys = null;
         _filter = null;
         _items = null;
         _model = null;
         renderList = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
   }
}

