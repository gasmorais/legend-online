package yishi.datas.templates
{
   public class GloryRoadBufferTemplateInfo
   {
      
      public var TemplateId:int;
      
      public var Type:int;
      
      public var Desc:String;
      
      public var Value:int;
      
      public var Percent:Number;
      
      public var Pos:int;
      
      public var Price:int;
      
      public var index:int;
      
      public var isPurchased:Boolean = false;
      
      public function GloryRoadBufferTemplateInfo()
      {
         super();
      }
      
      public function get isBuffShowView() : Boolean
      {
         return Type == 1 || Type == 2 || Type == 3 || Type == 4;
      }
   }
}

