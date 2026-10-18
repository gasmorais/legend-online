package mvc.module.avenger
{
   import yishi.datas.templates.AvengerBodyTempInfo;
   import yishi.manager.TempleteManager;
   
   public class AvengerBodyInfo
   {
      
      public var grade:int;
      
      public var exp:int;
      
      public function AvengerBodyInfo()
      {
         super();
      }
      
      public function get tempInfo() : AvengerBodyTempInfo
      {
         return TempleteManager.instance.avengerBodyTempCate.getTemplateByGrade(grade);
      }
      
      public function get nextTempInfo() : AvengerBodyTempInfo
      {
         return TempleteManager.instance.avengerBodyTempCate.getTemplateByGrade(grade + 1);
      }
      
      public function get degree() : int
      {
         if(!tempInfo)
         {
            return 0;
         }
         return tempInfo.BodyType;
      }
   }
}

