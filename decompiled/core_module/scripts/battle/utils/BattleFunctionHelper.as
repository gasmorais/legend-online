package battle.utils
{
   import battle.BattleManager;
   import battle.data.AttackData;
   import battle.data.BufferDamageData;
   import battle.data.ReliveInfo;
   import battle.data.SkillData;
   import com.road.yishi.proto.battle.AttackOrderMsg;
   import com.road.yishi.proto.battle.DamageMsg;
   import com.road.yishi.proto.battle.DropInfoMsg;
   import com.road.yishi.proto.battle.HeroMsg;
   import com.road.yishi.proto.battle.WaitReviveMsg;
   import yishi.datas.BattleModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   
   public class BattleFunctionHelper
   {
      
      private static var _instance:BattleFunctionHelper;
      
      public function BattleFunctionHelper()
      {
         super();
      }
      
      public static function get instance() : BattleFunctionHelper
      {
         if(_instance == null)
         {
            _instance = new BattleFunctionHelper();
         }
         return _instance;
      }
      
      public function findBattleRoleMsgForHero(param1:Array, param2:int) : HeroMsg
      {
         for each(var _loc3_:HeroMsg in param1)
         {
            if(_loc3_.livingId2 == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function findChildMsgForHero(param1:Array, param2:int) : HeroMsg
      {
         for each(var _loc3_:HeroMsg in param1)
         {
            if(_loc3_.livingId == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getHeroRoleByPosAndSide(param1:int, param2:int) : RoleInfo
      {
         for each(var _loc3_:RoleInfo in battleModel.roleList)
         {
            if(_loc3_.pos == param1)
            {
               if(_loc3_.side == param2)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public function isBattleHero(param1:RoleInfo) : Boolean
      {
         var _loc2_:HeroRoleInfo = null;
         if(!param1)
         {
            return false;
         }
         if(param1 is HeroRoleInfo)
         {
            _loc2_ = param1 as HeroRoleInfo;
            if(_loc2_ && _loc2_.type == 1 && !_loc2_.isChildFake && !_loc2_.isPetFake && !_loc2_.isGoddess)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function checkHasGoddessInBattle() : Boolean
      {
         for each(var _loc1_:RoleInfo in battleModel.roleList)
         {
            if(_loc1_.isGoddess)
            {
               return true;
            }
         }
         return false;
      }
      
      public function sealTitanSkillHandler(param1:SkillData) : void
      {
         var _loc3_:HeroRoleInfo = null;
         var _loc2_:BufferTemplateInfo = null;
         var _loc4_:int = 0;
         for each(var _loc5_:BufferDamageData in param1.buffers)
         {
            if(_loc5_.AttackType == 310)
            {
               _loc3_ = BattleManager.getInstance().battleModel.getRoleById(_loc5_.target) as HeroRoleInfo;
               if(_loc3_)
               {
                  _loc2_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc5_.templateId);
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_.titanSkill.length)
                  {
                     if(_loc4_ + 1 >= _loc2_.AttackValue && _loc4_ + 1 <= _loc2_.ValuePercent)
                     {
                        _loc3_.titanSkillUsed[_loc4_] = 2;
                     }
                     _loc4_++;
                  }
               }
            }
         }
         MsgMan.notifyObserver("DragonTitanEvent.TITAN_SKILL_USE");
      }
      
      public function goddessMoiveViewHandler(param1:AttackOrderMsg) : void
      {
         var _loc2_:Array = [];
         var _loc3_:Object = {};
         _loc3_.skillId = param1.orderId;
         _loc3_.livingId = param1.livingId;
         _loc2_.push(_loc3_);
         NotificationManager.instance.sendNotification("GODDESS_GUARD_SKILL",_loc2_);
      }
      
      public function readSkill(param1:AttackOrderMsg) : SkillData
      {
         var _loc2_:SkillData = readSkillData(param1);
         if(_loc2_.skillId == 0)
         {
            _loc2_.skillId = -1;
         }
         return _loc2_;
      }
      
      private function readSkillData(param1:AttackOrderMsg) : SkillData
      {
         var _loc10_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:DamageMsg = null;
         var _loc7_:int = 0;
         var _loc5_:AttackData = null;
         var _loc4_:ReliveInfo = null;
         var _loc13_:SkillData = new SkillData();
         _loc13_.skillId = param1.orderId;
         _loc13_.fId = param1.livingId;
         _loc13_.sp = param1.sp;
         _loc13_.spAdded = param1.spAdded;
         _loc13_.hitPoint = param1.hitPoint;
         _loc13_.hitPointAdded = 0;
         _loc13_.attackMillis = DateFormatter.parse(param1.attackMillis,"YYYY-MM-DD hh:mm:ss").time;
         _loc13_.battleId = param1.battleId;
         _loc13_.passive = param1.isPassive;
         _loc13_.liftTime = param1.execFrame;
         _loc13_.coexistType = param1.coexist;
         var _loc11_:int = int(param1.damages.length);
         var _loc12_:Array = [];
         var _loc8_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _loc11_)
         {
            _loc6_ = param1.damages[_loc7_];
            _loc10_ = _loc6_.livingId;
            _loc2_ = param1.livingId;
            _loc5_ = new AttackData();
            _loc5_.bloodType = _loc6_.damageType;
            _loc5_.roleId = _loc10_;
            _loc5_.fId = _loc2_;
            _loc5_.damageValue = Int64Utils.int64ToNumber(_loc6_.damageValue);
            _loc5_.displayBlood = Int64Utils.int64ToNumber(_loc6_.damageValue);
            if(_loc6_.hasHpLimit)
            {
               _loc5_.hpMaxAdd = Int64Utils.int64ToNumber(_loc6_.hpLimit);
            }
            _loc5_.extraData = _loc6_.extraData;
            _loc5_.parry = _loc6_.parry;
            _loc5_.leftHp = Int64Utils.int64ToNumber(_loc6_.leftValue);
            _loc5_.resistValue = _loc6_.resiValue;
            _loc5_.resistType = _loc6_.resiType;
            _loc5_.resiPercent = _loc6_.resiPercent;
            for each(var _loc3_:DropInfoMsg in _loc6_.dropInfos)
            {
               _loc5_.dropList.push(_loc3_);
            }
            if(_loc12_.indexOf(_loc10_) == -1)
            {
               _loc12_.push(_loc10_);
            }
            _loc8_.push(_loc5_);
            _loc7_++;
         }
         _loc13_.data = dataFormatConversion(_loc12_,_loc8_);
         for each(var _loc9_:WaitReviveMsg in param1.waitRevives)
         {
            _loc4_ = ReliveInfo.createFromMsg(_loc9_);
            _loc13_.reliveList.push(_loc4_);
         }
         return _loc13_;
      }
      
      private function dataFormatConversion(param1:Array, param2:Array) : Array
      {
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc4_:AttackData = null;
         var _loc7_:Array = [];
         var _loc8_:int = param2.length / param1.length;
         _loc5_ = 0;
         while(_loc5_ < _loc8_)
         {
            _loc3_ = [];
            _loc6_ = 0;
            while(_loc6_ < param1.length)
            {
               _loc4_ = param2[_loc5_ + _loc6_ * _loc8_] as AttackData;
               _loc3_.push(_loc4_);
               _loc6_++;
            }
            _loc7_.push(_loc3_);
            _loc5_++;
         }
         return _loc7_;
      }
      
      public function isGoddessSkill(param1:SkillTempInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.MasterType == 80)
         {
            return true;
         }
         if(param1.MasterType == 81)
         {
            return true;
         }
         return false;
      }
      
      public function isLoadComplete(param1:RoleInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.isGoddess)
         {
            return true;
         }
         return param1.isLoadComplete;
      }
      
      public function showGoddessTopAry() : Array
      {
         if(!VersionSwitch.GODDESS_OPEN)
         {
            return [false,false];
         }
         var _loc1_:Array = [];
         switch(battleModel.battleType)
         {
            case 11:
            case 10:
            case 3891:
               _loc1_ = [true,true];
               break;
            case 13:
            case 25:
            case 3852:
            case 3853:
            case 3854:
            case 3870:
            case 3877:
            case 3878:
            case 3848:
            case 3872:
            case 3894:
               _loc1_ = [true,false];
               break;
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 9:
            case 12:
            case 16:
            case 17:
            case 18:
            case 23:
            case 32:
            case 293:
            case 3843:
            case 3851:
            case 3855:
            case 3857:
            case 3858:
            case 3859:
            case 3862:
            case 3863:
            case 3864:
            case 3865:
            case 3869:
            case 3871:
            case 3873:
            case 3875:
            case 3876:
            case 3879:
            case 3880:
            case 3887:
            case 3847:
            case 3845:
            case 3844:
            case 35:
            case 3867:
            case 3868:
            case 3874:
            case 3860:
            case 330:
            case 3850:
            case 19:
            case 3885:
            case 3889:
            case 3890:
            case 3897:
               _loc1_ = [false,false];
         }
         if(_loc1_.length > 0)
         {
            return _loc1_;
         }
         if(battleModel.battleCapity > 1 && checkHasGoddessInBattle())
         {
            if(hasHeroBySide(3 - battleModel.selfSide))
            {
               _loc1_ = [true,true];
            }
            else if(hasHeroBySide(battleModel.selfSide))
            {
               _loc1_ = [true,false];
            }
         }
         else
         {
            _loc1_ = [false,false];
         }
         return _loc1_;
      }
      
      public function hasHeroBySide(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            if(battleModel.heroList[_loc3_ + "_" + param1])
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
   }
}

