package yishi.datas.playerinfo
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import mvc.module.armyII.SkillInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class SkillCategory extends EventDispatcher
   {
      
      protected static const SKILL_POINT:String = "SKILL_POINT";
      
      protected static const SKILL_INDEX:String = "SKILL_INDEX";
      
      protected static const ACTIVE_DOUBLE_SKILL:String = "ACTIVE_DOUBLE_SKILL";
      
      protected var _changeObj:SimpleDictionary;
      
      private var _skillPoint:int;
      
      private var _skillIndex:int;
      
      public var _activeDouble:Boolean;
      
      private var _skillScript:String;
      
      public var allSkillList:SimpleDictionary;
      
      public var allSkillTemp:Dictionary;
      
      private var _fastKey:String;
      
      private var _job:int;
      
      public function SkillCategory()
      {
         super();
         allSkillList = new SimpleDictionary(true);
         allSkillTemp = new Dictionary(true);
         _changeObj = new SimpleDictionary(true);
      }
      
      public function set skillPoint(param1:int) : void
      {
         if(param1 != _skillPoint)
         {
            _changeObj["SKILL_POINT"] = true;
         }
         _skillPoint = param1;
         InfoTipsManager.instance.dealData(14);
      }
      
      public function get skillPoint() : int
      {
         return _skillPoint;
      }
      
      public function set skillIndex(param1:int) : void
      {
         if(param1 != _skillIndex)
         {
            _changeObj["SKILL_INDEX"] = true;
            if(_job != 0)
            {
               initAllSkill(_job);
            }
         }
         _skillIndex = param1;
      }
      
      public function get skillIndex() : int
      {
         return _skillIndex;
      }
      
      public function set activeDouble(param1:Boolean) : void
      {
         if(param1 != _activeDouble)
         {
            _changeObj["ACTIVE_DOUBLE_SKILL"] = true;
         }
         _activeDouble = param1;
      }
      
      public function get activeDouble() : Boolean
      {
         return _activeDouble;
      }
      
      public function beginChange() : void
      {
         _changeObj.clear();
      }
      
      public function commit() : void
      {
         if(_changeObj["SKILL_POINT"])
         {
            dispatchEvent(new PlayerEvent("THANE_SKILL_POINT",null));
         }
         if(_changeObj["SKILL_INDEX"])
         {
            dispatchEvent(new PlayerEvent("SKILL_INDEX",null));
         }
         if(_changeObj["ACTIVE_DOUBLE_SKILL"])
         {
            dispatchEvent(new PlayerEvent("ACTIVE_DOUBLE_SKILL",null));
         }
      }
      
      public function get skillScript() : String
      {
         return _skillScript;
      }
      
      public function set skillScript(param1:String) : void
      {
         _skillScript = param1;
      }
      
      public function get fastKey() : String
      {
         return _fastKey;
      }
      
      public function set fastKey(param1:String) : void
      {
         _fastKey = param1;
      }
      
      public function initAllSkill(param1:int) : void
      {
         var _loc2_:SkillInfo = null;
         var _loc3_:int = 0;
         _job = param1;
         allSkillTemp = TempleteManager.instance.getAllSkillTemplateInfoByJob(_job);
         var _loc4_:SimpleDictionary = TempleteManager.instance.getMinSkillTemplateInfoByJob(_job);
         for each(var _loc5_:SkillTempInfo in _loc4_)
         {
            _loc2_ = new SkillInfo();
            _loc3_ = existSkill(_loc5_);
            if(_loc3_ > 0)
            {
               _loc2_.templateId = _loc3_;
               _loc2_.grade = _loc2_.templateInfo.Grades;
            }
            else
            {
               _loc2_.templateId = _loc5_.TemplateId;
               _loc2_.grade = 0;
            }
            allSkillList.add(_loc2_.templateInfo.Index,_loc2_);
         }
      }
      
      public function getSkillTemps() : Vector.<SkillTempInfo>
      {
         var _loc1_:SkillTempInfo = null;
         var _loc3_:Vector.<SkillTempInfo> = new Vector.<SkillTempInfo>();
         var _loc2_:Array = skillScript.split(",");
         for each(var _loc4_:int in _loc2_)
         {
            if(_loc4_ != 0)
            {
               _loc1_ = allSkillTemp[_loc4_];
               if(_loc1_)
               {
                  _loc3_.push(_loc1_);
               }
            }
         }
         return _loc3_;
      }
      
      public function fourChooseOne(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:SkillTempInfo = null;
         if(param1 < 3)
         {
            return false;
         }
         var _loc6_:int = (param1 - 3) / 4;
         var _loc3_:Array = skillScript.split(",");
         for each(var _loc5_:int in _loc3_)
         {
            if(_loc5_ != 0)
            {
               _loc2_ = allSkillTemp[_loc5_];
               if(_loc2_ && _loc2_.Index >= 3)
               {
                  _loc4_ = (_loc2_.Index - 3) / 4;
                  if(_loc6_ == _loc4_ && _loc2_.Index != param1)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public function getSkillBySontype(param1:int) : SkillInfo
      {
         var _loc2_:SkillTempInfo = null;
         var _loc3_:Array = skillScript.split(",");
         for each(var _loc4_:int in _loc3_)
         {
            if(_loc4_ != 0)
            {
               _loc2_ = allSkillTemp[_loc4_];
               if(_loc2_ && param1 == _loc2_.SonType)
               {
                  return allSkillList[_loc2_.Index];
               }
            }
         }
         return null;
      }
      
      public function get fastKeyLength() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:int in fastKey.split(","))
         {
            if(_loc2_ > 0)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function getFastkey() : SimpleDictionary
      {
         var _loc3_:int = 0;
         var _loc5_:SkillInfo = null;
         var _loc4_:SimpleDictionary = new SimpleDictionary(true);
         var _loc1_:Array = fastKey.split(",");
         var _loc2_:int = 0;
         _loc3_ = 1;
         while(_loc3_ < _loc1_.length)
         {
            if(_loc1_[_loc3_ - 1] != -1)
            {
               _loc5_ = getSkillBySontype(_loc1_[_loc3_ - 1]);
               if(_loc5_)
               {
                  _loc4_.add("fastkey_" + _loc3_,_loc5_.templateInfo.TemplateId);
                  _loc4_.add("index_" + _loc5_.templateInfo.TemplateId,_loc3_);
                  _loc2_++;
               }
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      public function existSkill(param1:SkillTempInfo) : int
      {
         var _loc2_:SkillTempInfo = null;
         var _loc3_:Array = skillScript.split(",");
         for each(var _loc4_:int in _loc3_)
         {
            if(_loc4_ != 0)
            {
               _loc2_ = allSkillTemp[_loc4_];
               if(_loc2_ && param1 && param1.SonType == _loc2_.SonType && param1.Grades <= _loc2_.Grades)
               {
                  return _loc2_.TemplateId;
               }
            }
         }
         return 0;
      }
      
      public function refreshAllSkill() : void
      {
         var _loc1_:SkillInfo = null;
         var _loc2_:int = 0;
         allSkillList = new SimpleDictionary(true);
         var _loc3_:SimpleDictionary = TempleteManager.instance.getMinSkillTemplateInfoByJob(_job);
         for each(var _loc4_:SkillTempInfo in _loc3_)
         {
            _loc1_ = new SkillInfo();
            _loc2_ = existSkill(_loc4_);
            if(_loc2_ > 0)
            {
               _loc1_.templateId = _loc2_;
               _loc1_.grade = _loc1_.templateInfo.Grades;
            }
            else
            {
               _loc1_.templateId = _loc4_.TemplateId;
               _loc1_.grade = 0;
            }
            allSkillList.add(_loc1_.templateInfo.Index,_loc1_);
         }
      }
   }
}

