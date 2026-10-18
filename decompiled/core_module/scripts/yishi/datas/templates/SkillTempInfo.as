package yishi.datas.templates
{
   import battle.BattleManager;
   import battle.data.BufferDamageData;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class SkillTempInfo
   {
      
      public var TemplateId:int;
      
      public var TemplateName:String;
      
      public var ProperType:int;
      
      public var Icons:String;
      
      public var MasterType:int;
      
      public var SonType:int;
      
      public var Grades:int;
      
      public var PreTemplateId:String;
      
      public var NextTemplateId:int;
      
      public var NeedPlayerGrade:int;
      
      public var Index:int;
      
      public var UseWay:int;
      
      public var AppearTime:int;
      
      private var _AcceptObject:int;
      
      public var ActionId:int;
      
      private var _Cost:int;
      
      public var Parameter1:int;
      
      public var Parameter2:int;
      
      public var Parameter3:int;
      
      public var Priority:int;
      
      public var BufferIds:String;
      
      public var Random:int;
      
      public var CountWay:int;
      
      private var _Description:String;
      
      private var _CoolDown:int;
      
      public var QTETime:int;
      
      public var AppearCD:int = 0;
      
      private var _IsUseOnDead:int;
      
      public var OwnRequirements:String;
      
      private var _HitPointCost:int;
      
      public var UpgradeNeedItem:int;
      
      public var UpgradeNeedCount:int;
      
      public function SkillTempInfo()
      {
         super();
      }
      
      public function get IsUseOnDead() : int
      {
         return _IsUseOnDead;
      }
      
      public function set IsUseOnDead(param1:int) : void
      {
         _IsUseOnDead = param1;
      }
      
      public function get Description() : String
      {
         return getDealDescript();
      }
      
      public function set Description(param1:String) : void
      {
         _Description = param1;
      }
      
      public function get CoolDown() : int
      {
         return getTalentEffectCdTime();
      }
      
      public function set CoolDown(param1:int) : void
      {
         _CoolDown = param1;
      }
      
      public function get Cost() : int
      {
         return getTalentEffectSp();
      }
      
      public function set Cost(param1:int) : void
      {
         _Cost = param1;
      }
      
      public function get HitPointCost() : int
      {
         return _HitPointCost;
      }
      
      public function set HitPointCost(param1:int) : void
      {
         _HitPointCost = param1;
      }
      
      public function get AcceptObject() : int
      {
         return getTalentEffectAttackObject();
      }
      
      public function set AcceptObject(param1:int) : void
      {
         _AcceptObject = param1;
      }
      
      public function get actionTemplateInfo() : ActionTemplateInfo
      {
         return TempleteManager.instance.actonTemplateCate.getTemplateByID(ActionId);
      }
      
      public function get preTempList() : Array
      {
         var _loc2_:SkillTempInfo = null;
         var _loc4_:Array = [];
         var _loc1_:Array = PreTemplateId.split(",");
         for each(var _loc3_:int in _loc1_)
         {
            if(_loc3_ > 0)
            {
               _loc2_ = TempleteManager.instance.getSkillTemplateInfoById(_loc3_);
               _loc4_.push(_loc2_);
            }
         }
         return _loc4_;
      }
      
      public function get nextTemp() : SkillTempInfo
      {
         return TempleteManager.instance.getSkillTemplateInfoById(NextTemplateId);
      }
      
      public function get useWayString() : String
      {
         switch(UseWay - 1)
         {
            case 0:
               return LanguageMgr.GetTranslation("yishi.datas.templates.SkillTempInfo.UseWay01");
            case 1:
               return LanguageMgr.GetTranslation("yishi.datas.templates.SkillTempInfo.UseWay02");
            default:
               return "";
         }
      }
      
      private function getTalentEffectCdTime() : int
      {
         var _loc6_:TalentEffectInfo = null;
         var _loc2_:Array = getTalentEffectIds();
         if(!_loc2_.length)
         {
            return _CoolDown;
         }
         var _loc5_:int = _CoolDown;
         var _loc3_:Number = 0;
         var _loc1_:int = 0;
         for each(var _loc4_:int in _loc2_)
         {
            _loc6_ = TempleteManager.instance.talentTemplateCate.getTemplateById(_loc4_);
            if(_loc6_.EffCdPercent)
            {
               _loc3_ += _loc6_.EffCdPercent;
            }
            if(_loc6_.EffCdValue)
            {
               _loc1_ += _loc6_.EffCdValue;
            }
         }
         if(_loc3_ != 0)
         {
            _loc5_ += _loc5_ * _loc3_ * 0.01;
         }
         if(_loc1_ != 0)
         {
            _loc5_ += _loc1_;
         }
         return int(_loc5_ * 0.001) * 1000;
      }
      
      private function getTalentEffectSp() : int
      {
         var _loc4_:TalentEffectInfo = null;
         var _loc3_:Array = getTalentEffectIds();
         if(!_loc3_)
         {
            return _Cost;
         }
         var _loc5_:int = _Cost;
         var _loc6_:Number = 0;
         var _loc1_:int = 0;
         for each(var _loc2_:int in _loc3_)
         {
            _loc4_ = TempleteManager.instance.talentTemplateCate.getTemplateById(_loc2_);
            if(_loc4_.EffSpPercent)
            {
               _loc6_ += _loc4_.EffSpPercent;
            }
            if(_loc4_.EffSpValue)
            {
               _loc1_ += _loc4_.EffSpValue;
            }
         }
         if(_loc6_ != 0)
         {
            _loc5_ += _loc5_ * _loc6_ * 0.01;
         }
         if(_loc1_ != 0)
         {
            _loc5_ += _loc1_;
         }
         return _loc5_;
      }
      
      private function getTalentEffectAttackObject() : int
      {
         var _loc3_:TalentEffectInfo = null;
         var _loc2_:Array = getTalentEffectIds();
         if(!_loc2_)
         {
            return _AcceptObject;
         }
         var _loc4_:int = _AcceptObject;
         for each(var _loc1_:int in _loc2_)
         {
            _loc3_ = TempleteManager.instance.talentTemplateCate.getTemplateById(_loc1_);
            if(_loc3_.EffAttackObject)
            {
               _loc4_ = _loc3_.EffAttackObject;
            }
         }
         return _loc4_;
      }
      
      private function getTalentEffectIds() : Array
      {
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc2_:SkillTempInfo = null;
         var _loc4_:Array = null;
         var _loc10_:BufferTemplateInfo = null;
         var _loc6_:Array = null;
         var _loc5_:TalentEffectInfo = null;
         var _loc1_:Array = [];
         var _loc12_:Array = [];
         if(thane.talentData.talentScript)
         {
            _loc7_ = thane.talentData.talentScript.split(",");
            _loc12_ = _loc12_.concat(_loc7_);
         }
         if(thane.talentData.advTalentScript)
         {
            _loc8_ = thane.talentData.advTalentScript.split(",");
            _loc12_ = _loc12_.concat(_loc8_);
         }
         for each(var _loc9_:int in _loc12_)
         {
            if(_loc9_ != 0)
            {
               _loc2_ = TempleteManager.instance.getSkillTemplateInfoById(_loc9_);
               _loc4_ = _loc2_.BufferIds.split(",");
               for each(var _loc11_:int in _loc4_)
               {
                  if(_loc11_ != 0)
                  {
                     _loc10_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc11_);
                     _loc6_ = _loc10_.TalentEffIds.split(",");
                     for each(var _loc3_:int in _loc6_)
                     {
                        if(_loc3_ != 0)
                        {
                           _loc5_ = TempleteManager.instance.talentTemplateCate.getTemplateById(_loc3_);
                           if(_loc5_.EffSkillType == -1 || _loc5_.EffSkillType == SonType)
                           {
                              _loc1_.push(_loc5_.TemplateId);
                           }
                        }
                     }
                  }
               }
            }
         }
         return getBattleTalentEffect(_loc1_);
      }
      
      private function getBattleTalentEffect(param1:Array) : Array
      {
         var _loc3_:* = undefined;
         var _loc5_:int = 0;
         var _loc8_:BufferDamageData = null;
         var _loc6_:BufferTemplateInfo = null;
         var _loc7_:Array = null;
         var _loc4_:TalentEffectInfo = null;
         var _loc9_:Array = param1;
         if(!BattleManager.getInstance().started || !BattleManager.getInstance().battleModel)
         {
            return _loc9_;
         }
         if(BattleManager.getInstance().battleModel.isMonsterBattle)
         {
            _loc3_ = BattleManager.getInstance().battleModel.selfMonsterRoleInfo.getBuffers();
         }
         else
         {
            _loc3_ = BattleManager.getInstance().battleModel.selfHero.getBuffers();
         }
         if(_loc3_ && _loc3_.length)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc8_ = _loc3_[_loc5_];
               _loc6_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc8_.templateId);
               if(_loc6_.TalentEffIds)
               {
                  _loc7_ = _loc6_.TalentEffIds.split(",");
                  for each(var _loc2_:int in _loc7_)
                  {
                     if(_loc2_ != 0)
                     {
                        _loc4_ = TempleteManager.instance.talentTemplateCate.getTemplateById(_loc2_);
                        if(_loc4_)
                        {
                           if(_loc4_.EffSkillType == -1 || _loc4_.EffSkillType == SonType)
                           {
                              if(_loc9_.indexOf(_loc4_.TemplateId) < 0)
                              {
                                 _loc9_.push(_loc4_.TemplateId);
                              }
                           }
                           if(_loc8_.targetSkillId == TemplateId && (_loc4_.EffSkillType == 850001 || _loc4_.EffSkillType == 1))
                           {
                              if(_loc9_.indexOf(_loc4_.TemplateId) < 0)
                              {
                                 _loc9_.push(_loc4_.TemplateId);
                              }
                           }
                        }
                     }
                  }
               }
               _loc5_++;
            }
         }
         return _loc9_;
      }
      
      private function getTalentEffectParameter1() : int
      {
         var _loc4_:TalentEffectInfo = null;
         var _loc2_:Array = getTalentEffectIds();
         if(!_loc2_)
         {
            return Math.abs(Parameter1);
         }
         var _loc3_:int = Parameter1;
         var _loc5_:Number = 0;
         for each(var _loc1_:int in _loc2_)
         {
            _loc4_ = TempleteManager.instance.talentTemplateCate.getTemplateById(_loc1_);
            if(_loc4_.EffDamPercent)
            {
               _loc5_ += _loc4_.EffDamPercent;
            }
         }
         if(_loc5_ != 0)
         {
            _loc3_ += _loc3_ * _loc5_ * 0.01;
         }
         return Math.abs(_loc3_);
      }
      
      private function getTalentEffectParameter2() : int
      {
         var _loc5_:TalentEffectInfo = null;
         var _loc3_:Array = getTalentEffectIds();
         if(!_loc3_)
         {
            return Math.abs(Parameter2);
         }
         var _loc4_:int = Parameter2;
         var _loc6_:Number = 0;
         var _loc1_:int = 0;
         for each(var _loc2_:int in _loc3_)
         {
            _loc5_ = TempleteManager.instance.talentTemplateCate.getTemplateById(_loc2_);
            if(_loc5_.EffDamPercent)
            {
               _loc6_ += _loc5_.EffDamPercent;
            }
            if(_loc5_.EffDamValue)
            {
               _loc1_ += _loc5_.EffDamValue;
            }
         }
         if(_loc6_ != 0)
         {
            _loc4_ += _loc4_ * _loc6_ * 0.01;
         }
         if(_loc1_)
         {
            _loc4_ += _loc1_;
         }
         return Math.abs(_loc4_);
      }
      
      private function getDealDescript() : String
      {
         var _loc1_:String = null;
         _loc1_ = StringHelper.replaceStr(_Description,"{Parameter1}",String(getTalentEffectParameter1()));
         _loc1_ = StringHelper.replaceStr(_loc1_,"{Parameter2}",String(getTalentEffectParameter2()));
         _loc1_ = StringHelper.replaceStr(_loc1_,"{Cost}",String(Math.abs(Cost)));
         return StringHelper.replaceStr(_loc1_,"{HitPointCost}",String(Math.abs(HitPointCost)));
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

