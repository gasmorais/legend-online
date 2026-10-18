package mvc.module.mounts
{
   import yishi.manager.TempleteManager;
   
   public class MountRefiningSoulInfo
   {
      
      public var strengthGrade:int;
      
      public var intellectGrade:int;
      
      public var staminaGrade:int;
      
      public var armorGrade:int;
      
      public var curExp:int;
      
      public function MountRefiningSoulInfo()
      {
         super();
      }
      
      public function get totalGrade() : int
      {
         return strengthGrade + intellectGrade + staminaGrade + armorGrade;
      }
      
      public function getSkillGrade() : int
      {
         var _loc1_:Array = TempleteManager.instance.getNewUpgradeGradeBy(145,totalGrade);
         return _loc1_[1];
      }
      
      public function get isSkillMax() : Boolean
      {
         var _loc2_:Array = TempleteManager.instance.getTemplatesByType(144);
         var _loc1_:int = int(_loc2_[_loc2_.length - 1].Grades);
         return strengthGrade >= _loc1_ && intellectGrade >= _loc1_ && staminaGrade >= _loc1_ && armorGrade >= _loc1_;
      }
      
      public function getSkillAddPercent() : int
      {
         var _loc1_:int = getSkillGrade();
         return TempleteManager.instance.getTemplateByLevelAndType(_loc1_,145).ActiveObject;
      }
      
      public function getPropAddPercentByPropName(param1:String) : int
      {
         var _loc2_:int = getPropGradeByPropName(param1);
         if(_loc2_ == 0)
         {
            return 0;
         }
         return TempleteManager.instance.getTemplateByLevelAndType(_loc2_,144).ActiveObject;
      }
      
      public function getPropGradeByPropName(param1:String) : int
      {
         switch(param1)
         {
            case "Strength":
               return strengthGrade;
            case "Intellect":
               return intellectGrade;
            case "Armor":
               return armorGrade;
            case "Stamina":
               return staminaGrade;
            default:
               return 0;
         }
      }
   }
}

