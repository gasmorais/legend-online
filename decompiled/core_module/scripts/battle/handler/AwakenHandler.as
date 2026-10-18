package battle.handler
{
   import battle.BattleManager;
   import battle.actions.AwakenAppearAction;
   import battle.utils.BattleUtils;
   import flash.geom.Point;
   import yishi.datas.objects.RoleInfo;
   
   public class AwakenHandler
   {
      
      public function AwakenHandler()
      {
         super();
      }
      
      public static function addRole(param1:RoleInfo) : void
      {
         param1.face = param1.side == 1 ? 1 : 2;
         param1.load();
         BattleManager.getInstance().battleModel.addRole(param1);
         var _loc2_:Point = BattleUtils.rolePointByPos(param1.pos,param1.face);
         param1.point = _loc2_;
         new AwakenAppearAction(param1);
      }
   }
}

