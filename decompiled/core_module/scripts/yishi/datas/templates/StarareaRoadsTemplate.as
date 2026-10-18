package yishi.datas.templates
{
   import mvc.module.stararea.StarareaManager;
   
   public class StarareaRoadsTemplate
   {
      
      public var Id:int;
      
      public var Node1:int;
      
      public var Node2:int;
      
      public var Group:int;
      
      public function StarareaRoadsTemplate()
      {
         super();
      }
      
      public function get targetId() : int
      {
         if(StarareaManager.instance.model.myPointId == Node1)
         {
            return Node2;
         }
         return Node1;
      }
   }
}

