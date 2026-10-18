package mvc.module.llk
{
   public class LlkNodeData
   {
      
      public var row:int;
      
      public var col:int;
      
      public var val:int;
      
      private var _mcType:int;
      
      public function LlkNodeData()
      {
         super();
      }
      
      public function get mcType() : int
      {
         return _mcType;
      }
      
      public function set mcType(param1:int) : void
      {
         if(_mcType == 1 && param1 != 1)
         {
            trace(3423424234);
         }
         if(param1 == 1 || param1 == 2)
         {
            trace("连线" + col + " " + row);
         }
         _mcType = param1;
      }
   }
}

