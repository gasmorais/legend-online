package mvc.module.auction
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   [Event(name="change",type="flash.events.Event")]
   public class AuctionResultListData extends EventDispatcher
   {
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = 1;
      
      private var _list:Array = [];
      
      public function AuctionResultListData()
      {
         super();
      }
      
      public function update(param1:Array, param2:int, param3:int) : void
      {
         _list = param1;
         _currentPage = param2;
         _totalPage = param3;
         dispatchEvent(new Event("change"));
      }
      
      public function removeItem(param1:Object) : void
      {
         var _loc3_:Object = null;
         var _loc2_:int = 0;
         if(!_list)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _list.length)
         {
            _loc3_ = _list[_loc2_];
            if(_loc3_ == param1)
            {
               _list.splice(_loc2_,1);
               dispatchEvent(new Event("change"));
            }
            _loc2_++;
         }
      }
      
      public function getList() : Array
      {
         return _list;
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function get totalPage() : int
      {
         return _totalPage;
      }
      
      public function clear() : void
      {
         _list = [];
         _currentPage = 1;
         _totalPage = 1;
      }
   }
}

