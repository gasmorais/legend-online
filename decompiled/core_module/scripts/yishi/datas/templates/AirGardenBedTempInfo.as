package yishi.datas.templates
{
   import yishi.utils.StringHelper;
   
   public class AirGardenBedTempInfo
   {
      
      public var TemplateId:int;
      
      public var ItemTempId:int;
      
      public var NodeType:int;
      
      public var Cost:String;
      
      public function AirGardenBedTempInfo()
      {
         super();
      }
      
      public function get limitCount() : int
      {
         if(StringHelper.isNullOrEmpty(Cost))
         {
            return 0;
         }
         return Cost.split(",").length;
      }
   }
}

