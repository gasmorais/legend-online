package mvc.module.children
{
   import events.ChildPveEvent;
   import flash.events.EventDispatcher;
   
   public class ChildPveModel extends EventDispatcher
   {
      
      public static var CHALLENGE_INFO_CHAGNE:String = "CHALLENGE_INFO_CHAGNE";
      
      public static var CHALLENGE_TIME_CHANGE:String = "CHALLENGE_TIME_CHANGE";
      
      private var _bossInfo:Array;
      
      private var _skillInfo:Array;
      
      private var _orderList:Vector.<ChildPveOrderInfo>;
      
      public var orderTime:Date;
      
      public var rank:int;
      
      public var process:int;
      
      public function ChildPveModel()
      {
         super();
         orderList = new Vector.<ChildPveOrderInfo>();
      }
      
      public function get bossInfo() : Array
      {
         return _bossInfo;
      }
      
      public function set bossInfo(param1:Array) : void
      {
         _bossInfo = param1;
      }
      
      public function get skillInfo() : Array
      {
         return _skillInfo;
      }
      
      public function set skillInfo(param1:Array) : void
      {
         _skillInfo = param1;
      }
      
      public function get orderList() : Vector.<ChildPveOrderInfo>
      {
         return _orderList;
      }
      
      public function set orderList(param1:Vector.<ChildPveOrderInfo>) : void
      {
         _orderList = param1;
      }
      
      public function updateOrderList() : void
      {
         dispatchEvent(new ChildPveEvent("ORDERDATA_LOAD_COMPLETE"));
      }
   }
}

