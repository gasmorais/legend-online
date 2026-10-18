package mvc.module.ringtask
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import yishi.utils.SimpleDictionary;
   
   public class RingTaskModel extends EventDispatcher
   {
      
      private var _rewardNum:int = 0;
      
      private var _hasAccessList:SimpleDictionary;
      
      public function RingTaskModel(param1:IEventDispatcher = null)
      {
         super(param1);
         _hasAccessList = new SimpleDictionary();
      }
      
      public function get rewardNum() : int
      {
         return _rewardNum + 1;
      }
      
      public function set rewardNum(param1:int) : void
      {
         _rewardNum = param1;
      }
      
      public function get hasAccessList() : SimpleDictionary
      {
         return _hasAccessList;
      }
      
      public function set hasAccessList(param1:SimpleDictionary) : void
      {
         _hasAccessList = param1;
      }
   }
}

