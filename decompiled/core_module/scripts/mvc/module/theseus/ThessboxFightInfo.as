package mvc.module.theseus
{
   public class ThessboxFightInfo
   {
      
      public var type:int;
      
      public var curLevel:int;
      
      public var chapterId:int;
      
      public var mapId:int;
      
      public var equipSkills:String = "-1,-1,-1";
      
      public var allSkills:Array;
      
      public var addSkill:int;
      
      public function ThessboxFightInfo()
      {
         super();
      }
      
      public function updateEquip(param1:int, param2:int) : void
      {
         var _loc3_:Array = null;
         if(equipSkills)
         {
            _loc3_ = equipSkills.split(",");
            _loc3_[param1] = param2;
            equipSkills = _loc3_.join(",");
         }
      }
   }
}

