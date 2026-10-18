package newyearact
{
   import com.road.yishi.proto.active.PayInfoMsg;
   
   public class NewYearActPayModel
   {
      
      public var cur_PayPoint:int;
      
      public var curLevel:int;
      
      public var payCount:int;
      
      public var getCount:int;
      
      private var _payInfos:Array;
      
      public function NewYearActPayModel()
      {
         super();
      }
      
      public function set payInfos(param1:Array) : void
      {
         var _loc2_:PayInfoMsg = null;
         var _loc4_:int = 0;
         var _loc5_:PayInfoModel = null;
         _payInfos = [];
         if(!param1)
         {
            return;
         }
         var _loc3_:int = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = new PayInfoModel();
            _loc2_ = param1[_loc4_] as PayInfoMsg;
            _loc5_.dayNum = _loc2_.dayNum;
            _loc5_.payPoing = _loc2_.payPoint;
            _payInfos.push(_loc5_);
            _loc4_++;
         }
      }
      
      public function get payInfos() : Array
      {
         return _payInfos;
      }
   }
}

