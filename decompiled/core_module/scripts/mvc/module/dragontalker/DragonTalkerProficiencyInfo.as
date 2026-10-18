package mvc.module.dragontalker
{
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   
   public class DragonTalkerProficiencyInfo
   {
      
      public var index:int;
      
      public var activeSkillId:int;
      
      public function DragonTalkerProficiencyInfo()
      {
         super();
      }
      
      public function get isActive() : Boolean
      {
         if(thane.vocationGrades <= 0)
         {
            return false;
         }
         if(thane.isChangeJob)
         {
            return true;
         }
         return int(Math.ceil((thane.vocationGrades - 10) / 20)) >= index;
      }
      
      public function get skillTemp() : SkillTempInfo
      {
         return TempleteManager.instance.skillTemplateDic[activeSkillId];
      }
      
      public function get skillIndex() : int
      {
         return skillTemp ? skillTemp.Index : 0;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

