package mvc.module.auction
{
   import events.AuctionEvent;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import yishi.utils.GoodsHelp;
   
   public class AuctionModel extends EventDispatcher
   {
      
      public static const BUY_MODULE:int = 0;
      
      public static const SELL_GOODS_MODULE:int = 1;
      
      public static const MY_AUCTION_MODULE:int = 2;
      
      public static const LIMITED_AUCTION_MODULE:int = 3;
      
      public static const SELL_PET_MODULE:int = 4;
      
      private static var _gradeComboData:Array;
      
      private static var _qualityComboData:Array;
      
      private static var _jobComboData:Array;
      
      public var forSaleList:AuctionResultListData;
      
      public var soldList:AuctionResultListData;
      
      public var recordList:AuctionResultListData;
      
      public var currentModulIndex:int;
      
      public function AuctionModel()
      {
         super();
         clear();
      }
      
      public static function getGradeComboData() : Array
      {
         if(!_gradeComboData)
         {
            _gradeComboData = [];
            _gradeComboData.push({
               "id":1,
               "name":"1-10",
               "min":1,
               "max":10
            });
            _gradeComboData.push({
               "id":2,
               "name":"11-20",
               "min":11,
               "max":20
            });
            _gradeComboData.push({
               "id":3,
               "name":"21-30",
               "min":21,
               "max":30
            });
            _gradeComboData.push({
               "id":4,
               "name":"31-40",
               "min":31,
               "max":40
            });
            _gradeComboData.push({
               "id":5,
               "name":"41-50",
               "min":41,
               "max":50
            });
            _gradeComboData.push({
               "id":6,
               "name":"51-60",
               "min":51,
               "max":60
            });
            _gradeComboData.push({
               "id":7,
               "name":"61-70",
               "min":61,
               "max":70
            });
            _gradeComboData.push({
               "id":0,
               "name":LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name01")
            });
         }
         return _gradeComboData;
      }
      
      public static function getQualityComboData() : Array
      {
         if(!_qualityComboData)
         {
            _qualityComboData = [];
            _qualityComboData.push(createQualityMember(1));
            _qualityComboData.push(createQualityMember(2));
            _qualityComboData.push(createQualityMember(3));
            _qualityComboData.push(createQualityMember(4));
            _qualityComboData.push(createQualityMember(5));
            _qualityComboData.push(createQualityMember(6));
            _qualityComboData.push({
               "id":0,
               "name":LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name01")
            });
         }
         return _qualityComboData;
      }
      
      private static function createQualityMember(param1:int) : Object
      {
         var _loc2_:Object = {};
         _loc2_.id = param1;
         _loc2_.name = GoodsHelp.getGoodQualityName(param1);
         return _loc2_;
      }
      
      public static function getJobComboData() : Array
      {
         if(!_jobComboData)
         {
            _jobComboData = [];
            _jobComboData.push({
               "id":1,
               "name":LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name02")
            });
            _jobComboData.push({
               "id":2,
               "name":LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name03")
            });
            _jobComboData.push({
               "id":3,
               "name":LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name04")
            });
            _jobComboData.push({
               "id":0,
               "name":LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name01")
            });
         }
         return _jobComboData;
      }
      
      public function clear() : void
      {
         forSaleList = new AuctionResultListData();
         soldList = new AuctionResultListData();
         recordList = new AuctionResultListData();
      }
      
      public function refreshForSellData() : void
      {
         dispatchEvent(new AuctionEvent(AuctionEvent.REFRESH_FORSELL));
      }
      
      public function refreshRecordData() : void
      {
         dispatchEvent(new AuctionEvent(AuctionEvent.REFRESH_RECORD));
      }
   }
}

