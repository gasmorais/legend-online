package mvc.module.remotepet
{
   public class RemotePetTurnInfo
   {
      
      public static const MAX_TURN_NUM:int = 18;
      
      public static const TOTAL_NUM:int = 15;
      
      public var goodsList:String;
      
      public var specialIndex:String;
      
      public var currPage:int;
      
      public var currTurn:int;
      
      public var maxTurn:int;
      
      public var remotePetTurnList:Vector.<RemotePetTurnItemInfo>;
      
      public var showTurnList:Vector.<RemotePetTurnItemInfo>;
      
      public var currentPageNum:int = 18;
      
      public function RemotePetTurnInfo()
      {
         super();
         remotePetTurnList = new Vector.<RemotePetTurnItemInfo>();
         showTurnList = new Vector.<RemotePetTurnItemInfo>();
      }
      
      public function updateShowTurnList() : void
      {
         var _loc1_:int = (currPage - 1) * currentPageNum;
         var _loc2_:int = _loc1_ + currentPageNum;
         if(_loc2_ > remotePetTurnList.length)
         {
            _loc2_ = int(remotePetTurnList.length);
         }
         showTurnList = remotePetTurnList.slice(_loc1_,_loc2_);
      }
      
      public function reseData(param1:int = 1) : void
      {
         currPage = Math.ceil(currTurn / 15);
         if(currPage < 1)
         {
            currPage = 1;
         }
      }
      
      public function get totalPage() : int
      {
         var _loc1_:int = Math.ceil((maxTurn + 1) / 15);
         if(_loc1_ < 1)
         {
            _loc1_ = 1;
         }
         return _loc1_;
      }
      
      public function get specialIndexOfArray() : Array
      {
         if(specialIndex)
         {
            return specialIndex.split(",");
         }
         return [];
      }
   }
}

