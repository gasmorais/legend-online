package mvc.module.securitycode
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.ByteArray;
   
   public class SecrityCodeModel extends EventDispatcher
   {
      
      public var byteArr_1:ByteArray;
      
      public var byteArr_2:ByteArray;
      
      public var byteArr_3:ByteArray;
      
      public var byteArr_4:ByteArray;
      
      public var remainCount:int = 0;
      
      public var remainTime:int;
      
      public function SecrityCodeModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
   }
}

