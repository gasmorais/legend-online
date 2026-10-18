package managers
{
   import battle.BattleManager;
   import battle.actions.MovePointAction;
   import battle.utils.BattleUtils;
   import com.road.yishi.proto.battle.ControlBuffStateMsg;
   import flash.geom.Point;
   import mvc.module.tailafb.TailaFbModel;
   import yishi.comm.PackageIn;
   import yishi.datas.objects.RoleInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   
   public class TailaFbManager
   {
      
      private static var _instance:TailaFbManager;
      
      private var _model:TailaFbModel;
      
      public function TailaFbManager()
      {
         super();
         if(_model == null)
         {
            _model = new TailaFbModel();
         }
      }
      
      public static function get instance() : TailaFbManager
      {
         if(!_instance)
         {
            _instance = new TailaFbManager();
         }
         return _instance;
      }
      
      public function get model() : TailaFbModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4999,__bossControlHandle);
      }
      
      protected function __bossControlHandle(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ControlBuffStateMsg = new ControlBuffStateMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ControlBuffStateMsg;
         BattleManager.getInstance().battleModel.bossControlLivingId = _loc2_.controled ? _loc2_.livingId : 0;
         if(BattleManager.getInstance().battleModel.selfHero.livingId == _loc2_.livingId)
         {
            NotificationManager.instance.sendNotification("SKILL_ENABLE",!_loc2_.controled);
         }
         BattleManager.getInstance().battleModel.getRoleById(_loc2_.livingId).side = _loc2_.side;
         runTo(_loc2_.livingId,_loc2_.side,_loc2_.pos);
      }
      
      private function runTo(param1:int, param2:int, param3:int) : void
      {
         var temp:Point;
         var livingId:int = param1;
         var side:int = param2;
         var pos:int = param3;
         var role:RoleInfo = BattleManager.getInstance().battleModel.getRoleById(livingId);
         role.face = role.side == BattleManager.getInstance().battleModel.selfSide ? 1 : 2;
         temp = BattleUtils.rolePointByPos(role.pos,role.face);
         new MovePointAction(role.livingId,temp,25,0,false,false,true,false,function():void
         {
            BattleManager.getInstance().battleModel.getRoleById(livingId).side = side;
         },null,true,null,100,true);
      }
   }
}

