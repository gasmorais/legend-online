package mvc.module.childspiritexpedition
{
   import mvc.module.children.ChildData;
   import yishi.datas.templates.SpiritExpeditionTempInfo;
   import yishi.manager.TempleteManager;
   
   public class SpiritExpeditionModel
   {
      
      public var openMaxAreaId:int;
      
      public var rewardState:String;
      
      public var areaInfoList:Array;
      
      public var childList:Array;
      
      public var enterWarList:Array;
      
      public var tempMapId:int;
      
      public function SpiritExpeditionModel()
      {
         super();
         areaInfoList = [];
         childList = [];
         enterWarList = [];
      }
      
      public function getChapterInfoById(param1:int) : SpiritExpeditionChapterInfo
      {
         for each(var _loc2_:SpiritExpeditionChapterInfo in areaInfoList)
         {
            if(_loc2_.areaId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getChildInfoById(param1:int) : SpiritExpeditionChildInfo
      {
         for each(var _loc2_:SpiritExpeditionChildInfo in childList)
         {
            if(_loc2_.childId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getChildDataByPos(param1:int) : ChildData
      {
         for each(var _loc2_:SpiritExpeditionChildInfo in childList)
         {
            if(_loc2_.pos == param1)
            {
               return _loc2_.childData;
            }
         }
         return null;
      }
      
      public function getChildInfoByJob(param1:int) : SpiritExpeditionChildInfo
      {
         for each(var _loc2_:SpiritExpeditionChildInfo in childList)
         {
            if(_loc2_.childTemp && _loc2_.childTemp.JobType == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get childCdTimeLen() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:SpiritExpeditionChildInfo in childList)
         {
            if(_loc2_.leftCount > 0)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function getPassTotalStarByArea(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc5_:SpiritExpeditionTempInfo = null;
         if(param1 > areaInfoList.length)
         {
            return 0;
         }
         var _loc3_:SpiritExpeditionChapterInfo = getChapterInfoById(param1);
         var _loc6_:Array = TempleteManager.instance.spiritExpeditionTempCate.getChapterListByAreaId(param1);
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc5_ = _loc6_[_loc4_];
            if(_loc3_.passNodeId >= _loc5_.NodeId)
            {
               _loc2_ += _loc5_.Star;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function getTotalStar() : int
      {
         var _loc3_:int = 0;
         var _loc2_:SpiritExpeditionChapterInfo = null;
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < areaInfoList.length)
         {
            _loc2_ = areaInfoList[_loc3_];
            _loc1_ += getPassTotalStarByArea(_loc2_.areaId);
            _loc3_++;
         }
         return _loc1_;
      }
   }
}

