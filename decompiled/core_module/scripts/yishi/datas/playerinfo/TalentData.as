package yishi.datas.playerinfo
{
   import events.TalentEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import mvc.module.armyII.SkillInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class TalentData extends EventDispatcher
   {
      
      protected var _changeObj:SimpleDictionary;
      
      private var _talentPoint:int;
      
      private var _talentGrade:int;
      
      private var _advTalentPoint:int;
      
      private var _advTalentGrade:int;
      
      private var _talentScript:String;
      
      public var allTalentList:SimpleDictionary;
      
      private var _advTalentScript:String;
      
      public var allTaletTemp:Dictionary = new Dictionary(true);
      
      private var _job:int;
      
      public function TalentData()
      {
         super();
         allTalentList = new SimpleDictionary(true);
      }
      
      public static function isAdvTalent(param1:int) : Boolean
      {
         if(param1 >= 40 && param1 <= 60 || param1 == 80)
         {
            return true;
         }
         return false;
      }
      
      public function get talentScript() : String
      {
         return _talentScript;
      }
      
      public function set talentScript(param1:String) : void
      {
         _talentScript = param1;
      }
      
      public function get advTalentScript() : String
      {
         return _advTalentScript;
      }
      
      public function set advTalentScript(param1:String) : void
      {
         _advTalentScript = param1;
      }
      
      public function get talentGrade() : int
      {
         return _talentGrade;
      }
      
      public function set talentGrade(param1:int) : void
      {
         _talentGrade = param1;
      }
      
      public function get talentPoint() : int
      {
         return _talentPoint;
      }
      
      public function set talentPoint(param1:int) : void
      {
         _talentPoint = param1;
         InfoTipsManager.instance.dealData(14);
      }
      
      public function get advTalentGrade() : int
      {
         return _advTalentGrade;
      }
      
      public function set advTalentGrade(param1:int) : void
      {
         _advTalentGrade = param1;
      }
      
      public function get advTalentPoint() : int
      {
         return _advTalentPoint;
      }
      
      public function set advTalentPoint(param1:int) : void
      {
         _advTalentPoint = param1;
         InfoTipsManager.instance.dealData(14);
      }
      
      public function initAllSkill(param1:int) : void
      {
         var _loc8_:SimpleDictionary = null;
         var _loc4_:SimpleDictionary = null;
         var _loc3_:SkillInfo = null;
         var _loc7_:int = 0;
         var _loc5_:SkillInfo = null;
         var _loc6_:int = 0;
         _job = param1;
         if(_job == 4)
         {
            allTaletTemp = TempleteManager.instance.getAllSkillTemplateInfoByJob(70,80);
            _loc8_ = TempleteManager.instance.getMinTalentTemplateInfoByJob(70);
            _loc4_ = TempleteManager.instance.getMinAdvTalentTemplateInfoByJob(80);
         }
         else
         {
            allTaletTemp = TempleteManager.instance.getAllSkillTemplateInfoByJob(_job * 10);
            if(ArmyManager.instance.thane.vocationIndex > 0)
            {
               _loc8_ = TempleteManager.instance.getMinTalentTemplateInfoByJob(70);
            }
            else
            {
               _loc8_ = TempleteManager.instance.getMinTalentTemplateInfoByJob(_job * 10);
            }
            _loc4_ = TempleteManager.instance.getMinAdvTalentTemplateInfoByJob(_job * 10 + 30);
         }
         for each(var _loc9_:SkillTempInfo in _loc8_)
         {
            _loc3_ = new SkillInfo();
            _loc7_ = existSkill(_loc9_);
            if(_loc7_ > 0)
            {
               _loc3_.templateId = _loc7_;
               _loc3_.grade = _loc3_.templateInfo.Grades;
            }
            else
            {
               _loc3_.templateId = _loc9_.TemplateId;
               _loc3_.grade = 0;
            }
            allTalentList.add(_loc3_.templateInfo.Index,_loc3_);
         }
         for each(var _loc2_:SkillTempInfo in _loc4_)
         {
            _loc5_ = new SkillInfo();
            _loc6_ = existAdvSkill(_loc2_);
            if(_loc6_ > 0)
            {
               _loc5_.templateId = _loc6_;
               _loc5_.grade = _loc5_.templateInfo.Grades;
            }
            else
            {
               _loc5_.templateId = _loc2_.TemplateId;
               _loc5_.grade = 0;
            }
            allTalentList.add(_loc5_.templateInfo.Index,_loc5_);
         }
      }
      
      public function existSkill(param1:SkillTempInfo) : int
      {
         var _loc2_:SkillTempInfo = null;
         if(!talentScript)
         {
            return 0;
         }
         var _loc4_:Array = talentScript.split(",");
         for each(var _loc3_:int in _loc4_)
         {
            if(_loc3_ != 0)
            {
               _loc2_ = TempleteManager.instance.getSkillTemplateInfoById(_loc3_);
               if(_loc2_ && param1.SonType == _loc2_.SonType && param1.Grades <= _loc2_.Grades && param1.MasterType == _loc2_.MasterType)
               {
                  return _loc2_.TemplateId;
               }
            }
         }
         return 0;
      }
      
      public function existAdvSkill(param1:SkillTempInfo) : int
      {
         var _loc2_:SkillTempInfo = null;
         if(!advTalentScript)
         {
            return 0;
         }
         var _loc3_:Array = advTalentScript.split(",");
         for each(var _loc4_:int in _loc3_)
         {
            if(_loc4_ != 0)
            {
               _loc2_ = TempleteManager.instance.getSkillTemplateInfoById(_loc4_);
               if(_loc2_ && param1.SonType == _loc2_.SonType && param1.Grades <= _loc2_.Grades && param1.MasterType == _loc2_.MasterType)
               {
                  return _loc2_.TemplateId;
               }
            }
         }
         return 0;
      }
      
      public function getSkillTemps() : Vector.<SkillTempInfo>
      {
         var _loc1_:SkillTempInfo = null;
         var _loc3_:Vector.<SkillTempInfo> = new Vector.<SkillTempInfo>();
         var _loc2_:Array = talentScript.split(",");
         for each(var _loc4_:int in _loc2_)
         {
            if(_loc4_ != 0)
            {
               _loc1_ = allTaletTemp[_loc4_];
               if(_loc1_)
               {
                  _loc3_.push(_loc1_);
               }
            }
         }
         return _loc3_;
      }
      
      public function getSkillBySontype(param1:int) : SkillInfo
      {
         var _loc2_:SkillTempInfo = null;
         var _loc3_:Array = talentScript.split(",");
         for each(var _loc4_:int in _loc3_)
         {
            if(_loc4_ != 0)
            {
               _loc2_ = allTaletTemp[_loc4_];
               if(param1 == _loc2_.SonType)
               {
                  return allTalentList[_loc2_.Index];
               }
            }
         }
         return null;
      }
      
      public function beginChange() : void
      {
      }
      
      public function commit() : void
      {
         this.dispatchEvent(new TalentEvent("UPDATE_TALENT",null));
      }
   }
}

