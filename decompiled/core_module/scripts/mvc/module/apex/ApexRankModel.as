package mvc.module.apex
{
   import com.road.yishi.proto.apex.ApexRankListMsg;
   import com.road.yishi.proto.apex.ApexRankMsg;
   import yishi.utils.HashMap;
   
   public class ApexRankModel
   {
      
      public var selfTeamUid:String;
      
      public var updateTime:String;
      
      public var page:int;
      
      public var totalPage:int;
      
      public var allRankList:Array;
      
      public var groupMap:HashMap;
      
      public var stamp:int;
      
      public var myData:ApexRankTeamData;
      
      public var flag:Boolean;
      
      public function ApexRankModel(param1:ApexRankListMsg)
      {
         super();
         allRankList = [];
         groupMap = new HashMap();
         update(param1);
      }
      
      public function update(param1:ApexRankListMsg) : void
      {
         var _loc3_:ApexRankData = null;
         var _loc2_:Array = null;
         if(!param1)
         {
            return;
         }
         selfTeamUid = param1.selfTeamUid;
         updateTime = param1.updateTime;
         page = param1.page;
         totalPage = param1.totalPage;
         stamp = param1.stamp;
         for each(var _loc4_:ApexRankMsg in param1.allRankList)
         {
            _loc3_ = new ApexRankData(_loc4_);
            for each(var _loc5_:ApexRankTeamData in _loc3_.teamList)
            {
               allRankList.push(_loc5_);
               if(_loc5_.teamUid == selfTeamUid)
               {
                  myData = _loc5_;
               }
            }
            _loc2_ = groupMap.getValue(_loc3_.group) as Array;
            if(!_loc2_)
            {
               _loc2_ = [];
            }
            _loc2_.push(_loc3_);
            groupMap.put(_loc3_.group,_loc2_);
         }
         if(page >= totalPage)
         {
            flag = true;
         }
         else
         {
            flag = false;
         }
      }
      
      public function getGroupAllData(param1:int) : Array
      {
         var _loc2_:Array = groupMap.getValue(param1) as Array;
         var _loc5_:Array = [];
         for each(var _loc3_:ApexRankData in _loc2_)
         {
            for each(var _loc4_:ApexRankTeamData in _loc3_.teamList)
            {
               _loc5_.push(_loc4_);
               if(_loc4_.teamUid == selfTeamUid)
               {
                  myData = _loc4_;
               }
            }
         }
         _loc5_.sortOn("rank",16);
         return _loc5_;
      }
      
      public function get lastUpdateStr() : String
      {
         return updateTime;
      }
   }
}

