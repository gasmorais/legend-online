package mvc.module.minos
{
   import yishi.datas.templates.MinosNodeTempInfo;
   import yishi.manager.TempleteManager;
   
   public class MinosNodeInfo
   {
      
      public var lv:int;
      
      public var x:int;
      
      public var y:int;
      
      public var isOpen:Boolean = true;
      
      public var progress:int;
      
      private var _id:int;
      
      private var _nodeTemp:MinosNodeTempInfo;
      
      public function MinosNodeInfo()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         if(_id == param1)
         {
            return;
         }
         _id = param1;
         _nodeTemp = TempleteManager.instance.minosNodeCate.getTemplateByID(_id);
      }
      
      public function get nodeTemp() : MinosNodeTempInfo
      {
         return _nodeTemp;
      }
   }
}

