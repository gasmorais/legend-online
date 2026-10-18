package map.campaign.view.physics
{
   import avatar.data.AvatarStaticData;
   import avatar.view.SharedAvatar;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.data.MineralCarInfo;
   import map.campaign.data.MineralModel;
   import map.campaign.event.CampaignEvent;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.helper.npcai.NpcAttackHelper;
   import map.internals.constant.ArmyState;
   import map.internals.data.CampaignNode;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   
   public class MineralCarView extends NpcAvatarView
   {
      
      private var _owerId:int;
      
      private var _carInfo:MineralCarInfo;
      
      private var _mineralTxt:FilterFrameText;
      
      private var _army:CampaignArmy;
      
      private var _dieFilter:UIFilter;
      
      public function MineralCarView(param1:String, param2:String, param3:int, param4:int, param5:CampaignNode = null)
      {
         super(param1,param2,param3,param4);
         if(param5 != null)
         {
            _owerId = param5.info.occupyPlayerId;
            _carInfo = mineralModel.carInfos[_owerId];
            _army = CampaignManager.instance.mapModel.getUserArmyByUserId(param5.info.occupyPlayerId);
         }
         mouseChildren = false;
         mouseEnabled = !isSelf && !isSelfConsortia;
      }
      
      public function get cadInfo() : MineralCarInfo
      {
         return _carInfo;
      }
      
      public function get armyInfo() : CampaignArmy
      {
         return _army;
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         mineralModel.addEventListener("UPDATE_MINERAL_INFO",__updateCarInfo);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         mineralModel.removeEventListener("UPDATE_MINERAL_INFO",__updateCarInfo);
      }
      
      override public function attackFun() : Boolean
      {
         var _loc1_:CampaignArmy = null;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc2_:Point = null;
         if(!mapModel.mapTielsData || !_army)
         {
            return false;
         }
         if(inMineralMapAndNotInFight)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("LOCK_PVP_WARFIGHT",_army));
            return false;
         }
         _loc1_ = mapModel.selfMemberData;
         if(!_loc1_)
         {
            return false;
         }
         _loc3_ = CampaignManager.instance.controller.getArmyView(_loc1_);
         _loc4_ = int(mapModel.mapId);
         _loc2_ = NpcAttackHelper.getAttackPoint(nodeInfo as CampaignNode,new Point(_loc3_.x,_loc3_.y),new Point(this.x,this.y));
         CampaignManager.instance.controller.moveArmyByPos(_loc2_.x,_loc2_.y,false,true);
         return true;
      }
      
      private function get inMineralMapAndNotInFight() : Boolean
      {
         return WorldBossHelper.checkMineralPVP(mapModel.mapId) && Boolean(ArmyState.checkCampaignAttack(_army.state));
      }
      
      protected function __isDieHandler(param1:CampaignMapEvent) : void
      {
         if(!_army)
         {
            return;
         }
         if(CampaignArmyState.checkDied(_army.isDie) || !ArmyState.checkCampaignAttack(_army.state))
         {
            if(!_dieFilter)
            {
               _dieFilter = new UIFilter();
            }
            _dieFilter.setGrayFilter(_avatar);
            mouseEnabled = false;
         }
         else
         {
            _avatar.filters = null;
            mouseEnabled = !isSelf && !isSelfConsortia;
         }
      }
      
      private function __updateCarInfo(param1:CampaignEvent) : void
      {
         _carInfo = mineralModel.carInfos[_owerId] as MineralCarInfo;
         if(_carInfo)
         {
            if(!_mineralTxt)
            {
               _mineralTxt = ComponentFactory.Instance.creatComponentByStylename("core.MineralCarView.mineralText");
               _mineralTxt.cacheAsBitmap = true;
               addChild(_mineralTxt);
            }
            _mineralTxt.text = LanguageMgr.GetTranslation("map.campaign.view.physics.MineralCarView.minerals",_carInfo.minerals);
            __isDieHandler(null);
         }
         else
         {
            dispose();
         }
      }
      
      private function get needUpdate() : Boolean
      {
         var _loc1_:MineralCarInfo = mineralModel.carInfos[_owerId] as MineralCarInfo;
         if(!_carInfo || !_loc1_)
         {
            return false;
         }
         if(_carInfo.minerals == 0 && _loc1_.minerals > 0 || _carInfo.minerals < 200 && _loc1_.minerals >= 200)
         {
            _carInfo = _loc1_;
            return true;
         }
         _carInfo = _loc1_;
         return false;
      }
      
      override protected function refreshAvatarView() : void
      {
         var _loc1_:Object = null;
         var _loc3_:String = null;
         var _loc2_:CampaignNode = _nodeInfo as CampaignNode;
         if(!_loc2_)
         {
            return;
         }
         avatarView = new SharedAvatar(_loc2_.sonType.toString(),2,0,true);
         _loc2_.toward = _loc2_.toward;
         updateDirection(_loc2_.toward);
         showName(_loc2_.info.names,_loc2_.info.grade,_loc2_.info.state,_loc2_.info.types,_loc2_.nameColor);
         (avatarView as SharedAvatar).resetLoaded();
         if(_carInfo)
         {
            _loc3_ = PathManager.getAvatarResourcePath(String(_carInfo.quality + 1),-1,1,"body",-1,3);
            _loc1_ = createResourceLoadInfo(_loc3_,AvatarStaticData.getBaseNumByType("Stand","body"),AvatarStaticData.getBaseNumByType("Walk","body"),"body");
            LoaderManagerII.instance.load(_loc3_,4,8,loaderCompleteHandler,null,null,_loc1_);
         }
         avatarView.shadowScaleX = avatarView.shadowScaleY = 1.5;
         avatarView.moveShadow(-68,-42);
         __isDieHandler(null);
      }
      
      override protected function showName(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         super.showName(param1,param2,param3,param4,param5);
         if(!_mineralTxt)
         {
            _mineralTxt = ComponentFactory.Instance.creatComponentByStylename("core.MineralCarView.mineralText");
            _mineralTxt.cacheAsBitmap = true;
            addChild(_mineralTxt);
         }
         if(_carInfo)
         {
            _mineralTxt.text = LanguageMgr.GetTranslation("map.campaign.view.physics.MineralCarView.minerals",_carInfo.minerals);
         }
         if(isSelf)
         {
            _npcName.setFrame(1);
         }
         else if(isSelfConsortia)
         {
            _npcName.setFrame(3);
         }
         else if(isInMineralPVP)
         {
            _npcName.setFrame(5);
         }
         else
         {
            _npcName.setFrame(2);
         }
      }
      
      private function get isSelf() : Boolean
      {
         if(!_carInfo)
         {
            return false;
         }
         return _carInfo.ownerId == playerInfo.userId;
      }
      
      private function get isSelfConsortia() : Boolean
      {
         var _loc1_:int = 0;
         if(_army && _army.baseHero)
         {
            if(StringHelper.isNullOrEmpty(_army.baseHero.consortiaName))
            {
               return false;
            }
            if(StringHelper.isNullOrEmpty(playerInfo.consortiaName))
            {
               return false;
            }
            if(mapModel.isCross)
            {
               _loc1_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID);
               return _army.baseHero.consortiaName == playerInfo.consortiaName && _army.baseHero.consortiaID == _loc1_;
            }
            return _army.baseHero.consortiaName == playerInfo.consortiaName;
         }
         return false;
      }
      
      protected function get isInMineralPVP() : Boolean
      {
         if(_army && _army.baseHero)
         {
            return WorldBossHelper.checkMineralPVP(mapModel.mapId);
         }
         return false;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get mineralModel() : MineralModel
      {
         return CampaignManager.instance.mineralModel;
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
         if(_mineralTxt)
         {
            _mineralTxt.dispose();
         }
         _mineralTxt = null;
         _carInfo = null;
         _army = null;
         _dieFilter = null;
         super.dispose();
      }
   }
}

