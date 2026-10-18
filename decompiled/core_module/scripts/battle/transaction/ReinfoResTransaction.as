package battle.transaction
{
   import battle.BattleManager;
   import battle.skillsys.loader.SkillResLoaderVO;
   import battle.skillsys.loader.SkillResourceLoader;
   import com.road.yishi.proto.battle.ArmyResMsg;
   import com.road.yishi.proto.battle.PreLoadResMsg;
   
   public class ReinfoResTransaction extends TransactionBase
   {
      
      public function ReinfoResTransaction()
      {
         super();
      }
      
      override public function configure(param1:Object) : void
      {
         var _loc8_:PreLoadResMsg = null;
         var _loc17_:int = 0;
         var _loc12_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         if(BattleManager.selfDie)
         {
            return;
         }
         super.configure(param1);
         var _loc2_:ArmyResMsg = new ArmyResMsg();
         _loc2_ = _pkg.readBody(_loc2_) as ArmyResMsg;
         var _loc11_:Array = [];
         var _loc4_:Array = [];
         var _loc16_:Array = [];
         var _loc14_:Array = [];
         var _loc3_:int = _loc2_.reinforceType;
         _loc6_ = 0;
         while(_loc6_ < _loc2_.loadRes.length)
         {
            _loc8_ = _loc2_.loadRes[_loc6_];
            _loc7_ = 0;
            while(_loc7_ < _loc8_.soldierTempId.length)
            {
               _loc17_ = int(_loc8_.soldierTempId[_loc7_]);
               if(_loc11_.indexOf(_loc17_) == -1)
               {
                  _loc11_.push(_loc17_);
               }
               _loc7_++;
            }
            _loc9_ = 0;
            while(_loc9_ < _loc8_.heroSkill.length)
            {
               _loc17_ = int(_loc8_.heroSkill[_loc9_]);
               if(_loc4_.indexOf(_loc17_) == -1)
               {
                  _loc4_.push(_loc17_);
               }
               _loc9_++;
            }
            _loc12_ = 0;
            while(_loc12_ < _loc8_.soldierSkill.length)
            {
               if(_loc14_.indexOf(_loc8_.soldierSkill[_loc12_]) == -1)
               {
                  _loc14_.push(_loc8_.soldierSkill[_loc12_]);
               }
               _loc12_++;
            }
            _loc6_++;
         }
         if(_loc3_ == 1)
         {
            if(BattleManager.getInstance().battleUIView)
            {
               BattleManager.getInstance().battleUIView.setReinforceWaveInfo(_loc2_.reinforceCount,1);
            }
            else
            {
               BattleManager.getInstance().battleModel.reinforceWave = _loc2_.reinforceCount;
            }
         }
         var _loc13_:Array = [];
         _loc12_ = 0;
         while(_loc12_ < _loc11_.length)
         {
            _loc13_ = _loc13_.concat(SkillResourceLoader.getPawnSkillIds(_loc11_[_loc12_]));
            _loc12_++;
         }
         _loc13_ = _loc13_.concat(_loc14_);
         for each(var _loc10_:int in _loc13_)
         {
            _loc16_.push(new SkillResLoaderVO(_loc10_,2));
         }
         var _loc15_:Array = SkillResourceLoader.getHeroFullSkillIds(_loc4_);
         _loc13_ = _loc13_.concat(_loc15_);
         for each(var _loc5_:int in _loc15_)
         {
            _loc16_.push(new SkillResLoaderVO(_loc5_,3));
         }
         SkillResourceLoader.addSkillVOs(_loc16_);
      }
      
      override public function getCode() : int
      {
         return 4149;
      }
   }
}

