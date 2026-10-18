package mountact
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class MountActModel extends EventDispatcher
   {
      
      public var beginTm:String;
      
      public var endTm:String;
      
      public var mountLevel:int;
      
      public var rebate:int;
      
      public var toalCost:int;
      
      public var rebatePoint:int;
      
      public var complete:Boolean;
      
      public function MountActModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
   }
}

