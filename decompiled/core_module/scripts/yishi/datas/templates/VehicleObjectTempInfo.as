package yishi.datas.templates
{
   import yishi.manager.TempleteManager;
   
   public class VehicleObjectTempInfo
   {
      
      public var TemplateId:int;
      
      public var TemplateName:String;
      
      public var Attack:int;
      
      public var Defence:int;
      
      public var Hp:int;
      
      public var Dodge:int;
      
      public var GeniusSkill:int;
      
      public var NormalSkill:int;
      
      public var Description:String;
      
      public var Avatar:String;
      
      public var Speed:int;
      
      public var NeedDiamond:int;
      
      public var NeedGrades:int;
      
      public var Sort:int;
      
      public var Type:int;
      
      private var _autoOpenGrade:int = -1;
      
      public function VehicleObjectTempInfo()
      {
         super();
      }
      
      public function get autoOpenGrade() : int
      {
         if(_autoOpenGrade != -1)
         {
            return _autoOpenGrade;
         }
         _autoOpenGrade = 1;
         var _loc1_:Array = TempleteManager.instance.getTemplatesByType(24);
         for each(var _loc2_:UpgradeTemplateInfo in _loc1_)
         {
            if(_loc2_.ActiveObject == TemplateId)
            {
               _autoOpenGrade = _loc2_.Grades;
            }
         }
         return _autoOpenGrade;
      }
   }
}

