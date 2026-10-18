package mvc.module.armyII
{
   import events.SkillEvent;
   import events.TalentEvent;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.SimplePlayerInfo;
   import yishi.datas.playerinfo.TalentData;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class SkillInfo extends EventDispatcher
   {
      
      private var _templateId:int;
      
      public var grade:int;
      
      public var minGradeTemplateInfo:SkillTempInfo;
      
      public function SkillInfo()
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
      
      public function get remotePetMaxGrade() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_:SkillTempInfo in TempleteManager.instance.getAllRemotePetSkill())
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
      
      public function get talentMaxGrade() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_:SkillTempInfo in thane.talentData.allTaletTemp)
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
         if(param1.MasterType == 80)
         {
            return [LanguageMgr.GetTranslation("goddess.dedication.skDes",param1.Grades,"")];
         }
         return checkThaneSkillUpgradeCondition(param1);
      }
      
      private function checkThaneSkillUpgradeCondition(param1:SkillTempInfo) : Array
      {
         var _loc8_:SimplePlayerInfo = null;
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc10_:String = null;
         var _loc4_:String = null;
         var _loc2_:Array = [];
         var _loc9_:Array = param1.preTempList;
         var _loc3_:int = 80;
         if(param1.NeedPlayerGrade > _loc3_)
         {
            if(param1.NeedPlayerGrade > _loc3_ + playerInfo.vocationGrades)
            {
               _loc8_ = new SimplePlayerInfo();
               _loc8_.vocationGrades = param1.NeedPlayerGrade - _loc3_;
               _loc5_ = PlayerManager.instance.getVocationName(thane.templateInfo.Job,_loc8_.vocationStep,_loc8_.vocationLevel);
               _loc2_.push(_loc5_);
            }
         }
         else if(param1.NeedPlayerGrade > thane.grades)
         {
            _loc2_.push(LanguageMgr.GetTranslation("buildings.BaseBuildFrame.gradeValue",param1.NeedPlayerGrade));
         }
         if(param1.MasterType == 200)
         {
            _loc7_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.UpgradeNeedItem).TemplateName;
            _loc10_ = _loc7_ + " * " + param1.UpgradeNeedCount;
            _loc2_.push(_loc10_);
            return _loc2_;
         }
         for each(var _loc6_:SkillTempInfo in _loc9_)
         {
            if(_loc6_ && !thane.existSkill(_loc6_))
            {
               _loc4_ = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc6_.TemplateName + _loc6_.Grades);
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_;
      }
      
      public function checkTalentUpgradeCondition(param1:SkillTempInfo) : Array
      {
         var _loc3_:String = null;
         var _loc2_:Array = [];
         var _loc5_:Array = param1.preTempList;
         if(TalentData.isAdvTalent(param1.MasterType))
         {
            if(param1.Parameter3 > thane.talentData.advTalentGrade)
            {
               _loc2_.push(LanguageMgr.GetTranslation("mvc.module.armyII.SkillInfo.advanceTalentLevel",param1.Parameter3));
            }
         }
         else
         {
            if(param1.NeedPlayerGrade > thane.grades)
            {
               _loc2_.push(LanguageMgr.GetTranslation("buildings.BaseBuildFrame.gradeValue",param1.NeedPlayerGrade));
            }
            for each(var _loc4_:SkillTempInfo in _loc5_)
            {
               if(!thane.existTalent(_loc4_))
               {
                  _loc3_ = _loc4_.TemplateName + " " + LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc4_.Grades);
                  _loc2_.push(_loc3_);
               }
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
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get dragonTalkerModel() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      public function commit(param1:int = 0) : void
      {
         if(param1 == 0)
         {
            dispatchEvent(new SkillEvent("SKILL_UPGRADE",this));
         }
         else
         {
            dispatchEvent(new TalentEvent("TALENT_UPGRADE",this));
         }
      }
   }
}

