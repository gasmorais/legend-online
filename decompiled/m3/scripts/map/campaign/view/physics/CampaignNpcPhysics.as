package map.campaign.view.physics
{
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.helper.npcai.NpcAttackHelper;
   import map.campaign.view.physics.physicsview.CampaignNpcView;
   import map.internals.data.CampaignNode;
   import yishi.utils.WorldBossHelper;
   
   public class CampaignNpcPhysics extends CampaignNpcView
   {
      
      public function CampaignNpcPhysics()
      {
         super();
         buttonMode = true;
      }
      
      override public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         return attackFun();
      }
      
      private function attackFun() : Boolean
      {
         if(!CampaignManager.instance.mapModel)
         {
            return false;
         }
         if(!CampaignManager.instance.mapModel.mapTielsData)
         {
            return false;
         }
         var _loc4_:int = int(CampaignManager.instance.mapModel.mapId);
         var _loc1_:CampaignNode = info as CampaignNode;
         var _loc6_:CampaignArmy = CampaignManager.instance.mapModel.selfMemberData;
         CampaignManager.instance.mapModel.selectNode = info as CampaignNode;
         if(_loc6_.inNode)
         {
            CampaignManager.instance.controller.curSelectedObject = this;
         }
         var _loc3_:Object = CampaignManager.instance.controller.getArmyView(_loc6_);
         var _loc5_:Boolean = false;
         if(WorldBossHelper.checkWedding(_loc4_) && _loc1_.param1 != 1 && _loc1_.param1 != 2 && _loc1_.param1 != 3 && _loc1_.param1 != 8)
         {
            if(_loc1_.param1 == 4)
            {
               _loc5_ = true;
            }
            CampaignManager.instance.mapModel.selectNode = _loc1_;
         }
         var _loc2_:Point = NpcAttackHelper.getAttackPoint(info as CampaignNode,new Point(_loc3_.x,_loc3_.y),new Point(this.x,this.y));
         CampaignManager.instance.controller.moveArmyByPos(_loc2_.x,_loc2_.y,_loc5_,true);
         return true;
      }
      
      override public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(!CampaignManager.instance.mapModel)
         {
            return false;
         }
         var _loc4_:int = int(CampaignManager.instance.mapModel.mapId);
         if(WorldBossHelper.checkDuskArea(_loc4_))
         {
            _loc3_ = int(CampaignManager.instance.mapModel.selfMemberData.teamId);
            _loc2_ = int((info as CampaignNode).param1);
            if(_loc2_ > 0 && _loc2_ != _loc3_)
            {
               if((info as CampaignNode).param2 == 5)
               {
                  return false;
               }
            }
            if(info.info.types == 40 || info.info.types == 41)
            {
               return false;
            }
            if(_loc2_ > 0 && _loc2_ != _loc3_)
            {
               return true;
            }
         }
         if(WorldBossHelper.checkUnrealShooting(_loc4_))
         {
            _loc3_ = int(CampaignManager.instance.mapModel.selfMemberData.teamId);
            _loc2_ = int((info as CampaignNode).param1);
            if(info.info.types == 40 || info.info.types == 41)
            {
               return false;
            }
            if(_loc2_ > 0 && _loc2_ != _loc3_)
            {
               return true;
            }
         }
         return false;
      }
   }
}

