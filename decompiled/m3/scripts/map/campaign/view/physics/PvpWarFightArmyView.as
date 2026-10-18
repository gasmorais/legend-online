package map.campaign.view.physics
{
   import avatar.view.HeroAvatar;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.interfaces.IBaseMouseEvent;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.NotificationManager;
   import yishi.utils.WorldBossHelper;
   
   public class PvpWarFightArmyView extends CampaignArmyView implements IBaseMouseEvent
   {
      
      private var _flameImg:Bitmap;
      
      public function PvpWarFightArmyView()
      {
         super();
         this.mouseEnabled = true;
      }
      
      override public function set data(param1:CampaignArmy) : void
      {
         super.data = param1;
         updateVisible();
      }
      
      override protected function __isDieHandler(param1:CampaignMapEvent) : void
      {
         super.__isDieHandler(param1);
         layoutTxtViewWithNamePosY();
         updateVisible();
      }
      
      override public function updateVisible() : void
      {
         var _loc1_:Boolean = false;
         if(WorldBossHelper.checkSvs(mapModel.mapId))
         {
            if(isSelf)
            {
               super.updateVisible();
            }
            else
            {
               _loc1_ = !CampaignArmyState.checkDied(_data.isDie);
               this.visible = _loc1_;
               if(this.petAvatarView)
               {
                  this.petAvatarView.visible = _loc1_;
               }
               if(this.childrenAvatarView)
               {
                  this.childrenAvatarView.visible = _loc1_;
               }
            }
         }
         else
         {
            super.updateVisible();
         }
      }
      
      override protected function get consortiaName() : String
      {
         if(WorldBossHelper.checkSvs(mapModel.mapId))
         {
            if(isSelf)
            {
               return playerInfo.serviceName;
            }
            return _data.baseHero.serviceName;
         }
         if(isSelf)
         {
            return thane.consortiaName;
         }
         return _data.baseHero.consortiaName;
      }
      
      override protected function layoutTxtViewWithNamePosY() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(WorldBossHelper.checkSvs(mapModel.mapId))
         {
            _loc1_ = isBlueTeam() ? 1 : 5;
            _consortiaTxt.text = LanguageMgr.GetTranslation("map.avatar.view.consortiaName",this.data.baseHero.serviceName);
            _consortiaTxt.setFrame(_loc1_);
         }
         super.layoutTxtViewWithNamePosY();
         if(data.isDie == 5)
         {
            _loc2_ = caluateTopPos();
            if(!_flameImg)
            {
               _flameImg = ComponentFactory.Instance.creat("asset.flametemple.FlameIcon");
            }
            _flameImg.y = _loc2_ - _flameImg.height + 20;
            _flameImg.x = -_flameImg.width * 0.5;
         }
         else
         {
            ObjectUtils.disposeObject(_flameImg);
            _flameImg = null;
         }
      }
      
      override public function set isPlaying(param1:Boolean) : void
      {
         super.isPlaying = param1;
         if(param1)
         {
            if(_flameImg)
            {
               addChild(_flameImg);
            }
         }
         else if(_flameImg && _flameImg.parent)
         {
            _flameImg.parent.removeChild(_flameImg);
         }
      }
      
      override protected function setNpcName(param1:int) : void
      {
         super.setNpcName(param1);
         _vipText.visible = false;
         _npcName.visible = true;
         var _loc2_:int = isBlueTeam() ? 1 : 5;
         _npcName.setFrame(_loc2_);
         if(_consortiaTxt)
         {
            _consortiaTxt.setFrame(_loc2_);
         }
      }
      
      protected function isBlueTeam() : Boolean
      {
         return super.data.teamId == 1;
      }
      
      public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         CampaignManager.instance.mapModel.selectNode = null;
         if(inPvpMapAndNotSelfTeamAndNotInFight && _avatar && (_avatar as HeroAvatar).getCurrentPixels() > 50)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("LOCK_PVP_WARFIGHT",_data));
            return false;
         }
         return false;
      }
      
      public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         if(inPvpMapAndNotSelfTeamAndNotInFight)
         {
            if(_avatar && (_avatar as HeroAvatar).getCurrentPixels() > 50)
            {
               return true;
            }
         }
         return false;
      }
      
      public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         if(inPvpMapAndNotSelfTeamAndNotInFight)
         {
            if(_avatar && (_avatar as HeroAvatar).getCurrentPixels() > 50)
            {
               return true;
            }
         }
         return false;
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         if(inPvpMapAndNotSelfTeamAndNotInFight)
         {
            if(_avatar && (_avatar as HeroAvatar).getCurrentPixels() > 50)
            {
               return true;
            }
         }
         return false;
      }
      
      private function get inPvpMapAndNotSelfTeamAndNotInFight() : Boolean
      {
         if(WorldBossHelper.checkSvs(mapModel.mapId))
         {
            if(_data.teamId == mapModel.selfMemberData.teamId)
            {
               return _data.state == 2;
            }
            return true;
         }
         return (WorldBossHelper.checkPvp(mapModel.mapId) || Boolean(WorldBossHelper.checkDuskArea(mapModel.mapId)) || Boolean(WorldBossHelper.checkIceFireTemple(_data.mapId)) || Boolean(WorldBossHelper.checkFlameTemple(mapModel.mapId))) && _data.teamId != mapModel.selfMemberData.teamId && _data.state != 2;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_flameImg);
         _flameImg = null;
         super.dispose();
      }
      
      override protected function __heroPropertyHandler(param1:PlayerEvent) : void
      {
         super.__heroPropertyHandler(param1);
         changeSpeedTo(precentSpeed);
      }
      
      override protected function showAvatar(param1:CampaignArmy) : void
      {
         super.showAvatar(param1);
         changeSpeedTo(precentSpeed);
      }
   }
}

