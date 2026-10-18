package map.campaign.view.physics
{
   import avatar.view.HeroAvatar;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import map.campaign.CampaignManager;
   import map.internals.constant.NodeState;
   import map.internals.data.CampaignNode;
   import map.internals.interfaces.IBaseMouseEvent;
   import yishi.manager.PlayerManager;
   
   public class PetLandArmyView extends CampaignArmyView implements IBaseMouseEvent
   {
      
      public function PetLandArmyView()
      {
         super();
         this.mouseEnabled = true;
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
         __isDieHandler(null);
         return false;
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         if(isSelf)
         {
            this.buttonMode = false;
            this.mouseChildren = this.mouseEnabled = false;
            return false;
         }
         if(_avatar)
         {
            if((_avatar as HeroAvatar).getCurrentPixels() > 50)
            {
               _filter.setGlowFilter(_avatar);
               return false;
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
      
      override public function dispose() : void
      {
         if(_avatar && _filter)
         {
            _filter.setNormalFilter(_avatar);
         }
         _filter = null;
         super.dispose();
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
         PlayerManager.instance.currentPlayerModel.selectTarget = data;
         PlayerManager.instance.currentPlayerModel.reinforce = data;
         param1.stopPropagation();
         return true;
      }
      
      protected function throughDispatch(param1:MouseEvent) : void
      {
         var _loc4_:Rectangle = null;
         var _loc2_:Array = CampaignManager.instance.mapModel.mapNodesData;
         for each(var _loc3_:CampaignNode in _loc2_)
         {
            if(NodeState.displayState(_loc3_.info.state))
            {
               if(_loc3_.nodeView && _loc3_.nodeView.mouseEnabled && _loc3_.nodeView != this && _loc3_.nodeView.stage)
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
      
      override protected function get isSelf() : Boolean
      {
         return data.userId == playerInfo.userId;
      }
   }
}

