package mvc.module.dragontalker
{
   import managers.DragonTalkerManager;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class DragonTalkerSymbioteInfo
   {
      
      public var index:int;
      
      public var grade:int;
      
      public var exp:int;
      
      public var curMaxExp:int;
      
      private var _sortGrade:int;
      
      public var currentExp:int;
      
      public function DragonTalkerSymbioteInfo()
      {
         super();
      }
      
      public function get addPercent() : int
      {
         var _loc1_:UpgradeTemplateInfo = model.symbioteUpgradeArr[grade - 1];
         if(_loc1_)
         {
            return _loc1_.ActiveObject;
         }
         return 0;
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      public function get sortGrade() : int
      {
         return TempleteManager.instance.getUpgradeGradeBy(142,currentExp);
      }
      
      public function get sortAddPercent() : int
      {
         var _loc1_:UpgradeTemplateInfo = model.symbioteUpgradeArr[sortGrade - 1];
         if(_loc1_)
         {
            return _loc1_.ActiveObject;
         }
         return 0;
      }
      
      public function set sortGrade(param1:int) : void
      {
         _sortGrade = param1;
      }
   }
}

