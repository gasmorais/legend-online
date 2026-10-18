package mvc.module.stokesore
{
   import events.StokesOreEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class StokesOreModel extends EventDispatcher
   {
      
      public static var DISTANCE1:int = 40;
      
      public static var DISTANCE2:int = 135;
      
      public var startDate:Date;
      
      public var endDate:Date;
      
      private var _oneOpenCost:int;
      
      private var _tenOpenCost:int;
      
      private var _todayLeftNumber:int;
      
      private var _curSeq:int;
      
      private var _todayLeftNumber2:int;
      
      private var _oreRewardsInfo:Array;
      
      private var _oreLuckShowInfo:Array;
      
      private var _layerArray:Array;
      
      private var _countDown:int;
      
      public var openStokesOre:Boolean;
      
      private var _goodsDic:Dictionary;
      
      private var _speed2:Number;
      
      private var _speed3:Number;
      
      private var _speed4:Number;
      
      private var _speed5:Number;
      
      public function StokesOreModel()
      {
         super();
      }
      
      public function get layerArray() : Array
      {
         return _layerArray;
      }
      
      public function set layerArray(param1:Array) : void
      {
         _layerArray = param1;
      }
      
      public function get oreLuckShowInfo() : Array
      {
         return _oreLuckShowInfo;
      }
      
      public function set oreLuckShowInfo(param1:Array) : void
      {
         _oreLuckShowInfo = param1;
         dispatchEvent(new StokesOreEvent("UPDATE_LUCK_SHOW_INFO"));
      }
      
      public function get oreRewardsInfo() : Array
      {
         return _oreRewardsInfo;
      }
      
      public function set oreRewardsInfo(param1:Array) : void
      {
         _oreRewardsInfo = param1;
         dispatchEvent(new StokesOreEvent("UPDATE_REWARDS_INFO"));
      }
      
      public function get countDown() : int
      {
         return _countDown;
      }
      
      public function set countDown(param1:int) : void
      {
         _countDown = param1;
      }
      
      public function get curSeq() : int
      {
         return _curSeq;
      }
      
      public function set curSeq(param1:int) : void
      {
         _curSeq = param1;
      }
      
      public function get goodsDic() : Dictionary
      {
         return _goodsDic;
      }
      
      public function set goodsDic(param1:Dictionary) : void
      {
         _goodsDic = param1;
      }
      
      public function get todayLeftNumber2() : int
      {
         return _todayLeftNumber2;
      }
      
      public function set todayLeftNumber2(param1:int) : void
      {
         _todayLeftNumber2 = param1;
      }
      
      public function get todayLeftNumber() : int
      {
         return _todayLeftNumber;
      }
      
      public function set todayLeftNumber(param1:int) : void
      {
         _todayLeftNumber = param1;
      }
      
      public function get tenOpenCost() : int
      {
         return _tenOpenCost;
      }
      
      public function set tenOpenCost(param1:int) : void
      {
         _tenOpenCost = param1;
      }
      
      public function get oneOpenCost() : int
      {
         return _oneOpenCost;
      }
      
      public function set oneOpenCost(param1:int) : void
      {
         _oneOpenCost = param1;
      }
      
      public function startNextOre() : void
      {
         dispatchEvent(new StokesOreEvent("START_NEXT_ORE"));
      }
      
      public function updateCrossInfo() : void
      {
         dispatchEvent(new StokesOreEvent("UPDATE_CROSSINFO"));
      }
      
      public function updateStatus() : void
      {
         dispatchEvent(new StokesOreEvent("UPDATE_STATUS",null));
      }
      
      public function initSpeed() : void
      {
         var _loc1_:int = 0;
         if(!layerArray)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < layerArray.length)
         {
            if(_loc1_ == 1)
            {
               _speed2 = DISTANCE2 / (layerArray[1] - layerArray[0]);
            }
            else if(_loc1_ == 2)
            {
               _speed3 = DISTANCE2 / (layerArray[2] - layerArray[1]);
            }
            else if(_loc1_ == 3)
            {
               _speed4 = DISTANCE2 / (layerArray[3] - layerArray[2]);
            }
            else if(_loc1_ == 4)
            {
               _speed5 = DISTANCE2 / (layerArray[4] - layerArray[3]);
            }
            _loc1_++;
         }
      }
      
      public function getLocationX(param1:int) : int
      {
         var _loc2_:int = 0;
         if(!layerArray || layerArray.length != 5)
         {
            return 0;
         }
         if(param1 >= layerArray[4])
         {
            _loc2_ = 580;
         }
         else if(param1 >= layerArray[3] && param1 < layerArray[4])
         {
            _loc2_ = 445 + (param1 - layerArray[3]) * _speed5;
         }
         else if(param1 >= layerArray[2] && param1 < layerArray[3])
         {
            _loc2_ = 310 + (param1 - layerArray[2]) * _speed4;
         }
         else if(param1 >= layerArray[1] && param1 < layerArray[2])
         {
            _loc2_ = 175 + (param1 - layerArray[1]) * _speed3;
         }
         else if(param1 >= layerArray[0] && param1 < layerArray[1])
         {
            _loc2_ = 40 + (param1 - layerArray[0]) * _speed2;
         }
         else if(param1 < layerArray[0])
         {
            _loc2_ = DISTANCE1 * param1 / layerArray[0];
         }
         return _loc2_;
      }
   }
}

