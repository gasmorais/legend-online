package battle.skillsys.skills
{
   import battle.data.SkillData;
   import battle.skillsys.mode.ActionTemplateData;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class SkillFactory
   {
      
      public function SkillFactory()
      {
         super();
      }
      
      public static function createSkillByData(param1:SkillData) : BaseSkill
      {
         var _loc2_:BaseSkill = null;
         if(param1.skillId == -1)
         {
            _loc2_ = new EmptyActionSkill();
         }
         else
         {
            _loc2_ = createSkillBySkillId(param1.skillId);
         }
         _loc2_.setData(param1);
         return _loc2_;
      }
      
      private static function createSkillBySkillId(param1:int) : BaseSkill
      {
         var _loc3_:BaseSkill = null;
         var _loc2_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(param1);
         if(!_loc2_)
         {
            return new BaseSkill();
         }
         var _loc4_:int = _loc2_.ActionId;
         _loc3_ = createSkillBySkillTemp(_loc2_);
         _loc3_.actionId = _loc4_;
         return _loc3_;
      }
      
      private static function createSkillBySkillTemp(param1:SkillTempInfo) : BaseSkill
      {
         var _loc3_:BaseSkill = null;
         var _loc4_:int = param1.ActionId;
         var _loc2_:ActionTemplateData = TempleteManager.instance.actionTemplate2[_loc4_];
         if(!_loc2_)
         {
            return new BaseSkill();
         }
         _loc3_ = createSpecialSkill(param1);
         if(!_loc3_)
         {
            switch(_loc4_ - 3)
            {
               case 0:
                  _loc3_ = new SuccessSkill();
                  break;
               case 1:
                  _loc3_ = new FailedSkill();
                  break;
               default:
                  _loc3_ = createSkillByPresentType(_loc2_.presentType);
            }
         }
         _loc3_.setTemplate(_loc2_);
         return _loc3_;
      }
      
      private static function createSkillByPresentType(param1:int) : BaseSkill
      {
         var _loc2_:BaseSkill = null;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = new CommonActionSkill();
               break;
            case 1:
               _loc2_ = new ShootActionSkill();
         }
         return _loc2_;
      }
      
      private static function createSpecialSkill(param1:SkillTempInfo) : BaseSkill
      {
         if(param1.TemplateId == 105)
         {
            return new SpecialActionSkill105();
         }
         return null;
      }
   }
}

