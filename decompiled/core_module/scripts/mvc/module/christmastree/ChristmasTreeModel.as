package mvc.module.christmastree
{
   import events.ChristmasTreeEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import yishi.manager.FrameControllerManager;
   
   public class ChristmasTreeModel extends EventDispatcher
   {
      
      private var _rewardsInfo:Array;
      
      private var _luckShowInfo:Array;
      
      private var _showItemInfo:Array;
      
      private var _openCount:int;
      
      private var _boxMark:int;
      
      private var _boxMarkArr:Array = [];
      
      public function ChristmasTreeModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get rewardsInfo() : Array
      {
         return _rewardsInfo;
      }
      
      public function set rewardsInfo(param1:Array) : void
      {
         _rewardsInfo = param1;
         dispatchEvent(new ChristmasTreeEvent("CT_UPDATE_REWARDS_INFO",null));
      }
      
      public function get luckShowInfo() : Array
      {
         return _luckShowInfo;
      }
      
      public function set luckShowInfo(param1:Array) : void
      {
         _luckShowInfo = param1;
         dispatchEvent(new ChristmasTreeEvent("CT_UPDATE_LUCK_SHOW_INFO",null));
      }
      
      public function get showItemInfo() : Array
      {
         return _showItemInfo;
      }
      
      public function set showItemInfo(param1:Array) : void
      {
         _showItemInfo = param1;
         FrameControllerManager.instance.openControllerByInfo("christmastree");
      }
      
      public function get openCount() : int
      {
         return _openCount;
      }
      
      public function set openCount(param1:int) : void
      {
         _openCount = param1;
      }
      
      public function get boxMarkArr() : Array
      {
         return _boxMarkArr;
      }
      
      public function boxMark(param1:Array) : void
      {
         _boxMarkArr = [];
         var _loc2_:String = param1[0];
         if(_loc2_ == "")
         {
            return;
         }
         _boxMarkArr = _loc2_.split(";");
      }
   }
}

