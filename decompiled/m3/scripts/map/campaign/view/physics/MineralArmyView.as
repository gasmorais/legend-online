package map.campaign.view.physics
{
   import avatar.view.HeroAvatar;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.data.MineralModel;
   import map.campaign.event.CampaignEvent;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.constant.NodeState;
   import map.internals.data.CampaignNode;
   import map.internals.interfaces.IBaseMouseEvent;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.WorldBossHelper;
   
   public class MineralArmyView extends CampaignArmyView implements IBaseMouseEvent
   {
      
      protected var _mineralTxt:FilterFrameText;
      
      public function MineralArmyView()
      {
         super();
         this.mouseEnabled = true;
         this.mouseChildren = false;
      }
      
      override protected function initView() : void
      {
         super.initView();
         _mineralTxt = ComponentFactory.Instance.creatComponentByStylename("core.MineralCarView.mineralText");
         _mineralTxt.cacheAsBitmap = true;
         _mineralTxt.x = -_mineralTxt.width / 2;
         _mineralTxt.y = _showNamePosY - 40;
         addChild(_mineralTxt);
      }
      
      override protected function layoutTxtViewWithNamePosY() : void
      {
         super.layoutTxtViewWithNamePosY();
         if(consortiaName)
         {
            _mineralTxt.y = _consortiaTxt.y - 18;
         }
         else
         {
            _mineralTxt.y = _consortiaTxt.y;
         }
      }
      
      override public function caluateTopPos() : int
      {
         var _loc1_:int = _showNamePosY - 40;
         if(consortiaName)
         {
            _loc1_ -= 20;
         }
         return _loc1_;
      }
      
      public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         if(_avatar && (_avatar as HeroAvatar).getCurrentPixels() < 50 || isSelf)
         {
            if(param1)
            {
               throughDispatch(param1);
            }
            return false;
         }
         if(inMineralMapAndNotInFight)
         {
            PlayerManager.instance.currentPlayerModel.selectTarget = data;
            if(!isSelf && !isSelfConsortia && !isSelfTeam)
            {
               NotificationManager.instance.dispatchEvent(new NotificationEvent("LOCK_PVP_WARFIGHT",data));
            }
            param1.stopPropagation();
            return false;
         }
         return true;
      }
      
      public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         if(!isSelf)
         {
            if(_avatar && (_avatar as HeroAvatar).getCurrentPixels() > 50)
            {
               return true;
            }
         }
         if(_avatar)
         {
            _filter.setNormalFilter(_avatar);
         }
         return false;
      }
      
      private function get inMineralMapAndNotInFight() : Boolean
      {
         return WorldBossHelper.checkMineral(mapModel.mapId) && _data.state != 2;
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         if(isSelf)
         {
            this.buttonMode = false;
            this.mouseEnabled = false;
            return false;
         }
         if(_avatar)
         {
            if((_avatar as HeroAvatar).getCurrentPixels() > 50)
            {
               _filter.setGlowFilter(_avatar);
               return inMineralMapAndNotInFight && !isSelfConsortia && !isSelfTeam;
            }
            _filter.setNormalFilter(_avatar);
            if(param1)
            {
               throughDispatch(param1);
            }
            return false;
         }
         return false;
      }
      
      private function throughDispatch(param1:MouseEvent) : void
      {
         var _loc4_:Rectangle = null;
         var _loc2_:Array = CampaignManager.instance.mapModel.mapNodesData;
         for each(var _loc3_:CampaignNode in _loc2_)
         {
            if(NodeState.displayState(_loc3_.info.state))
            {
               if(_loc3_.nodeView && _loc3_.nodeView != this && _loc3_.nodeView.stage)
               {
                  _loc4_ = _loc3_.nodeView.getRect(stage);
                  if(_loc4_.contains(param1.stageX,param1.stageY))
                  {
                     _loc3_.nodeView.dispatchEvent(param1);
                     return;
                  }
               }
            }
         }
         _loc2_ = null;
      }
      
      public function lockTargetAndHideFate() : void
      {
         if(_fateSkillEffect && _fateSkillEffect.parent)
         {
            _fateSkillEffect.parent.removeChild(_fateSkillEffect);
         }
      }
      
      public function unlockTargetAndShowFate() : void
      {
         if(_fateSkillEffect)
         {
            addChildAt(_fateSkillEffect,0);
         }
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         mineralModel.removeEventListener("UPDATE_MINERAL_INFO",__updateCarInfo);
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         mineralModel.addEventListener("UPDATE_MINERAL_INFO",__updateCarInfo);
      }
      
      protected function __updateCarInfo(param1:CampaignEvent) : void
      {
         setMineralText();
      }
      
      override protected function setNpcName(param1:int) : void
      {
         _npcName.text = data.baseHero.nickName;
         _vipText.text = data.baseHero.nickName;
         if(isSelf)
         {
            _npcName.setFrame(1);
         }
         else if(isSelfConsortia || isSelfTeam)
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
         _npcName.visible = true;
         _vipText.visible = false;
      }
      
      override protected function setConsortiaName(param1:int) : void
      {
         if(consortiaName)
         {
            _consortiaTxt.text = LanguageMgr.GetTranslation("map.avatar.view.consortiaName",consortiaName);
            if(isSelf)
            {
               _consortiaTxt.setFrame(1);
            }
            else if(isSelfConsortia || isSelfTeam)
            {
               _consortiaTxt.setFrame(3);
            }
            else if(isInMineralPVP)
            {
               _consortiaTxt.setFrame(5);
            }
            else
            {
               _consortiaTxt.setFrame(2);
            }
         }
         else
         {
            _consortiaTxt.text = "";
         }
         addChild(_consortiaTxt);
      }
      
      private function get minerals() : String
      {
         var _loc1_:int = 0;
         _loc1_ = int(mineralModel.carInfos[data.baseHero.userId] ? mineralModel.carInfos[data.baseHero.userId].minerals : 0);
         return LanguageMgr.GetTranslation("map.campaign.view.physics.MineralCarView.minerals",_loc1_);
      }
      
      protected function setMineralText() : void
      {
         if(!_mineralTxt)
         {
            _mineralTxt = ComponentFactory.Instance.creatComponentByStylename("core.MineralCarView.mineralText");
            _mineralTxt.x = -_mineralTxt.width / 2;
            _mineralTxt.y = _showNamePosY - 40;
         }
         _mineralTxt.text = minerals;
         if(_mineralTxt && !_mineralTxt.parent)
         {
            addChild(_mineralTxt);
         }
      }
      
      private function get mineralModel() : MineralModel
      {
         return CampaignManager.instance.mineralModel;
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
      
      override protected function __isDieHandler(param1:CampaignMapEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(CampaignArmyState.checkDied(_data.isDie))
         {
            if(!_dieFilter)
            {
               _dieFilter = new UIFilter();
            }
            _dieFilter.setGrayFilter(_avatar);
            if(_petAvatarView)
            {
               _dieFilter.setGrayFilter(_petAvatarView);
            }
            mouseChildren = mouseEnabled = false;
         }
         else
         {
            _avatar.filters = null;
            if(_petAvatarView)
            {
               _petAvatarView.filters = null;
            }
            mouseEnabled = true;
            mouseChildren = false;
         }
      }
      
      override public function get isHoner() : Boolean
      {
         return false;
      }
      
      override protected function setFireView() : void
      {
         super.setFireView();
         mouseEnabled = false;
      }
      
      override protected function clearFireView() : void
      {
         super.clearFireView();
         __isDieHandler(null);
      }
      
      override public function dispose() : void
      {
         if(_avatar && _filter)
         {
            _filter.setNormalFilter(_avatar);
         }
         _filter = null;
         if(_mineralTxt)
         {
            _mineralTxt.dispose();
         }
         _mineralTxt = null;
         super.dispose();
      }
   }
}

