package map.campaign.view.physics
{
   import avatar.view.HeroAvatar;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import map.campaign.CampaignManager;
   import map.internals.constant.NodeState;
   import map.internals.data.CampaignNode;
   import map.internals.interfaces.IBaseMouseEvent;
   import yishi.view.community.PlayerMenu;
   
   public class HoodRoomArmyView extends CampaignArmyView implements IBaseMouseEvent
   {
      
      public function HoodRoomArmyView()
      {
         super();
         this.mouseEnabled = true;
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
               _filter.setNormalFilter(_avatar);
               return true;
            }
         }
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
               _filter.setLightFilter(_avatar);
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
      
      private function throughDispatch(param1:MouseEvent) : void
      {
         var _loc5_:CampaignNpcPhysics = null;
         var _loc4_:Rectangle = null;
         var _loc2_:Array = CampaignManager.instance.mapModel.mapNodesData;
         for each(var _loc3_:CampaignNode in _loc2_)
         {
            if(NodeState.displayState(_loc3_.info.state))
            {
               if(_loc3_.nodeView && _loc3_.nodeView is CampaignNpcPhysics)
               {
                  _loc5_ = _loc3_.nodeView as CampaignNpcPhysics;
                  _loc4_ = _loc5_.getRect(stage);
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
         var _loc2_:PlayerMenu = new PlayerMenu(true);
         _loc2_.setData(data);
         _loc2_.x = StageReferance.stage.mouseX + _loc2_.width >= StageReferance.stageWidth ? StageReferance.stageWidth - _loc2_.width : Number(StageReferance.stage.mouseX);
         _loc2_.y = StageReferance.stage.mouseY + _loc2_.height >= StageReferance.stageHeight ? StageReferance.stageHeight - _loc2_.height : Number(StageReferance.stage.mouseY);
         LayerManager.Instance.addToLayer(_loc2_,7);
         param1.stopPropagation();
         return true;
      }
      
      override protected function get isSelf() : Boolean
      {
         return data.userId == playerInfo.userId;
      }
   }
}

