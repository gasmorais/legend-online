package mvc.module.fund
{
   import com.road.yishi.proto.active.GItemInfoMsg;
   import com.road.yishi.proto.active.GetItemInfosMsg;
   
   public class ActiveParmaInfo
   {
      
      private var _level:int;
      
      private var _costDiamond:int;
      
      private var _costContract:int;
      
      private var _getBindingDia:int;
      
      private var _harvestCount:int;
      
      private var _getInfos:Array;
      
      private var _totalGetInfo:Array;
      
      private var _allGetA:Array;
      
      private var _allGetB:Array;
      
      private var _newGetInfos:Array;
      
      public function ActiveParmaInfo()
      {
         super();
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
      }
      
      public function get costDiamond() : int
      {
         return _costDiamond;
      }
      
      public function set costDiamond(param1:int) : void
      {
         _costDiamond = param1;
      }
      
      public function get costContract() : int
      {
         return _costContract;
      }
      
      public function set costContract(param1:int) : void
      {
         _costContract = param1;
      }
      
      public function get getBindingDia() : int
      {
         return _getBindingDia;
      }
      
      public function set getBindingDia(param1:int) : void
      {
         _getBindingDia = param1;
      }
      
      public function get harvestCount() : int
      {
         return _harvestCount;
      }
      
      public function set harvestCount(param1:int) : void
      {
         _harvestCount = param1;
      }
      
      public function get getInfos() : Array
      {
         return _getInfos;
      }
      
      public function set getInfos(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:GetItemInfo = null;
         _getInfos = [];
         var _loc2_:int = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new GetItemInfo();
            _loc3_.interval = param1[_loc4_].interval;
            _loc3_.times = param1[_loc4_].times;
            _loc3_.itemInfos = param1[_loc4_].itemInfo;
            _getInfos.push(_loc3_);
            _loc4_++;
         }
      }
      
      public function get totalGetInfo() : Array
      {
         return _totalGetInfo;
      }
      
      public function set totalGetInfo(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:GItemInfo = null;
         _totalGetInfo = [];
         var _loc2_:int = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new GItemInfo();
            _loc3_.templateId = param1[_loc4_].templateId;
            _loc3_.count = param1[_loc4_].count;
            totalGetInfo.push(_loc3_);
            _loc4_++;
         }
      }
      
      public function getCurrItem() : void
      {
      }
      
      public function get allGetA() : Array
      {
         return _allGetA;
      }
      
      public function set allGetA(param1:Array) : void
      {
         var _loc2_:GItemInfoMsg = null;
         var _loc5_:int = 0;
         var _loc4_:GItemInfo = null;
         _allGetA = [];
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
               _allGetA.push(_loc4_);
            }
            _loc5_++;
         }
      }
      
      public function get allGetB() : Array
      {
         return _allGetB;
      }
      
      public function set allGetB(param1:Array) : void
      {
         var _loc2_:GItemInfoMsg = null;
         var _loc5_:int = 0;
         var _loc4_:GItemInfo = null;
         _allGetB = [];
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
               _allGetB.push(_loc4_);
            }
            _loc5_++;
         }
      }
      
      public function get newGetInfos() : Array
      {
         return _newGetInfos;
      }
      
      public function set newGetInfos(param1:Array) : void
      {
         var _loc2_:GetItemInfosMsg = null;
         var _loc5_:int = 0;
         var _loc4_:GetItemInfo = null;
         _newGetInfos = [];
         if(!param1)
         {
            return;
         }
         var _loc3_:int = int(param1.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = new GetItemInfo();
            _loc2_ = param1[_loc5_] as GetItemInfosMsg;
            if(_loc2_)
            {
               _loc4_.interval = _loc2_.interval;
               _loc4_.times = _loc2_.times;
               _loc4_.itemInfos = _loc2_.itemInfo;
               _loc4_.itemInfos2 = _loc2_.itemInfo2;
               _newGetInfos.push(_loc4_);
            }
            _loc5_++;
         }
      }
   }
}

