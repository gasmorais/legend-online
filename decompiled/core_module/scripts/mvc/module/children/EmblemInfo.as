package mvc.module.children
{
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class EmblemInfo
   {
      
      public var pos:int = 0;
      
      public var resi1:int = 0;
      
      public var grade1:int = 0;
      
      public var gp1:int = 0;
      
      public var resi2:int = 0;
      
      public var grade2:int = 0;
      
      public var gp2:int = 0;
      
      public var resi3:int = 0;
      
      public var grade3:int = 0;
      
      public var gp3:int = 0;
      
      public function EmblemInfo()
      {
         super();
      }
      
      public function getValueByIndex(param1:int) : int
      {
         var _loc3_:UpgradeTemplateInfo = null;
         var _loc2_:int = 0;
         if(this.hasOwnProperty(["grade" + param1]))
         {
            if(pos == 1)
            {
               _loc3_ = TempleteManager.instance.getTemplateByLevelAndType(grade1,49);
            }
            else
            {
               _loc3_ = TempleteManager.instance.getTemplateByLevelAndType(this["grade" + param1],48);
            }
            if(_loc3_)
            {
               _loc2_ = _loc3_.ActiveObject;
            }
         }
         return _loc2_;
      }
   }
}

