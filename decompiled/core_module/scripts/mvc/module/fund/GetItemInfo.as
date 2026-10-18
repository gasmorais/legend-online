package mvc.module.fund
{
   import com.road.yishi.proto.active.GItemInfoMsg;
   
   public class GetItemInfo
   {
      
      private var _interval:int;
      
      private var _times:int;
      
      private var _itemInfos:Array;
      
      public var _isGet:int = 0;
      
      private var _itemInfos2:Array;
      
      public var getA:int = 0;
      
      public var getB:int = 0;
      
      public function GetItemInfo()
      {
         super();
      }
      
      public function get interval() : int
      {
         return _interval;
      }
      
      public function set interval(param1:int) : void
      {
         _interval = param1;
      }
      
      public function get times() : int
      {
         return _times;
      }
      
      public function set times(param1:int) : void
      {
         _times = param1;
      }
      
      public function get itemInfos() : Array
      {
         return _itemInfos;
      }
      
      public function set itemInfos(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:GItemInfo = null;
         _itemInfos = [];
         var _loc2_:int = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new GItemInfo();
            _loc3_.templateId = param1[_loc4_].templateId;
            _loc3_.count = param1[_loc4_].count;
            _itemInfos.push(_loc3_);
            _loc4_++;
         }
      }
      
      public function get itemInfos2() : Array
      {
         return _itemInfos2;
      }
      
      public function set itemInfos2(param1:Array) : void
      {
         var _loc2_:GItemInfoMsg = null;
         var _loc5_:int = 0;
         var _loc4_:GItemInfo = null;
         _itemInfos2 = [];
         if(!param1)
         {
            return;
         }
         var _loc3_:int = int(param1.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = new GItemInfo();
            _loc2_ = param1[_loc5_] as GItemInfoMsg;
            if(_loc2_)
            {
               _loc4_.templateId = _loc2_.templateId;
               _loc4_.count = _loc2_.count;
               _itemInfos2.push(_loc4_);
            }
            _loc5_++;
         }
      }
   }
}

