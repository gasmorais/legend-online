package mvc.module.skytreasure
{
   import com.road.yishi.proto.cccactive.ActiveRankPB;
   import com.road.yishi.proto.cccactive.SkyTreasureRankInfoPB;
   import yishi.utils.SimpleDictionary;
   
   public class SkyTreasureRankDataInfo
   {
      
      private var _actId:String;
      
      private var _skyTreasureGradeInfoDic:SimpleDictionary = new SimpleDictionary();
      
      private var _myGrade:int = 0;
      
      private var _myRank:int = 0;
      
      public function SkyTreasureRankDataInfo(param1:SkyTreasureRankInfoPB)
      {
         super();
         _actId = param1.activeId;
         if(param1.hasSelf)
         {
            updateSelfRankInfo(param1.self.rank,param1.self.score);
         }
         for each(var _loc2_:ActiveRankPB in param1.ranks)
         {
            addSkyTreasureGradeInfo(_loc2_.rank,_loc2_.site,_loc2_.nickName || _loc2_.userName,_loc2_.score);
         }
      }
      
      public function get actId() : String
      {
         return _actId;
      }
      
      public function addSkyTreasureGradeInfo(param1:int, param2:String, param3:String, param4:int) : void
      {
         var _loc5_:SkyTreasureGradeInfo = new SkyTreasureGradeInfo(param1,param2,param3,param4);
         _skyTreasureGradeInfoDic.add(param1,_loc5_);
      }
      
      public function get skyTreasureGradeRankArray() : Array
      {
         return _skyTreasureGradeInfoDic.keys;
      }
      
      public function getOneGradeInfoByRank(param1:int) : SkyTreasureGradeInfo
      {
         return _skyTreasureGradeInfoDic[param1] as SkyTreasureGradeInfo;
      }
      
      public function deleteCurrGradeInfo() : void
      {
         _skyTreasureGradeInfoDic.clear();
      }
      
      public function updateSelfRankInfo(param1:int, param2:int) : void
      {
         _myGrade = param2;
         _myRank = param1;
      }
      
      public function get myRank() : int
      {
         return _myRank;
      }
      
      public function get myGrade() : int
      {
         return _myGrade;
      }
   }
}

