package mvc.module.armyII
{
   import events.SkillEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   
   public class TalentInfo extends EventDispatcher
   {
      
      private var _templateId:int;
      
      public var grade:int;
      
      public var minGradeTemplateInfo:SkillTempInfo;
      
      public function TalentInfo(param1:IEventDispatcher = null)
      {
         super();
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(param1:int) : void
      {
         if(_templateId != param1)
         {
            _templateId = param1;
            minGradeTemplateInfo = TempleteManager.instance.getMinSkillTemplateInfoBySonType(templateInfo.SonType);
         }
      }
      
      public function get templateInfo() : SkillTempInfo
      {
         return TempleteManager.instance.getSkillTemplateInfoById(_templateId);
      }
      
      public function get nextTemplateInfo() : SkillTempInfo
      {
         if(grade == 0)
         {
            return templateInfo;
         }
         return templateInfo.nextTemp;
      }
      
      public function get nextTempPreTempList() : Array
      {
         if(nextTemplateInfo)
         {
            return nextTemplateInfo.preTempList;
         }
         return null;
      }
      
      public function get maxGrade() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_:SkillTempInfo in thane.skillCate.allSkillTemp)
         {
            if(_loc1_.SonType == templateInfo.SonType)
            {
               if(_loc2_ < _loc1_.Grades)
               {
                  _loc2_ = _loc1_.Grades;
               }
            }
         }
         return _loc2_;
      }
      
      public function checkUpgradeCondition(param1:SkillTempInfo) : Array
      {
         var _loc3_:String = null;
         var _loc2_:Array = [];
         var _loc5_:Array = param1.preTempList;
         if(param1.NeedPlayerGrade > thane.grades)
         {
            _loc2_.push(LanguageMgr.GetTranslation("buildings.BaseBuildFrame.gradeValue",param1.NeedPlayerGrade));
         }
         for each(var _loc4_:SkillTempInfo in _loc5_)
         {
            if(!thane.existSkill(_loc4_))
            {
               _loc3_ = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc4_.TemplateName + _loc4_.Grades);
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function checkGrade() : Boolean
      {
         if(grade < maxGrade)
         {
            return true;
         }
         return false;
      }
      
      public function reset() : void
      {
         grade = 0;
         templateId = minGradeTemplateInfo.TemplateId;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function commit() : void
      {
         dispatchEvent(new SkillEvent("SKILL_UPGRADE",this));
      }
   }
}

