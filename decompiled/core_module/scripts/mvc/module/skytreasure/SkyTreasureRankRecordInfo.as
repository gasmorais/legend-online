package mvc.module.skytreasure
{
   import manager.LanguageMgr;
   
   public class SkyTreasureRankRecordInfo
   {
      
      private var _actId:String;
      
      private var _desc:String;
      
      private var _rankInfoArray:Array;
      
      private var _myRank:int;
      
      private var _myscore:int;
      
      public function SkyTreasureRankRecordInfo(param1:String, param2:String, param3:Array, param4:int, param5:int)
      {
         super();
         _actId = param1;
         _desc = param2;
         _myRank = param4;
         _myscore = param5;
         _rankInfoArray = param3;
      }
      
      public function get myscore() : int
      {
         return _myscore;
      }
      
      public function get myRank() : int
      {
         return _myRank;
      }
      
      public function get actId() : String
      {
         return _actId;
      }
      
      public function get desc() : String
      {
         return _desc;
      }
      
      public function get rankDesc() : String
      {
         return _myRank ? _myRank + "" : LanguageMgr.GetTranslation("SkyTreasureRecordWnd.noRank");
      }
      
      public function get rankInfoArray() : Array
      {
         return _rankInfoArray;
      }
   }
}

