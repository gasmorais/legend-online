package map.campaign.helper.npcai
{
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.view.physics.CampaignArmyView;
   import map.campaign.view.physics.NpcAvatarView;
   import map.internals.data.CampaignNode;
   
   public class NpcAttackHelper
   {
      
      public function NpcAttackHelper()
      {
         super();
      }
      
      public static function npcAttackMove(param1:NpcAvatarView, param2:CampaignArmyView) : void
      {
      }
      
      private static function getAttackPointImp(param1:*, param2:Point) : Point
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:Boolean = false;
         if(param1 is CampaignNode)
         {
            _loc4_ = int((param1 as CampaignNode).handlerRange);
            _loc5_ = 0;
            _loc6_ = false;
            if(_loc4_ > 0)
            {
               while(!_loc6_ && _loc5_ < 20)
               {
                  _loc5_++;
                  _loc7_ = getRandomByValue(_loc4_);
                  _loc8_ = getRandomByValue(_loc4_);
                  _loc3_ = Boolean(CampaignManager.instance.mapModel.getWalkable(int(param2.x / 20),int(param2.y / 20)));
                  if(_loc3_)
                  {
                     param2.x += _loc7_ * 20;
                     param2.y += _loc8_ * 20;
                     _loc6_ = true;
                  }
               }
            }
         }
         return param2;
      }
      
      private static function getRandomByValue(param1:int) : int
      {
         var _loc2_:int = Math.round(Math.random() * param1);
         return int(Math.random() * 1000) % 2 == 0 ? -_loc2_ : _loc2_;
      }
      
      public static function getAttackPoint(param1:CampaignNode, param2:Point, param3:Point) : Point
      {
         var _loc6_:Point = null;
         var _loc8_:int = 0;
         var _loc5_:Boolean = false;
         var _loc7_:int = int(param1.handlerRange);
         _loc7_ = _loc7_ * 20;
         var _loc4_:int = Point.distance(param2,param3);
         _loc8_ = _loc7_;
         while(_loc8_ >= 0)
         {
            _loc6_ = Point.interpolate(param2,param3,_loc8_ / _loc4_);
            _loc5_ = Boolean(CampaignManager.instance.mapModel.getWalkable(int(_loc6_.x / 20),int(_loc6_.y / 20)));
            if(_loc5_)
            {
               break;
            }
            _loc8_ -= 20;
            if(_loc8_ < 0)
            {
               _loc6_ = null;
               break;
            }
            _loc8_;
         }
         if(_loc6_)
         {
            return _loc6_;
         }
         return getAttackPointImp(param1,param3);
      }
   }
}

