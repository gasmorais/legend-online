package mvc.module.faterotary
{
   import events.FateGuardEvent;
   import flash.events.EventDispatcher;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class FateRotarySkillInfo extends EventDispatcher
   {
      
      private var _templateId:int;
      
      public var fateTypes:int;
      
      private var _grades:int;
      
      private var _totalGp:int;
      
      public var property1:String;
      
      public var property2:String;
      
      public function FateRotarySkillInfo()
      {
         super();
      }
      
      public function get totalGp() : int
      {
         return _totalGp;
      }
      
      public function set totalGp(param1:int) : void
      {
         _totalGp = param1;
         dispatchEvent(new FateGuardEvent("fategpchange"));
      }
      
      public function get grades() : int
      {
         return _grades;
      }
      
      public function set grades(param1:int) : void
      {
         _grades = param1;
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(param1:int) : void
      {
         _templateId = param1;
      }
      
      public function get template() : SkillTempInfo
      {
         return TempleteManager.instance.getSkillTemplateInfoById(templateId);
      }
      
      public function get nextUpgradeTemp() : UpgradeTemplateInfo
      {
         return TempleteManager.instance.getTemplateByLevelAndType(grades + 1,upgradeType);
      }
      
      public function get currentGp() : int
      {
         var _loc5_:UpgradeTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc2_:int = _totalGp;
         var _loc1_:Array = TempleteManager.instance.getTemplatesByType(upgradeType);
         _loc1_.sortOn("TemplateId",16);
         var _loc3_:int = int(_loc1_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc1_[_loc4_];
            if(_loc2_ < _loc5_.Data)
            {
               return _loc2_;
            }
            _loc2_ -= _loc5_.Data;
            _loc4_++;
         }
         return 0;
      }
      
      public function get upgradeType() : int
      {
         if(fateTypes == 2000)
         {
            return 26;
         }
         if(fateTypes == 2200)
         {
            return 106;
         }
         if(fateTypes == 2100)
         {
            return 39;
         }
         return 26;
      }
   }
}

