package mvc.module.archeology
{
   import yishi.datas.templates.ArchaeologyItemTemplate;
   import yishi.manager.TempleteManager;
   
   public class ArchaeologyItemInfo
   {
      
      public var tempId:int;
      
      public var chipCount:int;
      
      public var itemCount:int;
      
      public var groupId:int;
      
      public var cellType:int = 2;
      
      public var selected:Boolean = false;
      
      private var _canMakeCount:int;
      
      public function ArchaeologyItemInfo()
      {
         super();
      }
      
      public function get canMakeCount() : int
      {
         var _loc1_:ArchaeologyItemTemplate = TempleteManager.instance.archaeologyItemTemplateCate.getTemplateByID(tempId);
         if(!_loc1_)
         {
            return _canMakeCount;
         }
         return int(chipCount / _loc1_.NeedChip);
      }
      
      public function set canMakeCount(param1:int) : void
      {
         _canMakeCount = param1;
      }
   }
}

