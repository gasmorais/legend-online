package yishi.utils
{
   public class LogicObject
   {
      
      public var data:*;
      
      public function LogicObject()
      {
         super();
      }
      
      final public function callBackFunction(param1:Function) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.length > 0)
         {
            param1(this);
         }
         else
         {
            param1();
         }
      }
      
      public function dispose() : void
      {
         data = null;
      }
   }
}

