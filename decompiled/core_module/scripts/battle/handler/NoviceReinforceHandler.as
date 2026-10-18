package battle.handler
{
   import battle.BattleManager;
   import battle.actions.MovePointAction;
   import battle.events.BattleEvent;
   import battle.utils.BattleUtils;
   import com.greensock.TweenLite;
   import com.road.yishi.proto.battle.ReinforceMsg;
   import com.road.yishi.proto.battle.SoldierMsg;
   import flash.geom.Point;
   import map.internals.utils.SocketGameReader;
   import yishi.comm.PackageIn;
   import yishi.datas.objects.PawnRoleInfo;
   import yishi.manager.NotificationManager;
   import yishi.utils.TimerUtils;
   
   public class NoviceReinforceHandler implements IPackageHandler
   {
      
      public static var CAMERA_Y:int = 480;
      
      public static const CAMERA_X:int = 650;
      
      private var _pkg:PackageIn;
      
      private const MAP_OFFSET:int = 550;
      
      private var _roles:Array;
      
      public function NoviceReinforceHandler()
      {
         super();
      }
      
      public function handle(param1:PackageIn) : void
      {
         _pkg = param1;
         TimerUtils.setTimeout(start,3000);
      }
      
      private function start() : void
      {
         var soldier:SoldierMsg;
         var role:PawnRoleInfo;
         var i:int;
         var temp:Point;
         var offsetX:Number;
         var moveMapBack:* = function():void
         {
            BattleManager.getInstance().battleMap.setCamera(new Point(650,CAMERA_Y),1);
            TimerUtils.setTimeout(darkBattleScene,3000);
         };
         var roles:Array = [];
         var msg:ReinforceMsg = new ReinforceMsg();
         msg = _pkg.readBody(msg) as ReinforceMsg;
         var side:int = msg.side;
         var size:int = int(msg.soldiers.length);
         BattleManager.getInstance().battleMap.setCamera(new Point(650 + 550,CAMERA_Y),2);
         _roles = [];
         i = 0;
         while(i < size)
         {
            soldier = msg.soldiers[i];
            role = SocketGameReader.readPawnRoleInfo(soldier);
            _roles.push(role);
            i = i + 1;
         }
         addRoleForTest2();
         for each(role in _roles)
         {
            role.face = role.side == 1 ? 1 : 2;
            BattleManager.getInstance().battleModel.addRole(role);
            temp = BattleUtils.rolePointByPos(role.pos,role.face);
            offsetX = getOffsetX(role.pos);
            role.point = new Point(temp.x + 550 + 700 + offsetX,temp.y);
            new MovePointAction(role.livingId,temp,15,0,false,false,true,true);
         }
         TimerUtils.setTimeout(moveMapBack,3000);
      }
      
      private function darkBattleScene() : void
      {
         if(BattleManager.getInstance().battleScene)
         {
            TweenLite.to(BattleManager.getInstance().battleScene,1,{"alpha":0});
         }
         NotificationManager.instance.dispatchEvent(new BattleEvent("BEFORE_BATTLE_END",null));
      }
      
      private function addRoleForTest2() : void
      {
         var _loc1_:PawnRoleInfo = _roles[0].clone();
         _loc1_.livingId = 100;
         _loc1_.pos = 5;
         _roles.push(_loc1_);
         _loc1_ = _roles[2].clone();
         _loc1_.livingId = 101;
         _loc1_.pos = 6;
         _roles.push(_loc1_);
      }
      
      private function addRoleForTest5() : void
      {
         var _loc1_:PawnRoleInfo = _roles[0].clone();
         _loc1_.livingId = 100;
         _loc1_.pos = 5;
         _roles.push(_loc1_);
         _loc1_ = _roles[2].clone();
         _loc1_.livingId = 101;
         _loc1_.pos = 6;
         _roles.push(_loc1_);
         _loc1_ = _roles[0].clone();
         _loc1_.livingId = 102;
         _loc1_.pos = 1;
         _roles.push(_loc1_);
         _loc1_ = _roles[0].clone();
         _loc1_.livingId = 103;
         _loc1_.pos = 4;
         _roles.push(_loc1_);
         _loc1_ = _roles[0].clone();
         _loc1_.livingId = 104;
         _loc1_.pos = 7;
         _roles.push(_loc1_);
      }
      
      private function getOffsetX(param1:int) : Number
      {
         var _loc2_:Number = 0;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = 50;
               break;
            case 1:
               _loc2_ = 50;
               break;
            case 2:
               _loc2_ = 100;
               break;
            case 3:
               _loc2_ = 0;
               break;
            case 4:
               _loc2_ = 0;
               break;
            case 5:
               _loc2_ = 0;
               break;
            case 6:
               _loc2_ = 50;
               break;
            case 7:
               _loc2_ = 50;
               break;
            case 8:
               _loc2_ = 100;
         }
         return _loc2_;
      }
   }
}

