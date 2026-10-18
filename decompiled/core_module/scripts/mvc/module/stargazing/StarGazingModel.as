package mvc.module.stargazing
{
   import yishi.utils.MsgMan;
   
   public class StarGazingModel
   {
      
      public static const STAR_POWER_NUM:int = 100;
      
      private var _selectStarIndex:int = 0;
      
      public var starPieceCount:int;
      
      public var starDesire:int;
      
      public var normalWishCount:int;
      
      public var advanceWishCount:int;
      
      public var isTurnChange:Boolean = false;
      
      public var starChartTotalProperty:StarGazingPropertyInfo;
      
      public var starPalaceList:Array;
      
      public function StarGazingModel()
      {
         super();
         starChartTotalProperty = new StarGazingPropertyInfo();
         starPalaceList = [];
      }
      
      public function getPalaceInfoByIndex(param1:int) : StarPalaceInfo
      {
         for each(var _loc2_:StarPalaceInfo in starPalaceList)
         {
            if(_loc2_.index == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get palaceAllOpen() : Boolean
      {
         if(starPalaceList.length < 12)
         {
            return false;
         }
         for each(var _loc1_:StarPalaceInfo in starPalaceList)
         {
            if(!_loc1_.chartAllOpen)
            {
               return false;
            }
         }
         return true;
      }
      
      public function get selectStarIndex() : int
      {
         return _selectStarIndex;
      }
      
      public function set selectStarIndex(param1:int) : void
      {
         if(selectStarIndex == param1)
         {
            return;
         }
         _selectStarIndex = param1;
         MsgMan.notifyObserver("SELECT_STAR_INDEX_CHANGE");
      }
      
      public function commitBallChange() : void
      {
         MsgMan.notifyObserver("STAR_POWER_CHANGE");
      }
   }
}

