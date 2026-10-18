package mvc.module.armyII
{
   import events.RuneEvent;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.RuneTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   
   public class RuneInfo extends EventDispatcher
   {
      
      public var userId:int;
      
      private var _runeId:int;
      
      public var runeCurGp:int;
      
      public var grade:int;
      
      public var swallowCount:int;
      
      public var runeHole:String;
      
      public var runeTempHole:String;
      
      public var newSkillTempId:int;
      
      public var baseProperties:BasePropertysInfo;
      
      public var templateInfo:RuneTemplateInfo;
      
      public function RuneInfo()
      {
         super();
         baseProperties = new BasePropertysInfo();
      }
      
      public function get runeId() : int
      {
         return _runeId;
      }
      
      public function set runeId(param1:int) : void
      {
         _runeId = param1;
         templateInfo = TempleteManager.instance.getRuneTemplateByTid(runeId);
      }
      
      public function get nextTemplateInfo() : RuneTemplateInfo
      {
         if(grade == 0)
         {
            return templateInfo;
         }
         var _loc1_:RuneTemplateInfo = TempleteManager.instance.getRuneTemplateByTid(templateInfo.NextRuneId);
         if(_loc1_ && _loc1_.Level == templateInfo.Level)
         {
            return _loc1_;
         }
         return null;
      }
      
      public function checkUpgradeCondition(param1:RuneTemplateInfo) : Array
      {
         var _loc2_:Array = [];
         if(param1.NeedGrade > thane.grades)
         {
            _loc2_.push(LanguageMgr.GetTranslation("buildings.BaseBuildFrame.gradeValue",param1.NeedGrade));
         }
         return _loc2_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function commit() : void
      {
         dispatchEvent(new RuneEvent("RUNE_UPGRADE",this));
      }
   }
}

