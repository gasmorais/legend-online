package yishi.datas.templates
{
   public class GloryRoadDropTemplateInfo
   {
      
      public var site:String;
      
      public var itemId:int;
      
      public var count:int;
      
      public var ValidDate:String;
      
      public var id:int;
      
      public function GloryRoadDropTemplateInfo()
      {
         super();
      }
      
      public function getPassInfo() : Array
      {
         if(site)
         {
            return site.split(",");
         }
         return null;
      }
      
      public function getItemStr() : String
      {
         if(itemId && count)
         {
            return itemId + "," + count;
         }
         return "";
      }
   }
}

