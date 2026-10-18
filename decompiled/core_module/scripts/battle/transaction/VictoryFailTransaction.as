package battle.transaction
{
   import battle.BattleManager;
   import battle.data.SkillData;
   import battle.handler.SkillHandlerII;
   import com.road.yishi.proto.battle.PrepareOverLivingMsg;
   import com.road.yishi.proto.battle.PrepareOverMsg;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   
   public class VictoryFailTransaction
   {
      
      public function VictoryFailTransaction()
      {
         super();
      }
      
      public static function handle(param1:PackageIn) : void
      {
         var _loc11_:SkillHandlerII = null;
         var _loc12_:SkillData = null;
         var _loc3_:PrepareOverLivingMsg = null;
         var _loc8_:int = 0;
         var _loc10_:SkillData = null;
         var _loc7_:int = 0;
         var _loc4_:RoleInfo = null;
         var _loc2_:PrepareOverMsg = new PrepareOverMsg();
         _loc2_ = param1.readBody(_loc2_) as PrepareOverMsg;
         var _loc13_:int = _loc2_.frame;
         var _loc5_:BattleModel = BattleManager.getInstance().battleModel;
         if(!BattleManager.getInstance().getSkillSystem() || !_loc5_)
         {
            return;
         }
         var _loc6_:int = int(_loc2_.prepareOverLivings.length);
         var _loc9_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc3_ = _loc2_.prepareOverLivings[_loc7_];
            _loc12_ = new SkillData();
            _loc12_.liftTime = _loc13_;
            _loc12_.skillId = _loc3_.calcType;
            _loc12_.fId = _loc3_.livingId;
            _loc12_.sp = _loc3_.sp;
            if(_loc12_.skillId == 3)
            {
               _loc9_.push(_loc12_.fId);
               if(!_loc10_)
               {
                  _loc10_ = _loc12_;
                  _loc4_ = _loc5_.getRoleById(_loc12_.fId);
                  if(_loc4_)
                  {
                     _loc8_ = _loc4_.side;
                  }
               }
            }
            _loc11_ = new SkillHandlerII(_loc12_);
            _loc11_.handler();
            _loc7_++;
         }
         deadPlayerPlayVictory(_loc8_,_loc10_,_loc9_);
      }
      
      private static function deadPlayerPlayVictory(param1:int, param2:SkillData, param3:Array) : void
      {
         var _loc6_:SkillData = null;
         var _loc7_:SkillHandlerII = null;
         var _loc5_:Array = BattleManager.getInstance().battleModel.getRoleBySide(param1);
         for each(var _loc4_:RoleInfo in _loc5_)
         {
            if(_loc4_ is HeroRoleInfo && param3.indexOf(_loc4_.livingId) == -1)
            {
               _loc6_ = new SkillData();
               _loc6_.liftTime = param2.liftTime;
               _loc6_.skillId = param2.skillId;
               _loc6_.fId = _loc4_.livingId;
               _loc6_.sp = HeroRoleInfo(_loc4_).sp;
               _loc7_ = new SkillHandlerII(_loc6_);
               _loc7_.handler();
            }
         }
      }
   }
}

