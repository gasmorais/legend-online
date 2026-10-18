package battle.transaction
{
   import battle.BattleManager;
   import battle.data.SkillData;
   import battle.handler.SkillHandlerII;
   import battle.handler.SkillProcessStrategy;
   import battle.skillsys.helper.BloodHelper;
   import battle.utils.BattleFunctionHelper;
   import com.road.yishi.proto.battle.AttackOrderListMsg;
   import com.road.yishi.proto.battle.AttackOrderMsg;
   import map.internals.utils.SocketGameReader;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class BattleGoddessMovieTransaction extends TransactionBase
   {
      
      public function BattleGoddessMovieTransaction()
      {
         super();
      }
      
      override public function configure(param1:Object) : void
      {
         var _loc7_:SkillData = null;
         var _loc6_:SkillTempInfo = null;
         var _loc8_:SkillHandlerII = null;
         var _loc5_:int = 0;
         var _loc9_:Object = null;
         _pkg = param1 as PackageIn;
         var _loc2_:AttackOrderListMsg = new AttackOrderListMsg();
         _loc2_ = _pkg.readBody(_loc2_) as AttackOrderListMsg;
         var _loc4_:Array = [];
         for each(var _loc3_:AttackOrderMsg in _loc2_.list)
         {
            _loc7_ = BattleFunctionHelper.instance.readSkill(_loc3_);
            if(battleModel.getRoleById(_loc7_.fId) != null)
            {
               if(!(battleModel && _loc3_.battleId != battleModel.battleId))
               {
                  _loc6_ = TempleteManager.instance.getSkillTemplateInfoById(_loc3_.orderId);
                  _loc7_.buffers = SocketGameReader.readBufferII(_loc3_);
                  _loc7_.awakens = SocketGameReader.readAwakenData(_loc3_);
                  if(_loc7_.awakens && _loc7_.awakens.length > 0)
                  {
                     battleModel.cacheAwakenRoles(_loc7_.awakens);
                  }
                  BloodHelper.processBlood(_loc7_);
                  _loc8_ = new SkillHandlerII(_loc7_);
                  _loc5_ = SkillProcessStrategy.processSynchronization(_loc3_.frame,_loc8_.getSkill());
                  _loc7_.processStrategy = _loc5_;
                  _loc8_.handler();
                  if(_loc6_ && (_loc6_.MasterType == 80 || _loc6_.MasterType == 81))
                  {
                     BattleFunctionHelper.instance.sealTitanSkillHandler(_loc7_);
                  }
                  _loc9_ = {};
                  _loc9_.skillId = _loc3_.orderId;
                  _loc9_.livingId = _loc3_.livingId;
                  _loc4_.push(_loc9_);
               }
            }
         }
         NotificationManager.instance.sendNotification("GODDESS_GUARD_SKILL",_loc4_);
      }
      
      override public function getCode() : int
      {
         return 4102;
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
   }
}

